unit LMDSpinButton;
{$I lmdcmps.Inc}

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

LMDSpinButton unit (JH)
-----------------------

Special button to be used in controls currently supports spin button and scroll bar btn styles

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDBase, LMDClass, LMDGraph, LMDUtils, LMDCustomControl, LMDGraphicControl;

const
  def_SPINHOTCOLOR=clTeal;
  type
  TLMDSpinButtonState = (sbUpper, sbUpDown, sbDownDown, sbLeftDown, sbRightDown, sbDisabled);
  TLMDExtSpinBtnStyle = (seSpinEdit, seSpinScrollBar);
  TLMDSingleSpinButton = (sbUp, sbDown, sbLeft, sbRight);
  TLMDButtonPartState = (bpsNormal, bpsHot, bpsPressed, bpsDisabled);
  TLMDSpinButtons = set of TLMDSingleSpinButton;

  {---------------------------- TLMDSpinButton --------------------------------}
  TLMDSpinButton = class(TLMDGraphicControl)
  private
    FTimerId       : TLMDTimer;
    FCache         : TBitmap;
    FDown,
    FLastDown      : TLMDSpinButtonState;
    FExtStyle      : TLMDExtSpinBtnStyle;
    FSkew,
    FDragging      : Boolean;
    FOnLeftClick,
    FOnRightClick,
    FOnTopClick,
    FOnBottomClick : TNotifyEvent;
    FSpinButtons   : TLMDSpinButtons;
    FBtnMode       : Integer;
    FBorderStyle   : TLMDBorderStyle;
    FUpBtnState,
    FDnBtnState,
    FRBtnState,
    FLBtnState    : TLMDButtonPartState;
    FInterval:Word;
    FCacheDim     : TPoint;
    FUpRgn,
    FDnRgn,
    FRightRgn,
    FLeftRgn       : HRGN;
    FUseGlobalTimer: Boolean;
    FHotColor: TColor;
    procedure SetDown(Value: TLMDSpinButtonState);
    procedure SetBtns(aValue: TLMDSpinButtons);
    procedure CreateStates;
    procedure DrawState(btn: TLMDSingleSpinButton; index:Integer);
    function  SimpleMode:Boolean;
    procedure TimerExpired(Sender: TObject);
    procedure SetSkew(const Value: Boolean);
    procedure CMEnabledChanged(var Msg:TMessage); message CM_EnabledChanged;
    procedure WMWINDOWPOSCHANGED(var Msg:TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
  protected
    procedure AddTimer;
    function checkRgn (aRgn: HRGN;var bsVar: TLMDButtonPartState; X,Y : Integer; Shift: TShiftState): boolean;
    procedure DoThemeChanged;override;
    procedure FreeRegions;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
    procedure Paint; override;
    procedure RemoveTimer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure MouseLeave; //can be called from owning control for indicating
                          //that the mouse was moved out of its borders
                          //because this is sometimes not recognized by the
                          //button :-(

    property CtlXP; // compatibility
    property Down: TLMDSpinButtonState read FDown write SetDown default sbUpper;
    property ExtStyle : TLMDExtSpinBtnStyle read FExtStyle write FExtStyle default seSpinEdit;
    property Interval:Word read FInterval write FInterval;
  //published
    property Enabled;
    //property ShowHint;
    //property Transparent;
    property SpinButtons : TLMDSpinButtons read FSpinButtons write SetBtns default [sbUp];
    property OldStyle:Boolean read FSkew write SetSkew default true;
    property Color default clBtnFace;
    property HotColor:TColor read FHotColor write FHotColor default def_SPINHOTCOLOR;
    //property Hint;
    //property ParentShowHint;
    property ParentColor default false;
    property Visible;
    property ThemeMode default ttmPlatform;
    property ThemeGlobalMode;    
    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // ---
    {events}
    property OnBottomClick: TNotifyEvent read FOnBottomClick write FOnBottomClick;
    property OnTopClick: TNotifyEvent read FOnTopClick write FOnTopClick;
    property OnLeftClick: TNotifyEvent read FOnLeftClick write FOnLeftClick;
    property OnRightClick: TNotifyEvent read FOnRightClick write FOnRightClick;

    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
  end;

implementation

uses
  Types, UxTheme, Themes,
  LMDProcs, LMDBevel, LMDGraphUtils, LMDThemes;

{************************* class TLMDSpinButton *******************************}
{-------------------------- private -------------------------------------------}
procedure TLMDSpinButton.SetDown(Value: TLMDSpinButtonState);
var
  OldState: TLMDSpinButtonState;
begin
  OldState := FDown;
  FDown := Value;
  if OldState<>FDown then Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpinButton.SetSkew(const Value: Boolean);
begin
  if FSkew<>Value then
    begin
      FSkew := Value;
      if not (csLoading in ComponentState) then
        RePaint;
        //CreateStates;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSpinButton.SimpleMode: Boolean;
begin
  result:=(FSpinButtons=[sbUp, sbDown]) and (IsThemed or ((FExtStyle=seSpinEdit) and (not FSkew)));
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.SetBtns(aValue : TLMDSpinButtons);

  function CheckIn (val : TLMDSpinButtons) : Boolean;
  begin
    result := true;
    if (sbUp in val) and not (sbUp in FSpinButtons) then result := false;
    if (sbDown in val) and not (sbDown in FSpinButtons) then result := false;
    if (sbLeft in val) and not (sbLeft in FSpinButtons) then result := false;
    if (sbRight in val) and not (sbRight in FSpinButtons) then result := false;
    if not (sbUp in val) and (sbUp in FSpinButtons) then result := false;
    if not (sbDown in val)and (sbDown in FSpinButtons) then result := false;
    if not (sbLeft in val) and (sbLeft in FSpinButtons) then result := false;
    if not (sbRight in val) and (sbRight in FSpinButtons) then result := false;
  end;

begin
  if FSpinButtons = aValue then exit;
  FSpinbuttons := aValue;

  if CheckIn([sbUp]) then FBtnMode := 1; //single up
  if CheckIn([sbUp, sbDown]) then FBtnMode := 2; //up and down
  if CheckIn([sbUp, sbLeft]) then FBtnMode := 3;
  if CheckIn([sbUp, sbRight]) then FBtnMode := 4;

  if CheckIn([sbUp, sbDown, sbLeft]) then FBtnMode := 5;
  if CheckIn([sbUp, sbDown, sbRight]) then FBtnMode := 6;
  if CheckIn([sbUp, sbLeft, sbRight]) then FBtnMode := 7;

  if CheckIn([sbUp, sbDown, sbLeft, sbRight]) then FBtnMode := 8;

  if CheckIn([sbDown]) then FBtnMode := 9; //single down
  if CheckIn([sbDown, sbRight]) then FBtnMode := 10;
  if CheckIn([sbDown, sbLeft]) then FBtnMode := 11;
  if CheckIn([sbDown, sbRight, sbLeft]) then FBtnMode := 12;

  if CheckIn([sbLeft]) then FBtnMode := 13; //single left
  if CheckIn([sbLeft, sbRight]) then FBtnMode := 14;
  if CheckIn([sbRight]) then FBtnMode := 15; //single right

  Repaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.TimerExpired(Sender: TObject);
begin
  if not Assigned(FTimerId) then exit;
  FTimerID.Interval:=FInterval;
  if MouseCapture then
    try
      if FUpBtnState = bpsPressed then if Assigned(FOnTopClick) then FOnTopClick(Self);
      if FDnBtnState = bpsPressed then if Assigned(FOnBottomClick) then FOnBottomClick(Self);
      if FRBtnState = bpsPressed then if Assigned(FOnRightClick) then FOnRightClick(Self);
      if FLBtnState = bpsPressed then if Assigned(FOnLeftClick) then FOnLeftClick(Self);
    except
      RemoveTimer;
      raise;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.CMEnabledChanged(var Msg:TMessage);
begin
  inherited;
  //0: normal behavior - enable/disable all buttons
  //1,2: enable/disable only one button depending on which boundary is reached 
  case Msg.WParam of
    0: begin
       if not Enabled then
         begin
           FUpBtnState:= bpsDisabled;
           FDnBtnState:= bpsDisabled;
           FRBtnState := bpsDisabled;
           FLBtnState := bpsDisabled;
         end
       else
         begin
           FUpBtnState:= bpsNormal;
           FDnBtnState:= bpsNormal;
           FRBtnState := bpsNormal;
           FLBtnState := bpsNormal;
         end;
       end;
    1: begin
         FDnBtnState := TLMDButtonPartState(Msg.LParam);
         FLBtnState := FDnBtnState;
       end;
    2: begin
         FUpBtnState := TLMDButtonPartState(Msg.LParam);
         FRBtnState := FUpBtnState;
       end;
  end;
  Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpinButton.WMWINDOWPOSCHANGED(var Msg:TWMWindowPosChanged);
begin
  inherited;
  // here wouldbe best place for CreateStates, with some opimization
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDSpinButton.DoThemeChanged;
begin
  inherited;
  FCache.Canvas.Brush.Style := bsSolid;
  FCache.Canvas.Brush.Color := clWhite;
  FCache.Canvas.FillRect(Rect(0,0,FCache.Width, FCache.Height));
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSpinButton.Paint;
var
  i : TLMDSingleSpinButton;
//  myRgn,
  aH : HRGN;
  bs: TLMDButtonPartState;
  aR2,
  aR: TRect;
  aBmp: TBitmap;

  function RelOrd (aVal: TLMDSingleSpinButton): Integer;
  var
    i: TLMDSingleSpinButton;
  begin
    result := 0;
    for i := Low (TLMDSingleSpinButton) to High (TLMDSingleSpinButton) do
      begin
        if i = aVal then exit;
        if i in FSpinButtons then inc(result);
      end;
  end;

begin
  // Paint only if required
  if Assigned(Parent) and (not Parent.Showing or ([csLoading, csReading, csDestroying]*Parent.ComponentState<>[])) then exit;

  // ---------------------
  try
    if not Enabled and not (csDesigning in ComponentState) then
      FDragging := False;

    //if BackBitmapCheck then
    //  BackDrawArea(Canvas, Rect(0,0, Width,Height), BackMapPoint(Point(0, 0)), 0);

    // 7.0 --> Call CreateStates only if substantial changes have occured
  // if (Width<>FCacheDim.X) or (Height<>FCacheDim.Y) then //--> Why?
      CreateStates;

    for i := Low (TLMDSingleSpinButton) to High (TLMDSingleSpinButton) do
      if i in FSpinButtons then
        begin
          case i of
            sbUp   : begin aH := FUpRgn; bs := FUpBtnState; end;
            sbDown : begin aH := FDnRgn; bs := FDnBtnState; end;
            sbRight: begin aH := FRightRgn; bs := FRBtnState; end;
            sbLeft : begin aH := FLeftRgn; bs := FLBtnState; end;
          else
            // make compiler happy
            begin ah:=HRGN(0); aR:=Rect(0,0,0,0); bs := FUpBtnState; end;
          end;

          GetRgnBox (aH, aR);

          // 7.0
          if SimpleMode then
            begin
               aR2 :=  Rect (RelOrd (i) * Width * 4 + Width * Ord (bs), 0,
                             RelOrd (i) * Width * 4 + Width * (Ord (bs) + 1), Height DIV 2);
               OffsetRect (aR, -Left, -Top);
               Canvas.CopyRect(aR, FCache.Canvas, ar2);
               Continue;
            end;
          // ---

          aBmp := TBitmap.Create;
          try
            aBmp.Width := Width;
            if SimpleMode then
              aBmp.Height := Height div 2
            else
              aBmp.Height := Height;
            aR2 :=  Rect (RelOrd (i) * Width * 4 + Width * Ord (bs), 0,
                          RelOrd (i) * Width * 4 + Width * (Ord (bs) + 1), Height);
            aBmp.Canvas.CopyRect (Rect (0, 0, Width, Height),
                                  FCache.Canvas,
                                  ar2);

            OffsetRect (aR, -Left, -Top);
            SelectClipRgn (self.Canvas.Handle, aH);
            Canvas.StretchDraw(aR, aBmp);
            SelectClipRgn (self.Canvas.Handle, 0);
          finally
            aBmp.Free;
          end;
        end;
  finally
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.FreeRegions;

  procedure FreeRegion (var aRegion: HRGN);
  begin
    DeleteObject (aRegion);
    aRegion := 0;
  end;

begin
  if FUpRgn <> 0 then FreeRegion (FUpRgn);
  if FDnRgn <> 0 then FreeRegion (FDnRgn);
  if FLeftRgn <> 0 then FreeRegion (FLeftRgn);
  if FRightRgn <> 0 then FreeRegion (FRightRgn);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.CreateStates;
var
  i     : Integer;
  p : Array[0..2] of TPoint;
  lThemeMode : TLMDThemeMode;

  function GetNumButtonParts: Integer;
  var
    i: TLMDSingleSpinButton;
  begin
    result := 0;
    for i := Low (TLMDSingleSpinButton) to High (TLMDSingleSpinButton) do
      if i in FSpinButtons then inc(result);
  end;

  procedure drawScrollThemePart (aRect: TRect; stateIdBase: TThemedScrollBar);
  var
    stateId : TThemedScrollBar;
    bRect   : TRect;
  begin
    for stateId := stateIdBase to TThemedScrollbar(Ord(stateIdBase) + 3) do
      begin
        bRect := Bounds (aRect.Left + (Ord(stateId)-ord(stateIdBase)) * aRect.Right, aRect.Top, aRect.Right, aRect.Bottom);
        LMDThemeservices.DrawElement(lThemeMode, FCache.Canvas.Handle, stateID, bRect);
      end;
  end;

  procedure drawSpinThemePart (aRect: TRect; stateIdBase: TThemedSpin);
  var
    stateId: TThemedSpin;
    bRect  : TRect;
  begin
    //draw the four button states
    for stateId := stateIdBase to TThemedSpin(Ord(stateIDBase)+ 3) do
      begin
        //calc rect for next button state
        bRect := Bounds (aRect.Left + (Ord(stateId)-ord(stateIdBase))* Width, aRect.Top, Width, aRect.Bottom);
        //draw the state
        LMDThemeservices.DrawElement(lThemeMode, FCache.Canvas.Handle, stateID, bRect);
      end;
  end;

  procedure DoFrame(aRect:TRect; Pressed:Boolean);
  begin
    if Pressed then
      begin
        DrawEdge(FCache.Canvas.Handle, aRect, BDR_SUNKENOUTER, BF_RECT);
        DrawEdge(FCache.Canvas.Handle, aRect, BDR_SUNKENINNER, BF_TOPLEFT);
      end
    else
      begin
        DrawEdge(FCache.Canvas.Handle, aRect, BDR_RAISEDOUTER, BF_SOFT or BF_RECT or BF_ADJUST);
        DrawEdge(FCache.Canvas.Handle, aRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      end;
  end;

  procedure DrawStates(Mode: TLMDSingleSpinButton; aRect:TRect);
  var
    k:TLMDButtonPartState;
    tmpR:TRect;
    tmpc:TColor;
  begin
    for k:=Low(TLMDButtonPartState) to High(TLMDButtonPartState) do  // (bpsNormal, bpsHot, bpsPressed, bpsDisabled);
      begin
        tmpr:=Rect(aRect.Left+Ord(k)*FCacheDim.X, 0, aRect.Left+(Ord(k)+1)*FCacheDim.X, aRect.Bottom);
        DoFrame(tmpr, k=bpsPressed);
        if k=bpsHot then tmpc:=FHotColor else tmpc:=clBlack;
        LMDDrawTriangle(FCache.Canvas, tmpr.Left+(Width DIV 2)-1-Ord(Mode), (aRect.Bottom DIV 2)-2, 3, tmpc, Mode=sbDown, k<>bpsDisabled);
      end;
  end;

begin
  FreeRegions;
  lThemeMode := UseThemeMode;

  //FCache
  //# states (hot, normal, ... ) glyph for each button part
  //e.g. up/dn btn has 2 button parts
  //e.g. up/dn/right has 3 button parts

  //amount = ButtonStates (4) * number of button parts * number of buttons
  FCache.Width:=4 * (Width) {Width = ButtonWidth} * GetNumButtonParts;
  FCache.Height:=Height;

  // store dimensions for comparision in Paint method
  FCacheDim:=Point(Width, Height);

  //create simple region
  if ([sbUp] = FSpinButtons) then
    FUpRgn := CreateRectRgn (0, 0, Width, Height);

  if ([sbDown] = FSpinButtons) then
    FDnRgn := CreateRectRgn (0, 0, Width, Height);

  if ([sbLeft] = FSpinButtons) then
    FLeftRgn := CreateRectRgn (0, 0, Width, Height);

  if ([sbRight] = FSpinButtons) then
    FRightRgn := CreateRectRgn (0, 0, Width, Height);

  //create regions for buttons with two parts (up, down or left, right or ...)
  if ([sbUp, sbDown] = FSpinButtons) then
    if not FSkew or (lThemeMode <> ttmNone) then //simple up down
      begin
        FUpRgn := CreateRectRgn (0, 0, Width, Height div 2 +(Height MOD 2)-1); //VB May 2010
        FDnRgn := CreateRectRgn (0, Height div 2 +(Height MOD 2), Width, Height);
      end
    else
      begin  //triangle look a like buttons
        //create triangle regions ... (to be done)
        p[0] := Point (0, Height);
        p[1] := Point (Width, 0);
        p[2] := Point (0, 0);
        FUpRgn := CreatePolygonRgn (p, 3, ALTERNATE);
        p[0] := Point (0, Height);
        p[1] := Point (Width, Height);
        p[2] := Point (Width, 0);
        FDnRgn := CreatePolygonRgn (p, 3, ALTERNATE);
      end;

  if FUpRgn <> 0 then OffSetRgn (FUpRgn, Left, Top);
  if FDnRgn <> 0 then OffSetRgn (FDnRgn, Left, Top);
  if FLeftRgn <> 0 then OffSetRgn (FLeftRgn, Left, Top);
  if FRightRgn <> 0 then OffSetRgn (FRightRgn, Left, Top);

  if (lThemeMode<>ttmNone) or SimpleMode then
    begin
      case FExtStyle of
        seSpinScrollBar :
          begin
            i := -1;
            if sbUp in FSpinButtons then
              drawScrollThemePart (Rect (Width * LMDInc(i), 0, (Width) * (i + 1), Height), tsArrowBtnUpNormal);
            if sbDown in FSpinButtons then
              drawScrollThemePart (Rect (Width * LMDInc(i), 0, (Width) * (i + 1), Height), tsArrowBtnDownNormal);
            if sbRight in FSpinButtons then
              drawScrollThemePart (Rect (Width * LMDInc(i), 0, (Width) * (i + 1), Height), tsArrowBtnRightNormal);
            if sbLeft in FSpinButtons then
              drawScrollThemePart (Rect (Width * LMDInc(i), 0, (Width) * (i + 1), Height), tsArrowBtnLeftNormal);
          end;
        seSpinEdit :
          begin
            FCache.Height:=(Height div 2);
            if (lThemeMode<>ttmNone) then
              begin
                i := -1;
                if sbUp in FSpinButtons then
                  drawSpinThemePart (Bounds (4 * Width * LMDInc(i), 0, 4 * Width * (i + 1), FCache.Height), tsUpNormal);
                if sbDown in FSpinButtons then
                  drawSpinThemePart (Bounds (4 * Width * LMDInc(i), 0, 4 * Width * (i + 1), FCache.Height), tsDownNormal);
                if sbRight in FSpinButtons then
                  drawSpinThemePart (Bounds (4 * Width * LMDInc(i), 0, 4 * Width * (i + 1), FCache.Height), tsUpHorzNormal);
                if sbLeft in FSpinButtons then
                  drawSpinThemePart (Bounds (4 * Width * LMDInc(i), 0, 4 * Width * (i + 1), FCache.Height), tsDownHorzNormal);
              end
            else
              begin  // supports currently SimpleMode only
                FCache.Canvas.Brush.Color:=self.Color;
                FCache.Canvas.FillRect(Rect(0,0,FCache.Width, FCache.Height));
                DrawStates(sbUp, Rect(0,0, FCache.Width DIV 2, FCache.Height));
                DrawStates(sbDown, Rect((FCache.Width DIV 2),0, FCache.Width, FCache.Height));
              end;
          end;
      end;
      exit;
    end;

  //draw the different states
  i := -1;
  if sbUp in FSpinButtons then DrawState(sbUp, LMDInc(i));
  if sbDown in FSpinButtons then DrawState(sbDown, LMDInc(i));
  if sbLeft in FSpinButtons then DrawState(sbLeft, LMDInc(i));
  if sbRight in FSpinButtons then DrawState(sbRight, LMDInc(i));
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.DrawState(btn:TLMDSingleSpinButton; index: Integer);
var
  Re       : TRect;
  FHeight,
  FWidth   : Integer;
  tmp      : TBitmap;
  bps      : TLMDButtonPartState;

  function getColor: TColor;
  begin
    case bps of
      bpsHot: result := FHotColor;
      bpsDisabled: result := clGray;
    else
      result := clBlack;
    end;
  end;

  procedure DrawLeft (Canvas : TCanvas;x,y,s : Integer);
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := getColor;
    Canvas.Pen.Color := getColor;
    Canvas.PolyLine ([Point(x,y),Point(x+s, y-s),Point(x+s, y+s),Point(x,y)]);
    Canvas.FloodFill (x +1, y, getColor, fsBorder);
  end;

  procedure DrawRight (Canvas : TCanvas;x,y,s : Integer);
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := getColor;
    Canvas.Pen.Color := getColor;
    Canvas.PolyLine ([Point(x,y),Point(x-s, y-s),Point(x-s, y+s),Point(x,y)]);
    Canvas.FloodFill (x -1, y, getColor, fsBorder);
  end;

begin

  for bps := Low(TLMDButtonPartState) to High (TLMDButtonPartState) do
    begin

      //create temporary bitmap for btn image
      tmp := TBitmap.Create;
      try
        tmp.Height:=Height;
        tmp.Width:=Width;
        tmp.Canvas.Brush.Color := Color;
        tmp.Canvas.Brush.Style := bsSolid;
        //fill background of temp button image
        tmp.Canvas.FillRect (Rect (0,0,Width, Height));

        if self.ExtStyle = seSpinScrollBar then
          Re := Rect (0,0,Width, Height-1)
        else
          Re := Rect (0,0,Width-1, Height-1);

        //frame the image

        if bps <> bpsPressed then
          LMDDrawStdFrame (tmp.Canvas, Re, FBorderStyle, 0)
        else
          LMDDrawStdFrame (tmp.Canvas, Re, lsLowered, 0);

        FHeight := Re.Bottom - Re.Top;
        FWidth := Re.Right - Re.Left;

        with tmp do
          begin
            // *************** Single button: Up
            if FSpinButtons = [sbUp] then
              begin
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/2)-2),
                              Re.Top + Round((FHeight/2)-2),
                              3, getColor, false, bps<>bpsDisabled);
              end;
            // *************** Single button: Down
            if FSpinButtons = [sbDown] then
              begin
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/2)-3),
                              Re.Top + Round((FHeight/2)-2),
                              3, getColor, true, bps<>bpsDisabled);
              end;
            // *************** Single button: Left
            if FSpinButtons = [sbLeft] then
              begin

                DrawLeft (Canvas,
                          Re.Left + Round((FWidth/2)-2),
                          Re.Top + Round((FHeight/2)-1),2);
              end;
            // *************** Single button: Right
            if FSpinButtons = [sbRight] then
              begin
                DrawRight (Canvas,
                              Re.Left + Round((FWidth/2)),
                              Re.Top + Round((FHeight/2)-1),2);
              end;
            // *************** Double button: Up / Down
            if FSpinButtons = [sbUp, sbDown] then
              if FSkew then
                begin
                  if btn = sbUp then
                    begin
                      LMDDrawTriangle(Canvas,
                                  Re.Left + Round((FWidth/4)-2),
                                  Re.Top + Round((FHeight/4)-2),
                                  3, getColor, false, bps<>bpsDisabled);

                      if bps = bpsPressed then
                        begin
                          Canvas.Pen.Color := clGray;

                          Canvas.MoveTo (Re.Right - 1, Re.Top);
                          Canvas.LineTo (Re.Left, Re.Bottom - 1); //diag up button
                        end;

                      Canvas.MoveTo (Re.Right - 1 {!!}, Re.Top);

                      if bps = bpsPressed then
                        Canvas.Pen.Color := clWhite
                      else
                        Canvas.Pen.Color := clLtGray;

                      Canvas.LineTo (Re.Left - 1, Re.Bottom); //diag up button
                    end
                  else
                    begin
                      //down button

                      LMDDrawTriangle(Canvas,
                                  Re.Left + Round((3*FWidth/4)-2),
                                  Re.Top + Round((3*FHeight/4)-2),
                                  3, getColor, true, bps<>bpsDisabled);

                      if bps = bpsPressed then
                        Canvas.Pen.Color := clWhite
                      else
                        Canvas.Pen.Color := clGray;

