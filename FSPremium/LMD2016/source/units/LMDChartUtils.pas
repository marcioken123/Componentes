unit LMDChartUtils;
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
LMDChartUtils
-----------------------------------

Changes
-------
Last (07-June-2006)

###############################################################################}

interface

uses
  SysUtils, Windows, Graphics, Classes, Variants, Types, Math, LMDChartLine;

type
  TPointsArr = array[0..3] of TPoint;
  TLMDChartTickTypes = (ttInside, ttOutside, ttCross, ttNone);

{$IFNDEF LMDCOMP7}
type
  TFormatSettings = record
    CurrencyFormat: Byte;
    NegCurrFormat: Byte;
    ThousandSeparator: Char;
    DecimalSeparator: Char;
    CurrencyDecimals: Byte;
    DateSeparator: Char;
    TimeSeparator: Char;
    ListSeparator: Char;
    CurrencyString: string;
    ShortDateFormat: string;
    LongDateFormat: string;
    TimeAMString: string;
    TimePMString: string;
    ShortTimeFormat: string;
    LongTimeFormat: string;
  end;
{$ENDIF}


procedure PieSlice(ATarget: TCanvas; AArea: TRect; AAngleStart, AAngleEnd: real);
procedure DnutSlice(ATarget: TCanvas; AArea: TRect; AAngleStart, AAngleEnd: real; SliceWidth: integer);
procedure DrawTransparency(ATarget, AWhiteBuf, ABlackBuf: Graphics.TBitMap;
  AShadow: boolean; AShadowColor: TColor; AShadowDepth, AShadowAlpha, AGfxAlpha: byte);
function rgb(r, g, b: Byte): TColor;
procedure HGradienCalc(AFromColor, AToColor: TColor; var AColorArray: array of TColor);

procedure DrawLine(AStartX, AStartY, AEndX, AEndY: integer; ATarget: TCanvas);
procedure DrawLineWithoutMove(x, y: integer; ATarget: TCanvas);

procedure Box(ATarget: TCanvas; ABox: TRect; ADepth: integer; AShaded: boolean);
procedure Plane(ATarget: TCanvas; ALineStart, ALineEnd: TPoint; ADepth: integer; var AToRet: TPointsArr);
procedure Line(ATarget: TCanvas; AStartPoint: TPoint; ADepth: integer);
procedure PolygonExtrude(ATarget: TCanvas; APoly: array of TPoint; ADepth: integer; AShaded: boolean);
procedure HermitSplineExtArea(ATarget: TCanvas; ar: array of TPoint; steps: integer; a: real; ZeroLevel: integer);
function ShadowColor(Color: TColor; Value: byte): TColor;
function SmartRoundUp(Value, Step: variant): variant;
function SmartRoundDown(Value, Step: variant): variant;

procedure DrawRectangleShadow(ALeft, ATop, AWidth, AHeight: integer; ATarget: TBitmap; FShadowColor: TColor; FShadowDepth: byte; FShadowTransparency: byte; FShadow: boolean);

procedure DrawLines(points: TPointsArr; ATarget: TCanvas); overload;
procedure DrawLines(pointX1, pointY1, pointX2, pointY2, pointX3, pointY3, pointX4, pointY4: integer; ATarget: TCanvas); overload;

/// <summary>
/// Draws x tick on canvas
/// </summary>
procedure DrawXTick(ATarget: TCanvas; AXPosition, AYPosition, ATickSize: integer; ATickTyp: TLMDChartTickTypes; ALine: TLMDChartLine);
/// <summary>
/// Draws y tick on canvas
/// </summary>
procedure DrawYTick(ATarget: TCanvas; AXPosition, AYPosition, ATickSize: integer; ATickTyp: TLMDChartTickTypes; ALine: TLMDChartLine);

implementation

{ ---------------------------------------------------------------------------- }
procedure DrawRectangleShadow(ALeft, ATop, AWidth, AHeight: integer; ATarget: TBitmap; FShadowColor: TColor; FShadowDepth: byte; FShadowTransparency: byte; FShadow: boolean);
type
  TRGBTriple = record
    rgbtBlue: byte;
    rgbtGreen: byte;
    rgbtRed: byte;
    temp: byte;
  end;

  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..65535] of TRGBTriple;

