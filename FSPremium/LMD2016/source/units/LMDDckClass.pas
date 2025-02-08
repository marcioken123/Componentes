unit LMDDckClass;
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

LMDDckClass unit (YB)
---------------------
Unit contains bases classes needed in LMD DockingPack.

Changes
-------
Release 4.0 (January 2009)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, GraphUtil, Controls,
  LMDTypes;

//{$R LMDDckClass.res}

{************************** LMDGradientFillCanvas *****************************}

type
  TLMDGradientDirection = {$IFDEF LMDCOMP9} GraphUtil.TGradientDirection
                          {$ELSE} (gdHorizontal, gdVertical) {$ENDIF};
  TLMDSide = alTop..alRight;

procedure LMDGradientFillCanvas(const ACanvas: TCanvas; const AStartColor,
                                AEndColor: TColor; const ARect: TRect;
                                const Direction: TLMDGradientDirection);
function  LMDGetHighLightColor(const Color: TColor;
                               Luminance: Integer = 19): TColor;
function  LMDGetShadowColor(const Color: TColor;
                            Luminance: Integer = -50): TColor;

{******************************* Other Utils **********************************}

const
  LMDOppsiteSide: array[TLMDSide] of TLMDSide = (alBottom, alTop, alRight,
                                                 alLeft);

function  LMDGetRectSide(const ARect: TRect; ASide: TLMDSide): Integer;
procedure LMDSetRectSide(var ARect: TRect; ASide: TLMDSide; AValue: Integer);
procedure LMDGetRectCorner(const ARect: TRect; AHorz, AVert: TLMDSide;
                           ACornerSize: Integer; AResult: PPoint);
procedure LMDInflateRectSide(var ARect: TRect; ASide: TLMDSide;
                             AOffset: Integer);
procedure LMDDrawTextWithElipsis(ACanvas: TCanvas; const S: TLMDString;
                                 const R: TRect);
procedure LMDDrawOrientedText(ACanvas: TCanvas; const S: TLMDString;
                              X, Y: Integer; const R: TRect);
procedure LMDDrawParentBackground(AWnd: HWND; ACanvas: TCanvas; R: PRect);

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

{ ---------------------------------------------------------------------------- }

function LMDGetRectSide(const ARect: TRect; ASide: TLMDSide): Integer;
begin
  case ASide of
    alLeft:   Result := ARect.Left;
    alTop:    Result := ARect.Top;
    alRight:  Result := ARect.Right;
    alBottom: Result := ARect.Bottom;
  else
    Result := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure LMDSetRectSide(var ARect: TRect; ASide: TLMDSide; AValue: Integer);
begin
  case ASide of
    alLeft:   ARect.Left   := AValue;
    alTop:    ARect.Top    := AValue;
    alRight:  ARect.Right  := AValue;
    alBottom: ARect.Bottom := AValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDGetRectCorner(const ARect: TRect; AHorz, AVert: TLMDSide;
  ACornerSize: Integer; AResult: PPoint);
var
  diag:     Integer;
  pixel:    Integer;
  cur, eof: PPoint;
begin
  cur := AResult;

  for diag := 0 to ACornerSize - 1 do
    for pixel := 0 to diag do
    begin
      cur.X := pixel;
      cur.Y := diag - pixel;
      Inc(cur);
    end;

  eof := cur;
  cur := AResult;

  if AHorz = alLeft then
  begin
    while cur <> eof do
    begin
      cur.X := ARect.Left + cur.X;
      Inc(cur);
    end;
  end
  else if AHorz = alRight then
  begin
    while cur <> eof do
    begin
      cur.X := ARect.Right - 1 - cur.X;
      Inc(cur);
    end;
  end;

  cur := AResult;

  if AVert = alTop then
  begin
    while cur <> eof do
    begin
      cur.Y := ARect.Top + cur.Y;
      Inc(cur);
    end;
  end
  else if AVert = alBottom then
  begin
    while cur <> eof do
    begin
      cur.Y := ARect.Bottom - 1 - cur.Y;
      Inc(cur);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure LMDInflateRectSide(var ARect: TRect; ASide: TLMDSide;
  AOffset: Integer);
begin
  case ASide of
    alLeft:   Dec(ARect.Left, AOffset);
    alTop:    Dec(ARect.Top, AOffset);
    alRight:  Inc(ARect.Right, AOffset);
    alBottom: Inc(ARect.Bottom, AOffset);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure LMDDrawTextWithElipsis(ACanvas: TCanvas; const S: TLMDString;
  const R: TRect);
var
  flags: Cardinal;
  tr:    TRect;
begin
  flags := DT_SINGLELINE or DT_LEFT or DT_VCENTER or
           DT_END_ELLIPSIS or DT_NOPREFIX;
  tr    := R;

  {$IFNDEF CLR}
  {$IFDEF _LMD_UNICODEIMPL}
  DrawTextW(ACanvas.Handle, PWideChar(S), Length(S), tr, flags);
  {$ELSE}
  DrawText(ACanvas.Handle, PChar(S), Length(S), tr, flags);
  {$ENDIF}
  {$ELSE}
  DrawText(ACanvas.Handle, S, Length(S), tr, flags);
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }

procedure LMDDrawOrientedText(ACanvas: TCanvas; const S: TLMDString;
  X, Y: Integer; const R: TRect);
var
  flags: Cardinal;
  tr:    TRect;
begin
  tr    := R;
  flags := ETO_CLIPPED;

  {$IFNDEF CLR}
  {$IFDEF _LMD_UNICODEIMPL}
  ExtTextOutW(ACanvas.Handle, X, Y, flags, @tr, PWideChar(S), Length(S), nil);
  {$ELSE}
  ExtTextOut(ACanvas.Handle, X, Y, flags, @tr, PChar(S), Length(S), nil);
  {$ENDIF}
  {$ELSE}
  ExtTextOut(ACanvas.Handle, X, Y, flags, tr, S, Length(S), nil);
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }

procedure LMDDrawParentBackground(AWnd: HWND; ACanvas: TCanvas; R: PRect);
var
  pnt:     HWND;
  dc:      HDC;
  cr:      TRect;
  org:     TPoint;
  oldrgn:  HRGN;
  cstate:  Integer;
begin
  // Hmmm. Seems to not work in Delphi 6 due to the fact
  // that WM_PRINTCLIENT is supported only from Delphi 7.

  pnt := GetParent(AWnd);

  if pnt <> 0 then
  begin
    ACanvas.Lock;
    try
      dc := ACanvas.Handle;

      if R <> nil then
      begin
        cr     := R^;
        oldrgn := CreateRectRgn(0,0,1,1);
        cstate := GetClipRgn(dc, oldrgn);

        if (cstate <> -1) then
          IntersectClipRect(dc, cr.Left, cr.Top,
                            cr.Right, cr.Bottom);
      end
      else
      begin
        oldrgn := 0;
        cstate := -1;
        GetClientRect(AWnd, cr);
      end;

      MapWindowPoints(AWnd, pnt, cr, 2);

      OffsetViewportOrgEx(dc, -cr.Left, -cr.Top, @org);
      SendMessage(pnt, WM_ERASEBKGND,  WPARAM(dc), 0);
      SendMessage(pnt, WM_PRINTCLIENT, WPARAM(dc), PRF_CLIENT);
      SetViewportOrgEx(dc, org.X, org.Y, nil);

      if R <> nil then
      begin
        case cstate of
          0: SelectClipRgn(DC, 0);
          1: SelectClipRgn(DC, oldrgn);
        end;
        DeleteObject(oldrgn);
      end;
    finally
      ACanvas.Unlock;  
    end;
  end;
end;

end.