{                      Canvas.MoveTo (Re.Left, Re.Bottom);
                      Canvas.LineTo (Re.Right, Re.Bottom); //left side up btn
                      Canvas.LineTo (Re.Right, Re.Top); //top side up btn}

                      if bps = bpsPressed then
                        Canvas.Pen.Color := clGray
                      else
                        Canvas.Pen.Color := clWhite;
                      Canvas.MoveTo (Re.Right, Re.Top - 1);
                      Canvas.LineTo (Re.Left - 1, Re.Bottom); //diag up button

                      if bps = bpsPressed then
                        begin
                          Canvas.Pen.Color := clLtGray;
                          Canvas.MoveTo (Re.Right, Re.Top);
                          Canvas.LineTo (Re.Left, Re.Bottom); //diag up button
                        end;
                    end;
                end
            end; //end of with tmp do
(*        with tmp do
          case FBtnMode of
            1 : //single up
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/2)-2),
                              Re.Top + Round((FHeight/2)-2),
                              3, getColor, false, bps<>bpsDisabled);
            2 : begin // up and down
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((FHeight/4)-2),
                              3, getColor, false, bps<>bpsDisabled);
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((3*FWidth/4)-2),
                              Re.Top + Round((3*FHeight/4)-2),
                              3, getColor, true, bps<>bpsDisabled);
                end;
            3 : begin //left and up
                LMDDrawTriangle(Canvas,
                              Re.Left + Round(3*(FWidth/4)-2),
                              Re.Top + Round((FHeight/4)-2),
                              3, getColor, false, bps<>bpsDisabled);
                DrawLeft (Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((3*FHeight/4)-2),2);
                end;
            4 : begin //up and right
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((FHeight/4)-2),
                              3, getColor, false, bps<>bpsDisabled);
                DrawRight (Canvas,
                              Re.Left + Round((3*FWidth/4)-2),
                              Re.Top + Round((3*FHeight/4)-2),2);
                end;
            5 : begin //left and up and down
                DrawLeft (Canvas,
                          Re.Left + Round((FWidth/4)-2),
                          Re.Top + Round((FHeight/2)),2);
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((3*FWidth/4)-2),
                              Re.Top + Round((FHeight/4)-2),
                              3, getColor, false, bps<>bpsDisabled);
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((3*FWidth/4)-2),
                              Re.Top + Round((3*FHeight/4)-2),
                              3, getColor, true, bps<>bpsDisabled);
                end;
            6 : begin //up and down and right
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((FHeight/4)-2),
                              3, getColor, false, bps<>bpsDisabled);
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((3*FHeight/4)-2),
                              3, clBlack, true, bps<>bpsDisabled);
                DrawRight (Canvas,
                              Re.Left + Round((3*FWidth/4)-2),
                              Re.Top + Round((FHeight/2)),2);
                end;
            7 : begin //sbUp and sbLeft and sbRight
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((FHeight/2)-2),
                              3, getColor, false, bps<>bpsDisabled);
                DrawLeft (Canvas,
                              Re.Left + Round((3*FWidth/4)-2),
                              Re.Top + Round((FHeight/4)-2),2);
                DrawRight (Canvas,
                              Re.Left + Round((3*FWidth/4)),
                              Re.Top + Round((3*FHeight/4)),2);
                end;
            8 : begin //all
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/2)-1),
                              Re.Top + Round((FHeight/4)-2),
                              3, getColor, false, bps<>bpsDisabled);
                DrawLeft (Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((FHeight/2)),2);
                DrawRight (Canvas,
                              Re.Left + Round((3*FWidth/4)+2),
                              Re.Top + Round((FHeight/2)),2);
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/2)-1),
                              Re.Top + Round((3*FHeight/4)),
                              3, getColor, true, bps<>bpsDisabled);
                end;
            9 : //single down
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/2)-3),
                              Re.Top + Round((FHeight/2)-2),
                              3, getColor, true, bps<>bpsDisabled);
           10 : begin //down and right
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round(3*(FHeight/4)-2),
                              3, getColor, true, bps<>bpsDisabled);
                DrawRight (Canvas,
                              Re.Left + Round((3*FWidth/4)-2),
                              Re.Top + Round((FHeight/4)-2),2);
                end;
           11 : begin //down and left
                LMDDrawTriangle(Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round(3*(FHeight/4)-2),
                              3, getColor, true, bps<>bpsDisabled);
                DrawLeft (Canvas,
                              Re.Left + Round(3*(FWidth/4)-2),
                              Re.Top + Round((FHeight/4)),2);
                end;
           12 : begin //down and right and left
                LMDDrawTriangle(Canvas,
                              Re.Left + Round(3*(FWidth/4)-2),
                              Re.Top + Round((FHeight/2)-2),
                              3, getColor, true, bps<>bpsDisabled);
                DrawLeft (Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((FHeight/4)),2);
                DrawRight (Canvas,
                              Re.Left + Round((FWidth/4)),
                              Re.Top + Round(3*(FHeight/4)-2),2);
                end;
           13 : //single left
                DrawLeft (Canvas,
                          Re.Left + Round((FWidth/2)-2),
                          Re.Top + Round((FHeight/2)-1),2);
           14 : begin //left and right
                DrawLeft (Canvas,
                              Re.Left + Round((FWidth/4)-2),
                              Re.Top + Round((FHeight/4)),2);
                DrawRight (Canvas,
                              Re.Left + Round(3*(FWidth/4)),
                              Re.Top + Round(3*(FHeight/4)-2),2);
                end;
           15 : //single right
                DrawRight (Canvas,
                              Re.Left + Round((FWidth/2)),
                              Re.Top + Round((FHeight/2)-1),2);
          end;