var
  x, y: integer;
  PTarget: PRGBTripleArray;
  rShdw, gShdw, bShdw, q: byte;
  LTempBitmap: TBitmap;
begin
  LTempBitmap := TBitMap.Create;
  LTempBitmap.Height := ATarget.Height;
  LTempBitmap.Width := ATarget.Width;
  LTempBitmap.Canvas.Brush.Color := clWhite;
  LTempBitmap.Canvas.Pen.Style := psClear;
  LTempBitmap.Canvas.FillRect(LTempBitmap.Canvas.ClipRect);
  LTempBitmap.Canvas.Brush.Color := FShadowColor;
  LTempBitmap.Canvas.Rectangle(ALeft + AWidth, ATop + FShadowDepth, ALeft + AWidth + FShadowDepth, ATop + AHeight + FShadowDepth);
  LTempBitmap.Canvas.Rectangle(ALeft + FShadowDepth, ATop + AHeight, ALeft + AWidth, ATop + AHeight + FShadowDepth);
  LTempBitmap.PixelFormat := pf32bit;
  ATarget.PixelFormat := pf32bit;
  q := 255 - FShadowTransparency;
  rShdw := FShadowColor and $FF;
  gShdw := (FShadowColor and $FF00) shr 8;
  bShdw := (FShadowColor and $FF0000) shr 16;
  for y := ATop + FShadowDepth to ATop + AHeight + FShadowDepth - 1 do
  begin
    if (y >= ATarget.Height) or (y < 0) then
      continue;
    PTarget := ATarget.ScanLine[y];
    for x := ALeft + AWidth to ALeft + AWidth + FShadowDepth - 1 do
    begin
      if (x >= ATarget.Width) or (x < 0) then
        continue;
      if FShadow and (FShadowTransparency > 0) then
      begin
        if FShadowTransparency = 255 then
        begin
          PTarget[x].rgbtBlue := bShdw;
          PTarget[x].rgbtGreen := GShdw;
          PTarget[x].rgbtRed := rShdw;
          end
        else
        begin
          PTarget[x].rgbtBlue := q * (PTarget[x].rgbtBlue - bShdw) div 255 + bShdw;
          PTarget[x].rgbtGreen := q * (PTarget[x].rgbtGreen - GShdw) div 255 + GShdw;
          PTarget[x].rgbtRed := q * (PTarget[x].rgbtRed - rShdw) div 255 + rShdw;
          end;
      end;
    end;
  end;
  for y := (ATop + AHeight) to (ATop + FShadowDepth + AHeight) - 1 do
  begin
    if (y >= ATarget.Height) or (y < 0) then
      continue;
    PTarget := ATarget.ScanLine[y];
    for x := ALeft + +FShadowDepth to ALeft + AWidth - 1 do
    begin
      if (x >= ATarget.Width) or (x < 0) then
        continue;
      if FShadow and (FShadowTransparency > 0) then
      begin
        if FShadowTransparency = 255 then
        begin
          PTarget[x].rgbtBlue := bShdw;
          PTarget[x].rgbtGreen := GShdw;
          PTarget[x].rgbtRed := rShdw;
          end
        else
        begin
          PTarget[x].rgbtBlue := q * (PTarget[x].rgbtBlue - bShdw) div 255 + bShdw;
          PTarget[x].rgbtGreen := q * (PTarget[x].rgbtGreen - GShdw) div 255 + GShdw;
          PTarget[x].rgbtRed := q * (PTarget[x].rgbtRed - rShdw) div 255 + rShdw;
          end;
      end;
    end;
  end;
  LTempBitmap.Free;
end;

{ ---------------------------------------------------------------------------- }

procedure PieSlice(ATarget: TCanvas; AArea: TRect; AAngleStart, AAngleEnd: real);
var
  LPieCenterX, LPieCenterY, LXScale, LYScale: real;
