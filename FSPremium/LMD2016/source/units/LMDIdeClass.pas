unit LMDIdeClass;
{$I LMDCmps.inc}

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

LMDIdeClass unit (YB)
------------------------
Unit contains bases classes needed in LMD IDE-Tools pack.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Graphics, GraphUtil,
  LMDIdeCst, LMDTypes;
           
{$R LMDIdeClass.res}

{************************** LMDGradientFillCanvas *****************************}

type
  TLMDGradientDirection = {$IFDEF LMDCOMP9} GraphUtil.TGradientDirection
                          {$ELSE} (gdHorizontal, gdVertical) {$ENDIF};

procedure LMDGradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TLMDGradientDirection);

function LMDGetHighLightColor(const Color: TColor; Luminance: Integer = 19): TColor;
function LMDGetShadowColor(const Color: TColor; Luminance: Integer = -50): TColor;

implementation

{$IFNDEF LMDCOMP7}
var
  CachedHighlightLum:   Integer;
  CachedHighlightColor,
  CachedHighlight:      TColor;
  CachedShadowLum:      Integer;
  CachedShadowColor,
  CachedShadow:         TColor;
{$ENDIF}

{------------------------------------------------------------------------------}

{$IFNDEF LMDCOMP9}
function GradientFill(DC: hDC; pVertex: Pointer; dwNumVertex: DWORD;
  pMesh: Pointer; dwNumMesh, dwMode: DWORD): DWord; stdcall;
		external 'msimg32.dll';
{$ENDIF}

{------------------------------------------------------------------------------}

{$IFNDEF LMDCOMP9}
procedure _GradientFillCanvasImpl(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TLMDGradientDirection);
type
  TTriVertex = packed record
    X, Y:                    DWORD;
    Red, Green, Blue, Alpha: Word;
  end;
const
  GRAD_DIRS: array[TLMDGradientDirection] of Cardinal =
    (GRADIENT_FILL_RECT_H, GRADIENT_FILL_RECT_V);
var
  StartColor, EndColor: Cardinal;
  Vertexes:             array[0..1] of TTriVertex;
  GradientRect:         TGradientRect;
begin
  StartColor := ColorToRGB(AStartColor);
  EndColor := ColorToRGB(AEndColor);

  Vertexes[0].x := ARect.Left;
  Vertexes[0].y := ARect.Top;
  Vertexes[0].Red := GetRValue(StartColor) shl 8;
  Vertexes[0].Blue := GetBValue(StartColor) shl 8;
  Vertexes[0].Green := GetGValue(StartColor) shl 8;
  Vertexes[0].Alpha := 0;

  Vertexes[1].x := ARect.Right;
  Vertexes[1].y := ARect.Bottom;
  Vertexes[1].Red := GetRValue(EndColor) shl 8;
  Vertexes[1].Blue := GetBValue(EndColor) shl 8;
  Vertexes[1].Green := GetGValue(EndColor) shl 8;
  Vertexes[1].Alpha := 0;

  GradientRect.UpperLeft := 0;
  GradientRect.LowerRight := 1;

  GradientFill(ACanvas.Handle, @Vertexes[0], 2, @GradientRect, 1,
               GRAD_DIRS[Direction]);
end;
{$ENDIF}
          
{------------------------------------------------------------------------------}

procedure LMDGradientFillCanvas(const ACanvas: TCanvas;
  const AStartColor, AEndColor: TColor; const ARect: TRect;
  const Direction: TLMDGradientDirection);
begin
  {$IFDEF LMDCOMP9}
  GraphUtil.GradientFillCanvas(ACanvas, AStartColor, AEndColor,
                               ARect, Direction);
  {$ELSE}
  _GradientFillCanvasImpl(ACanvas, AStartColor, AEndColor,
                          ARect, Direction);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

function LMDGetHighLightColor(const Color: TColor; Luminance: Integer): TColor;
{$IFNDEF LMDCOMP7}
var
  H, L, S: Word;
  Clr: Cardinal;
{$ENDIF}
begin
  {$IFNDEF LMDCOMP7}
  if (Color = CachedHighlightColor) and (Luminance = CachedHighlightLum) then
    Result := CachedHighlight
  else
  begin
    // Case for default luminance
    if (Color = clBtnFace) and (Luminance = 19) then
      Result := clBtnHighlight
    else
    begin
      Clr := ColorToRGB(Color);
      ColorRGBToHLS(Clr, H, L, S);
      if S > 220 then
        Result := ColorHLSToRGB(H, L - Luminance, S)
      else
        Result := TColor(ColorAdjustLuma(Clr, Luminance, False));
      CachedHighlightLum := Luminance;
      CachedHighlightColor := Color;
      CachedHighlight := Result;
    end;
  end;
  {$ELSE}
  Result := GraphUtil.GetHighLightColor(Color, Luminance);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

function LMDGetShadowColor(const Color: TColor; Luminance: Integer): TColor;
{$IFNDEF LMDCOMP7}
var
  H, L, S: Word;
  Clr: Cardinal;
{$ENDIF}
begin
  {$IFNDEF LMDCOMP7}
  if (Color = CachedShadowColor) and (Luminance = CachedShadowLum) then
    Result := CachedShadow
  else
  begin
    // Case for default luminance
    if (Color = clBtnFace) and (Luminance = -50) then
      Result := clBtnShadow
    else
    begin
      Clr := ColorToRGB(Color);
      ColorRGBToHLS(Clr, H, L, S);
      if S >= 160 then
        Result := ColorHLSToRGB(H, L + Luminance, S)
      else
        Result := TColor(ColorAdjustLuma(Clr, Luminance, False));
    end;
    CachedShadowLum := Luminance;
    CachedShadowColor := Color;
    CachedShadow := Result;
  end;
  {$ELSE}
  Result := GraphUtil.GetShadowColor(Color, Luminance);
  {$ENDIF}
end;

{------------------------------------------------------------------------------}

end.