(*        with tmp do
          case FBtnMode of
            1, 9, 13, 15: //single buttons
                begin
                  if State in [sbUpDown, sbDownDown, sbLeftDown, sbRightDown] then
                    begin
                      Re := Rect (0,0,Width, Height);
                      LMDDrawStdFrame (tmp.Canvas, Re, lsLowered, 0);
                    end;
                end;
            2, 4, 14 : //2 = up / down
                begin


                    begin

                      //up button
                      if State = sbUpDown then
                        Canvas.Pen.Color := clGray
                      else
                        Canvas.Pen.Color := clWhite;

                      Canvas.MoveTo (Re.Left-1, Re.Bottom);
                      Canvas.LineTo (Re.Left-1, Re.Top-1); //left side up btn
                      Canvas.LineTo (Re.Right, Re.Top-1); //top side up btn

                      if State = sbUpDown then
                        Canvas.Pen.Color := clWhite
                      else
                        Canvas.Pen.Color := clGray;

                      Canvas.LineTo (Re.Left, Re.Bottom); //diag up button

                      //down button

                      if State = sbDownDown then
                        Canvas.Pen.Color := clWhite
                      else
                        Canvas.Pen.Color := clGray;

                      Canvas.MoveTo (Re.Left + 1, Re.Bottom);
                      Canvas.LineTo (Re.Right, Re.Bottom); //left side up btn
                      Canvas.LineTo (Re.Right, Re.Top + 1); //top side up btn

                      if State = sbDownDown then
                        Canvas.Pen.Color := clGray
                      else
                        Canvas.Pen.Color := clWhite;

                      Canvas.LineTo (Re.Left + 1, Re.Bottom); //diag up button

                    end;
                end;
            3, 10, 11 :
                begin
                  Canvas.MoveTo (0,0);
                  Canvas.LineTo (Width, Height);
                end;
            6, 12 : begin
                  Canvas.MoveTo (Width, 0);
                  Canvas.LineTo (Width div 3, Height div 2);
                  Canvas.Lineto (0, Height div 2);
                  Canvas.MoveTo (Width div 3, Height div 2);
                  Canvas.LineTo (Width, Height);
                end;
            5, 7 :
                begin
                  Canvas.MoveTo (0,0);
                  Canvas.LineTo (Width - (Width div 3), Height div 2);
                  Canvas.LineTo (Width, Height div 2);
                  Canvas.MoveTo (Width - (Width div 3), Height div 2);
                  Canvas.LineTo (0, Height);
                end;
            8 :
                begin
                  Canvas.Pen.Color := clWhite;
                  Canvas.MoveTo (Re.Left+1, Re.Top);
                  Canvas.LineTo (Re.Left + FWidth div 2, Re.Top + FHeight div 2 - 1);

                  Canvas.MoveTo (Re.Right, Re.Top + 1);
                  Canvas.LineTo (Re.Left + FWidth div 2 + 1, Re.Top + FHeight div 2 + 1);

                  Canvas.Pen.Color := clGray;
                  Canvas.MoveTo (Re.Left, Re.Top + 1);
                  Canvas.LineTo (Re.Left + FWidth div 2, Re.Top + FHeight div 2 + 1);
                  Canvas.MoveTo (Re.Right - 1, Re.Top);
                  Canvas.LineTo (Re.Left + FWidth div 2, Re.Top + FHeight div 2);
    {              Canvas.MoveTo (Re.Left, Re.Bottom-1);
                  Canvas.LineTo (Re.Right-1,Re.Top+1);}
                  Canvas.Pen.Color := clBlack;
                  Canvas.MoveTo (Re.Left, Re.Top);
                  Canvas.LineTo (Re.Right, Re.Bottom);
                  Canvas.MoveTo (Re.Left, Re.Bottom);
                  Canvas.LineTo (Re.Right, Re.Top);
                end;
        end;*)
        {copy bitmap in internal cache}
        FCache.Canvas.CopyRect(Rect(Ord(bps)*tmp.Width + index * tmp.Width * 4, 0,
                                   (Ord(bps)+1)*tmp.Width + index * tmp.Width * 4, FCache.Height),
                               tmp.Canvas, Rect(0,0, tmp.Width, tmp.Height));
      finally
        tmp.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