begin
  ATarget.Pen.Width := 2;
  LPieCenterX := AArea.Left + (AArea.Right - AArea.Left) / 2;
  LPieCenterY := AArea.Top + (AArea.Bottom - AArea.Top) / 2;

  LXScale := (AArea.Right - AArea.Left);
  LYScale := (AArea.Bottom - AArea.Top);

  ATarget.Pie(AArea.Left, AArea.Top, AArea.Right, AArea.Bottom,
    trunc(LPieCenterX + LXScale * sin(DegToRad(AAngleStart))),
    trunc(LPieCenterY + LYScale * cos(DegToRad(AAngleStart))),
    trunc(LPieCenterX + LXScale * sin(DegToRad(AAngleEnd))),
    trunc(LPieCenterY + LYScale * cos(DegToRad(AAngleEnd)))
    );
end;

{ ---------------------------------------------------------------------------- }

procedure DnutSlice(ATarget: TCanvas; AArea: TRect; AAngleStart, AAngleEnd: real; SliceWidth: integer);
var
  LPieCenterX, LPieCenterY, LXScale, LYScale: real;
  InsideXStart, InsideYStart, InsideXEnd, InsideYEnd: integer;
  OutsideXStart, OutsideYStart, OutsideXEnd, OutsideYEnd: integer;
  LTmpArea: TRect;
  LTmpPieCenterX, LTmpPieCenterY, LTmpXScale, LTmpYScale: real;
  FillX, FillY: integer;
  BC: TColor;
begin
  BC := ATarget.Brush.Color;

  LTmpArea := Rect(AArea.Left + SliceWidth, AArea.Top + SliceWidth,
    AArea.Right - SliceWidth, AArea.Bottom - SliceWidth);

  LTmpPieCenterX := LTmpArea.Left + (LTmpArea.Right - LTmpArea.Left) / 2;
  LTmpPieCenterY := LTmpArea.Top + (LTmpArea.Bottom - LTmpArea.Top) / 2;

  LTmpXScale := (LTmpArea.Right - LTmpArea.Left);
  LTmpYScale := (LTmpArea.Bottom - LTmpArea.Top);

  LPieCenterX := AArea.Left + (AArea.Right - AArea.Left) / 2;
  LPieCenterY := AArea.Top + (AArea.Bottom - AArea.Top) / 2;

  LXScale := (AArea.Right - AArea.Left);
  LYScale := (AArea.Bottom - AArea.Top);

  InsideXStart := trunc(LTmpPieCenterX + (LTmpXScale / 2 - 1) * sin(DegToRad(AAngleStart)));
  InsideYStart := trunc(LTmpPieCenterY + (LTmpYScale / 2 - 1) * cos(DegToRad(AAngleStart)));
  InsideXEnd := trunc(LTmpPieCenterX + (LTmpXScale / 2 - 1) * sin(DegToRad(AAngleEnd)));
  InsideYEnd := trunc(LTmpPieCenterY + (LTmpYScale / 2 - 1) * cos(DegToRad(AAngleEnd)));

  OutsideXStart := trunc(LPieCenterX + (LXScale / 2) * sin(DegToRad(AAngleStart)));
  OutsideYStart := trunc(LPieCenterY + (LYScale / 2) * cos(DegToRad(AAngleStart)));
  OutsideXEnd := trunc(LPieCenterX + (LXScale / 2) * sin(DegToRad(AAngleEnd)));
  OutsideYEnd := trunc(LPieCenterY + (LYScale / 2) * cos(DegToRad(AAngleEnd)));

  ATarget.Pen.Color := clblack;
  ATarget.Pen.Width := 1;
  Atarget.Brush.Style := bsClear;

  ATarget.Ellipse(AArea.Left, AArea.Top, AArea.Right, AArea.Bottom);
  ATarget.Ellipse(LTmpArea.Left, LTmpArea.Top, LTmpArea.Right, LTmpArea.Bottom);

  ATarget.MoveTo(InsideXStart, InsideYStart);
  ATarget.LineTo(OutsideXStart, OutsideYStart);

  ATarget.MoveTo(InsideXEnd, InsideYEnd);
  ATarget.LineTo(OutsideXEnd, OutsideYEnd);

  ATarget.MoveTo(InsideXStart, InsideYStart);
  ATarget.LineTo(OutsideXStart, OutsideYStart);

  ATarget.MoveTo(InsideXEnd, InsideYEnd);
  ATarget.LineTo(OutsideXEnd, OutsideYEnd);

  FillX := trunc(LPieCenterX + (LXScale / 2 - SliceWidth / 2) * sin(DegToRad(AAngleStart + (AAngleEnd - AAngleStart) / 2)));
  FillY := trunc(LPieCenterY + (LYScale / 2 - SliceWidth / 2) * cos(DegToRad(AAngleStart + (AAngleEnd - AAngleStart) / 2)));

  Atarget.Brush.Style := bsSolid;
  Atarget.Brush.Color := bc;
  ATarget.FloodFill(FillX, FillY, ATarget.Pixels[FillX, FillY], fsSurface);

