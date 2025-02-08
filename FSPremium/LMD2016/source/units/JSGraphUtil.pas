{ Summary
  Contains extended functions for dealing with graphics.
  Description
  The JSGraphUtil unit contains classes and methods that are
  graphics related.                                          }
unit JSGraphUtil;

interface

{$I lmddlgcmps.inc}

uses
    Windows
  , Graphics
  ;

{$IFNDEF BDS}
type
  {$IFDEF DELPHI5}
  { Specify the direction for which the element being drawn
    should face.                                            }
  TScrollDirection = (sdLeft, { Summary
    Drawn with the arrow pointing left. }
   sdRight, { Summary
     Drawn with the arrow pointing right. }
    sdUp, { Summary
      Drawn with the arrow pointing up. }
     sdDown { Summary
    Drawn with the arrow pointing downwards. }
  );
  { Specify the type of arrow to draw. }
  TArrowType = (atSolid, { Draw a single arrow. }
   atArrows { Draw two smaller arrows. }
  );
  {$ENDIF DELPHI5}

  { Specifies the direction to draw a gradient. }
  TGradientDirection = (gdHorizontal, { Summary
    Draws the gradient left to right. }
   gdVertical { Summary
     Draws the gradient from top to bottom. }
   );
{$ENDIF BDS}

{ Function to draw the roundrect style that accepts a TRect type parameter. }
procedure RoundRect(aCanvas: TCanvas; aRect: TRect; aCX, aCY: Integer; const aColor: TColor = clNone;
  const aBrushStyle: TBrushStyle = bsClear);{$IFDEF INLINE}inline;{$ENDIF INLINE}
{ Summary
  Determines that a TPicture contains a valid picture.
  Description
  Returns True when the passed in TPicture parameter contains a valid graphic format.

  Also works correctly when nil is passed in. }
function ValidPicture(APicture: TPicture): Boolean; {$IFDEF INLINE}inline;{$ENDIF}
{ Summary
  Determines whether a TIcon contains a valid icon.
  Description
  Returns True when the passed in Icon contains a valid icon.

  Also works correctly when nil is passed in. }
function ValidIcon(AIcon: TIcon): Boolean; {$IFDEF INLINE}inline;{$ENDIF}
{$IFDEF DELPHI5}
{ Summary
  Draws an icon on the canvas specified.
  Description
  Draws an icon on the specified canvas in the direction requested. Change the size of the
  drawn arrow by increasing the value of the Size parameter. }
procedure DrawArrow(ACanvas: TCanvas; Direction: TScrollDirection;
  Location: TPoint; Size: Integer);
{$ENDIF DELPHI5}
{$IFNDEF BDS}
{ Summary
  Draws a gradient on the canvas specified.
  Description
  Draws a gradient on the specified canvas in the direction requested. }
procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
{$ENDIF BDS}

implementation

uses
  {$IFNDEF BDS}
    Math, 
  {$ENDIF}
  {$IFNDEF DELPHI5}
    Types
  {$ELSE}
    Classes
  {$ENDIF DELPHI5}
  ;

function ValidPicture(APicture: TPicture): Boolean;
begin
  result := (APicture <> nil) and (APicture.Graphic <> nil) and (not APicture.Graphic.Empty);
end;

function ValidIcon(AIcon: TIcon): Boolean;
begin
  result := (AIcon <> nil) and (not AIcon.Empty); 
end;

procedure RoundRect(aCanvas: TCanvas; aRect: TRect; aCX, aCY: Integer; const aColor: TColor = clNone;
  const aBrushStyle: TBrushStyle = bsClear);
begin
  aCanvas.Brush.Style := aBrushStyle;
  if aColor <> clNone then
    aCanvas.Pen.Color := aColor;
  aCanvas.RoundRect(aRect.Left, aRect.Top, aRect.Right, aRect.Bottom, aCX, aCY);
end;

{$IFDEF DELPHI5}
const
  { Predefined coordinates to be used when drawing an arrow. }
  ArrowPts: array[TScrollDirection, 0..2] of TPoint =
    (((X:1; Y:0), (X:0; Y:1), (X:1; Y:2)),
     ((X:0; Y:0), (X:1; Y:1), (X:0; Y:2)),
     ((X:0; Y:1), (X:1; Y:0), (X:2; Y:1)),
     ((X:0; Y:0), (X:1; Y:1), (X:2; Y:0)));