//used internal for determining region a coordinate (X, Y) is located in
function TLMDSpinButton.checkRgn (aRgn: HRGN;var bsVar: TLMDButtonPartState; X,Y : Integer; Shift: TShiftState): boolean;
var
  check: TLMDButtonPartState;
begin
  check := bsVar; //remeber old value
  if not Enabled then
    bsVar := bpsDisabled
  else
    //condition (bsVar <> bpsDisabled) added for autodisable on bounds [VB Apr 2009] 
    if (aRgn <> 0) and (bsVar <> bpsDisabled) then
      begin
        if PtInRegion (aRgn, X + Left, Y + Top) then
          if ssLeft in Shift then
            bsVar := bpsPressed
          else
            bsVar := bpsHot
        else
          bsVar := bpsNormal;
      end;
  //return true if the button part state has been changed
  if check <> bsVar then result := true else result := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);

  {CH function aboveLine (Points: array of TPoint) : boolean;
  var
    hr : HRGN;
  begin
    hr := CreatePolygonRgn (Points, High(Points)+1, ALTERNATE);
    result := PtInRegion (hr, x, y);
    DeleteObject (hr);
  end; }

begin
  inherited MouseDown(Button, Shift, X, Y);

  if (Button=mbLeft) and Enabled then
    begin
      if checkRgn (FUpRgn, FUpBtnState, X, Y, Shift) then if Assigned(FOnTopClick) then FOnTopClick(Self);
      if checkRgn (FDnRgn, FDnBtnState, X, Y, Shift) then if Assigned(FOnBottomClick) then FOnBottomClick(Self);
      if checkRgn (FLeftRgn, FLBtnState, X, Y, Shift) then if Assigned(FOnLeftClick) then FOnLeftClick(Self);
      if checkRgn (FRightRgn, FRBtnState, X, Y, Shift) then if Assigned(FOnRightClick) then FOnRightClick(Self);

      AddTimer;
      FTimerID.Interval:=FInterval+200;
      Paint;
      {
      if FDown=sbUpper then
        begin
          FLastDown := FDown;

          //get the clicked part

          case FBtnMode of
            1 : FDown := sbUpDown;
            2 : if aboveLine ([Point(0,0), Point(0, Height), Point (Width, 0)]) then
                  FDown := sbUpDown
                else
                  FDown := sbDownDown;
            9 : FDown := sbDownDown;
           13 : FDown := sbLeftDown;
           15 : FDown := sbRightDown;
          end;

          case FDown of
            sbDownDown : ;
            sbUpDown : ;
            sbLeftDown : i;
            sbRightDown : ;
          end;

          if FLastDown <> FDown then
            begin
              FLastDown := FDown;
              Paint;
            end;

        end;
      FDragging := True;}
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.MouseMove(Shift: TShiftState; X, Y: Integer);
{var
  NewState: TLMDSpinButtonState;}