end;

{ ---------------------------------------------------------------------------- }

procedure DrawTransparency(ATarget, AWhiteBuf, ABlackBuf: Graphics.TBitmap;
  AShadow: boolean; AShadowColor: TColor; AShadowDepth, AShadowAlpha, AGfxAlpha: byte);
type
  TRGBTriple = record
    rgbtBlue: byte;
    rgbtGreen: byte;
    rgbtRed: byte;
  end;

  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..65535] of TRGBTriple;

var
  x, y, xd: integer;
  PWhite, PBlack, PTarget: PRGBTripleArray;
  rShdw, gShdw, bShdw, q, w: byte;
  begin
  if ((AShadow = false) or (AShadowAlpha = 0)) and (AGfxAlpha = 0) then
    exit;
  ATarget.PixelFormat := pf24bit;
  AWhiteBuf.PixelFormat := pf24bit;
  ABlackBuf.PixelFormat := pf24bit;
  w := (255 - AGfxAlpha);
  q := (255 - AShadowAlpha);
  rShdw := AShadowColor and $FF;
  gShdw := (AShadowColor and $FF00) shr 8;
  bShdw := (AShadowColor and $FF0000) shr 16;
  for y := 0 to AWhiteBuf.Height - 1 do
  begin
    if y >= ATarget.Height then
      continue;
    PWhite := AWhiteBuf.ScanLine[y];
    PBlack := ABlackBuf.ScanLine[y];
    for x := 0 to AWhiteBuf.Width - 1 do
      if (PWhite[x].rgbtBlue = PBlack[x].rgbtBlue) and (PWhite[x].rgbtGreen = PBlack[x].rgbtGreen) and (PWhite[x].rgbtRed = PBlack[x].rgbtRed) then
      begin
        if AShadow and (AShadowAlpha > 0) and (y + AShadowDepth < ATarget.Height) then
        begin
          xd := x + AShadowDepth;
          if xd > AWhiteBuf.Width then
            continue;
          PTarget := ATarget.Scanline[y + AShadowDepth];
          if AShadowAlpha = 255 then
          begin
            PTarget[xd].rgbtBlue := bShdw;
            PTarget[xd].rgbtGreen := GShdw;
            PTarget[xd].rgbtRed := rShdw;
            end
          else
          begin
            PTarget[xd].rgbtBlue := q * (PTarget[xd].rgbtBlue - bShdw) div 255 + bShdw;
            PTarget[xd].rgbtGreen := q * (PTarget[xd].rgbtGreen - GShdw) div 255 + GShdw;
            PTarget[xd].rgbtRed := q * (PTarget[xd].rgbtRed - rShdw) div 255 + rShdw;
            end;
        end;
        PTarget := ATarget.ScanLine[y];
        if AGfxAlpha > 0 then
        begin
          if AGfxAlpha = 255 then
          begin
            PTarget[x].rgbtBlue := PWhite[x].rgbtBlue;
            PTarget[x].rgbtGreen := PWhite[x].rgbtGreen;
            PTarget[x].rgbtRed := PWhite[x].rgbtRed;
            end
          else
          begin
            PTarget[x].rgbtBlue := w * (PTarget[x].rgbtBlue - PWhite[x].rgbtBlue) div 255 + PWhite[x].rgbtBlue;
            PTarget[x].rgbtGreen := w * (PTarget[x].rgbtGreen - PWhite[x].rgbtGreen) div 255 + PWhite[x].rgbtGreen;
            PTarget[x].rgbtRed := w * (PTarget[x].rgbtRed - PWhite[x].rgbtRed) div 255 + PWhite[x].rgbtRed;
            end;
        end;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure DrawLines(points: TPointsArr; ATarget: TCanvas);