procedure DrawArrow(ACanvas: TCanvas; Direction: TScrollDirection;
  Location: TPoint; Size: Integer);
var
  I: Integer;
  Pts: array[0..2] of TPoint;
  OldWidth: Integer;
  OldColor: TColor;
begin
  if ACanvas = nil then exit;
  OldColor := ACanvas.Brush.Color;
  ACanvas.Brush.Color := ACanvas.Pen.Color;
  Move(ArrowPts[Direction], Pts, SizeOf(Pts));
  for I := 0 to 2 do
    Pts[I] := Point(Pts[I].x * Size + Location.X, Pts[I].y * Size + Location.Y);
  with ACanvas do
  begin
    OldWidth := Pen.Width;
    Pen.Width := 1;
    Polygon(Pts);
    Pen.Width := OldWidth;
    Brush.Color := OldColor;
  end;
end;
{$ENDIF DELPHI5}

{$IFNDEF BDS}
function MaxValue(AValue1, AValue2, AValue3: Integer): Integer;
begin
  result := Max(Max(AValue1, AValue2), AValue3);
end;

procedure FillGradient(Canvas: TCanvas; ARect: TRect; StartColor, EndColor : TColor; const ADirection: TGradientDirection);
var
  i: Integer;
  lRect: TRect;
  lStep: Integer;
  lCorner: Integer;
  lMaxLen: Integer;
  lLenRed, lLenGreen, lLenBlue: Integer;
  lStartRed, lStartGreen, lStartBlue: Byte;
  lStepRed, lStepGreen, lStepBlue: Integer;
  lStartRGB, lEndRGB: Integer;
  lCalcR, lCalcG, lCalcB: Integer;
begin
  lStartRGB := ColorToRgb(StartColor);
  lEndRGB := ColorToRgb(EndColor);

  lStartRed := GetRValue(lStartRGB);
  lStartGreen := GetGValue(lStartRGB);
  lStartBlue := GetBValue(lStartRGB);

  lLenRed := GetRValue(lEndRGB)- lStartRed;
  lLenGreen := GetGValue(lEndRGB) - lStartGreen;
  lLenBlue := GetBValue(lEndRGB) - lStartBlue;
  lMaxLen := MaxValue(Abs(lLenRed), Abs(lLenGreen), Abs(lLenBlue)) + 1;
  if lMaxLen > 0 then
  begin
    if ADirection = gdVertical then
    begin
      lStep := (ARect.Bottom - ARect.Top) div lMaxLen + 1;
      lRect := Rect(ARect.Left, ARect.Top, ARect.Right, lStep);
    end
    else
    begin
      lStep := (ARect.Right - ARect.Left) div lMaxLen + 1;
      lRect := Rect(ARect.Left, ARect.Top, lStep, ARect.Bottom);
    end;
    lStepRed := lStep * lLenRed;
    lStepGreen := lStep * lLenGreen;
    lStepBlue := lStep * lLenBlue;
    if ADirection = gdVertical then
      lCorner := ARect.Bottom
    else
      lCorner := ARect.Right;
    for i := 0 to lMaxLen - 1 do
    begin
      lCalcR := Round(lStartRed  + (i * lStepRed) div lCorner);
      lCalcG := Round(lStartGreen + (i * lStepGreen) div lCorner);
      lCalcB := Round(lStartBlue + (i * lStepBlue) div lCorner);
      Canvas.Brush.Color := RGB(lCalcR, lCalcG, lCalcB);
      Canvas.FillRect(lRect);
      if ADirection = gdVertical then
      begin
        inc(lRect.Top, lStep);
        if lRect.Top > ARect.Bottom then
          break;
        inc(lRect.Bottom, lStep);
      end
      else
      begin
        inc(lRect.Left, lStep);
        if lRect.Left > ARect.Right then
          break;
        inc(lRect.Right, lStep);
      end;
    end;
  end;
end;

procedure GradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TGradientDirection);
begin
  FillGradient(ACanvas, ARect, AStartColor, AEndColor, Direction);
end;
{$ENDIF BDS}

end.