var
  changed: boolean;

begin
  inherited MouseMove(Shift, X, Y);

  changed := false;

  changed := changed or checkRgn (FUpRgn, FUpBtnState, X, Y, Shift);
  changed := changed or checkRgn (FDnRgn, FDnBtnState, X, Y, Shift);
  changed := changed or checkRgn (FLeftRgn, FLBtnState, X, Y, Shift);
  changed := changed or checkRgn (FRightRgn, FRBtnState, X, Y, Shift);

  if changed then Paint;

  exit;

  if FDragging then
    if PtInRect(ClientRect, Point(X,Y)) then
      begin
        //NewState:=FDown;
{        if Y>(-(Width/Height)*X + Height) then
          begin
            if (FDown<>sbBottomDown) then
              begin
                if FLastDown = sbBottomDown then
                  FDown := sbBottomDown
                else
                  FDown := sbUp;
                if NewState<>FDown then Paint;
              end;
          end
        else
          begin
            if (FDown<>sbTopDown) then
              begin
                if (FLastDown = sbTopDown) then
                  FDown:=sbTopDown
                else
                  FDown:=sbUp;
                if NewState<>FDown then Paint;
              end;
           end;}
      end
    else
      if FDown<>sbUpper then
        begin
          FDown:=sbUpper;
          Paint;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
    begin
      FDragging := False;
      if PtInRect(ClientRect,Point(X,Y)) then
        begin
          FDown:=sbUpper;
          FLastDown:=sbUpper;
          RemoveTimer;
          Paint;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.AddTimer;