begin
  DrawLines(points[0].X, points[0].Y, points[1].X, points[1].Y, points[2].X, points[2].y, points[3].X, points[3].Y, ATarget);
end;

{ ---------------------------------------------------------------------------- }

procedure DrawLines(pointX1, pointY1, pointX2, pointY2, pointX3, pointY3, pointX4, pointY4: integer; ATarget: TCanvas);
begin
  DrawLine(pointX1, pointY1, pointX2, pointY2, ATarget);
  DrawLine(pointX2, pointY2, pointX3, pointY3, ATarget);
  DrawLine(pointX3, pointY3, pointX4, pointY4, ATarget);
end;

{ ---------------------------------------------------------------------------- }

procedure DrawLineWithoutMove(x, y: integer; ATarget: TCanvas);
begin
  ATarget.Lineto(x, y);
end;

{ ---------------------------------------------------------------------------- }

procedure DrawLine(AStartX, AStartY, AEndX, AEndY: integer; ATarget: TCanvas);
begin
  with ATarget do
  begin
    MoveTo(AStartX, AStartY);
    LineTo(AEndX, AEndY);
    Pixels[AEndX, AEndY] := Pen.Color;
  end;
end;

function rgb(r, g, b: Byte): TColor;
begin
  Result := (r or (g shl 8) or (b shl 16));
end;

{ ---------------------------------------------------------------------------- }

procedure HGradienCalc(AFromColor, AToColor: TColor; var AColorArray: array of TColor);
var
  i: Integer;
  R1, G1, B1,
    R2, G2, B2: Byte;
begin
  R1 := AFromColor and $FF;
  G1 := (AFromColor and $FF00) shr 8;
  B1 := (AFromColor and $FF0000) shr 16;
  R2 := AToColor and $FF;
  G2 := (AToColor and $FF00) shr 8;
  B2 := (AToColor and $FF0000) shr 16;
  for i := low(AColorArray) to High(AColorArray) do
    AColorArray[i] := RGB(R1 - i * (R1 - R2) div Length(AColorArray),
      G1 - i * (G1 - G2) div Length(AColorArray),
      B1 - i * (B1 - B2) div Length(AColorArray));
end;

{ ---------------------------------------------------------------------------- }

procedure Box(ATarget: TCanvas; ABox: TRect; ADepth: integer; AShaded: boolean);
var
  LTempPoly: array of TPoint;
  LColorBuf: TColor;
begin
  Setlength(LTempPoly, 4);

  //front
  ATarget.Rectangle(rect(ABox.Left, ABox.Top, ABox.Right + 1, ABox.Bottom + 1));

  LColorBuf := ATarget.Brush.Color;
  if AShaded then
    ATarget.Brush.Color := rgb(GetRValue(ATarget.Brush.Color) div 2, GetGValue(ATarget.Brush.Color) div 2, GetBValue(ATarget.Brush.Color) div 2);

  //top
  LTempPoly[0].X := ABox.Left;
  LTempPoly[0].Y := ABox.Top;
  LTempPoly[1].X := ABox.Right;
  LTempPoly[1].Y := ABox.Top;
  LTempPoly[2].X := ABox.Right + ADepth;
  LTempPoly[2].Y := ABox.Top - ADepth;
  LTempPoly[3].X := ABox.Left + ADepth;
  LTempPoly[3].Y := ABox.Top - ADepth;
  ATarget.Polygon(LtempPoly);
  //inner side
  LTempPoly[0].X := ABox.Right;
  LTempPoly[0].Y := ABox.Top;
  LTempPoly[1].X := ABox.Right + ADepth;
  LTempPoly[1].Y := ABox.Top - ADepth;
  LTempPoly[2].X := ABox.Right + ADepth;
  LTempPoly[2].Y := ABox.Bottom - ADepth;
  LTempPoly[3].X := ABox.Right;
  LTempPoly[3].Y := ABox.Bottom;
  ATarget.Polygon(LtempPoly);
  if AShaded then
    ATarget.Brush.Color := LColorBuf;
end;

{ ---------------------------------------------------------------------------- }

procedure Plane(ATarget: TCanvas; ALineStart, ALineEnd: TPoint; ADepth: integer; var AToRet: TPointsArr);
var
  LTempPoly: TPointsArr;
begin
  LTempPoly[0] := ALineStart;
  LTempPoly[1] := ALineEnd;
  LTempPoly[2].X := ALineEnd.X + ADepth;
  LTempPoly[2].Y := ALineEnd.Y - ADepth;
  LTempPoly[3].X := ALineStart.X + ADepth;
  LTempPoly[3].Y := ALineStart.Y - ADepth;
  AToRet := LTempPoly;
end;

{ ---------------------------------------------------------------------------- }

procedure Line(ATarget: TCanvas; AStartPoint: TPoint; ADepth: integer);
begin
  DrawLine(AStartPoint.X, AStartPoint.Y, AStartPoint.X + ADepth, AStartPoint.Y - ADepth, ATarget);
end;

{ ---------------------------------------------------------------------------- }

procedure PolygonExtrude(ATarget: TCanvas; APoly: array of TPoint; ADepth: integer; AShaded: boolean);
var
  i: integer;
  LRectPoly: array of TPoint;
  LTempPStyle: TPenStyle;
begin
  //back
  for i := low(APoly) to high(APoly) do
  begin
    APoly[i].X := APoly[i].X + ADepth;
    APoly[i].Y := APoly[i].Y - ADepth;
  end;
  ATarget.Polygon(APoly);

  LTempPStyle := ATarget.Pen.Style;
  ATarget.Pen.Style := psClear;
  if AShaded then
    ATarget.Brush.Color := rgb(GetRValue(ATarget.Brush.Color) div 2, GetGValue(ATarget.Brush.Color) div 2, GetBValue(ATarget.Brush.Color) div 2);
  Setlength(LRectPoly, 4);
  for i := high(APoly) downto low(APoly) do
  begin
    if i <> high(APoly) then
    begin
      LRectPoly[0] := APoly[i];
      LRectPoly[1] := Point(APoly[i].X - ADepth, APoly[i].Y + ADepth);
      LRectPoly[2] := Point(APoly[i + 1].X - ADepth, APoly[i + 1].Y + ADepth);
      LRectPoly[3] := APoly[i + 1];
      ATarget.Polygon(LRectPoly);
    end;
  end;
  ATarget.Pen.Style := LTempPStyle;
  if AShaded then
    ATarget.Brush.Color := rgb(GetRValue(ATarget.Brush.Color) * 2, GetGValue(ATarget.Brush.Color) * 2, GetBValue(ATarget.Brush.Color) * 2);

  for i := low(APoly) to high(APoly) do
  begin
    Line(ATarget, APoly[i], -ADepth);
  end;

  for i := low(APoly) to high(APoly) do
  begin
    APoly[i].X := APoly[i].X - ADepth;
    APoly[i].Y := APoly[i].Y + ADepth;
  end;
  ATarget.Polygon(APoly);
end;

procedure HermitSplineArea(ATarget: TCanvas; P0, P1, P2, P3: TPoint; steps: integer; a: real; ZeroLevel: integer);
var
  i: integer;
  p, T1, T2: TPoint;
  s, s2, s3, m2s3, m3s2, h1, h2, h3, h4: double;
  Poly: array of TPoint;
  LInvSteps: real;
begin
  T1.X := Round(a * (P2.X - P0.X));
  T1.Y := Round(a * (P2.Y - P0.Y));
  T2.X := Round(a * (P3.X - P1.X));
  T2.Y := Round(a * (P3.Y - P1.Y));
  SetLength(Poly, steps + 3);
  Poly[0] := Point(P1.X, ZeroLevel);
  LInvSteps := 1 / steps;
  for i := 0 to steps do
  begin
    s := i * LInvSteps;
    s2 := s * s;
    s3 := s2 * s;
    m2s3 := 2 * s3;
    m3s2 := 3 * s2;
    h1 := m2s3 - m3s2 + 1;
    h2 := -m2s3 + m3s2;
    h3 := s3 - 2 * s2 + s;
    h4 := s3 - s2;
    p.x := Round(h1 * P1.X + h2 * P2.X + h3 * T1.X + h4 * T2.X);
    p.y := Round(h1 * P1.Y + h2 * P2.Y + h3 * T1.Y + h4 * T2.Y);
    Poly[i + 1] := p;
  end;
  Poly[steps + 2] := Point(p.X, ZeroLevel);
  ATarget.Pen.Style := psClear;
  ATarget.Polygon(Poly);
  ATarget.Pen.Style := psSolid;
  Poly[0] := Poly[1];
  ATarget.Polyline(Poly);