begin
  if Assigned(FTimerID) then exit;
  {get a global timer-id}
  FTimerId:=TLMDTimer.Create(FInterval+200, TimerExpired, true, FUseGlobalTimer);
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.RemoveTimer;
begin
  if not Assigned(FTimerID) then exit;
  FTimerId.Enabled:= false;
  FreeAndNil(FTimerID);
end;

{------------------------------ public ----------------------------------------}
constructor TLMDSpinButton.Create(AOwner: TComponent);
begin
  FCache:=TBitmap.Create;
  inherited Create(AOwner);
  FThemeMode := ttmPlatform;
  FSkew:=True;
  FInterval:=100;
  FDown:=sbUpper;
  FLastDown:=sbUpper;
  Height:=20;
  Width:=20;
  FSpinButtons := [sbUp];
  FTimerId := nil;
  FHotColor:=def_SPINHOTCOLOR;
  FExtStyle := seSpinEdit;
  FBorderStyle := lsSingleRaised;

  FUpRgn := 0;
  FDnRgn := 0;
  FLeftRgn := 0;
  FRightRgn := 0;
  FUpBtnState := bpsNormal;
  FDnBtnState := bpsNormal;
  FRBtnState  := bpsNormal;
  FLBtnState  := bpsNormal;
end;

{------------------------------------------------------------------------------}
destructor TLMDSpinButton.Destroy;
begin
  FreeRegions;
  RemoveTimer;
  FreeAndNil(FCache);
  //FreeXPThemeHandles;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDSpinButton.MouseLeave;
begin
  MouseMove ([], -1, -1);
end;

end.