end;

procedure HermitSplineExtArea(ATarget: TCanvas; ar: array of TPoint; steps: integer; a: real; ZeroLevel: integer);
var
  i, l: integer;
begin
  l := Length(ar) - 3;
  if Length(ar) >= 3 then
  begin
    HermitSplineArea(ATarget, ar[0], ar[0], ar[1], ar[2], steps, a, ZeroLevel);
    for i := 1 to l do
    begin
      HermitSplineArea(ATarget, ar[i - 1], ar[i], ar[i + 1], ar[i + 2], steps, a, ZeroLevel);
    end;
    HermitSplineArea(ATarget, ar[l], ar[l + 1], ar[l + 2], ar[l + 2], steps, a, ZeroLevel);
  end
  else
    if Length(ar) = 2 then
      HermitSplineArea(ATarget, ar[0], ar[0], ar[1], ar[1], steps, a, ZeroLevel);
end;

function ShadowColor(Color: TColor; Value: byte): TColor;
var
  r, g, b: integer;
  Tmp: TColor;
begin
  r := Color and $000000FF;
  g := Color and $0000FF00;
  g := g shr 8;
  b := Color and $00FF0000;
  b := b shr 16;
  r := r - Value;
  g := g - Value;
  b := b - Value;
  if (r < 0) then
    r := 0;
  if (g < 0) then
    g := 0;
  g := g shl 8;
  if (b < 0) then
    b := 0;
  b := b shl 16;
  Tmp := 0;
  Tmp := Tmp + r + g + b;
  ShadowColor := Tmp;
end;

function SmartRoundUp(Value, Step: variant): variant;
var
  rez, st: integer;
begin
  rez := round(Value - 1);
  st := round(Step);
  repeat
    rez := rez + 1;
  until ((rez mod st) = 0);
  SmartRoundUp := rez;
end;

function SmartRoundDown(Value, Step: variant): variant;
var
  rez, st: integer;
begin
  rez := round(Value - 1);
  st := round(Step);
  repeat
    rez := rez - 1;
  until ((rez mod st) = 0);
  SmartRoundDown := rez;
end;

{ ---------------------------------------------------------------------------- }

procedure DrawXTick(ATarget: TCanvas; AXPosition, AYPosition, ATickSize: integer; ATickTyp: TLMDChartTickTypes; ALine: TLMDChartLine);
begin
  if ATickTyp = ttNone then
    exit;
  with ATarget do
  begin
    ALine.SetupCanvasPen(Pen);
    case ATickTyp of
      ttCross: DrawLine(AXPosition, AYPosition - ATickSize, AXPosition, AYPosition + ATickSize, ATarget);
      ttInside: DrawLine(AXPosition, AYPosition - ATickSize, AXPosition, AYPosition, ATarget);
      ttOutside: DrawLine(AXPosition, AYPosition, AXPosition, AYPosition + ATickSize, ATarget);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure DrawYTick(ATarget: TCanvas; AXPosition, AYPosition, ATickSize: integer; ATickTyp: TLMDChartTickTypes; ALine: TLMDChartLine);
begin
  if ATickTyp = ttNone then
    exit;
  with ATarget do
  begin
    ALine.SetupCanvasPen(Pen);
    case ATickTyp of
      ttCross: DrawLine(AXPosition - ATickSize, AYPosition, AXPosition + ATickSize, AYPosition, ATarget);
      ttInside: DrawLine(AXPosition + ATickSize, AYPosition, AXPosition, AYPosition, ATarget);
      ttOutside: DrawLine(AXPosition, AYPosition, AXPosition - ATickSize, AYPosition, ATarget);
    end;
  end;
end;

end.
