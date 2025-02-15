unit LMDThemesWindowsXPUtils;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

LMDThemesWindowsXPUtils unit (VB)
---------------------------------

ToDo
----

Changes
-------
Release 8.0 (XX 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics,
  LMDThemesWindowsXPTypes;

function StrToBgType(S: string; Default: TXPBgType): TXPBgType;
function StrToBoolean(S: string; Default: boolean): boolean;
function StrToBorderType(S: string; Default: TXPBorderType): TXPBorderType;
function StrToColor(S: string; Default: TColor): TColor;
function StrToContentAlignment(S: string; Default: TXPContentAlignment): TXPContentAlignment;
function StrToFillType(S: string; Default: TXPFillType): TXPFillType;
function StrToFont(S: string; var Font: TXPFont): boolean;
function StrToGlyphType(S: string; Default: TXPGlyphType): TXPGlyphType;
function StrToHAlign(S: string; Default: TXPHAlign): TXPHAlign;
function StrToIconEffect(S: string; Default: TXPIconEffect): TXPIconEffect;
function StrToImageLayout(S: string; Default: TXPImageLayout): TXPImageLayout;
function StrToImageSelect(S: string; Default: TXPImageSelect): TXPImageSelect;
function StrToMargins(S: string; const Default: TXPMargins): TXPMargins;
function StrToOffsetType(S: string; Default: TXPOffsetType): TXPOffsetType;
function StrToPoint(S: string; const Default: TPoint): TPoint;
function StrToRect(S: string; const Default: TRect): TRect;
function StrToShadowType(S: string; Default: TXPShadowType): TXPShadowType;
function StrToSize(S: string; const Default: TXPSize): TXPSize;
function StrToSizingType(S: string; Default: TXPSizingType): TXPSizingType;
function StrToVAlign(S: string; Default: TXPVAlign): TXPVAlign;

function XPMargins(Left, Right, Top, Bottom: integer): TXPMargins;
function XPSize(Width, Height: integer): TXPSize;

function NormalizeFileName(const FileName: string): string;

implementation

uses
  SysUtils;

{------------------------------------------------------------------------------}
function StrToBgType(S: string; Default: TXPBgType): TXPBgType;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'imagefile' then
    Result := bgImageFile
  else
    if S = 'borderfill' then
    Result := bgBorderFill
  else
    if S = 'none' then
    Result := bgNone
  else
    Result := bgNone;
end;

{------------------------------------------------------------------------------}
function StrToBoolean(S: string; Default: boolean): boolean;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'true' then
    Result := True
  else
    if S = 'false' then
    Result := False
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToBorderType(S: string; Default: TXPBorderType): TXPBorderType;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'none' then
    Result := btNone
  else
    if S = 'rect' then
    Result := btRect
  else
    if S = 'roundrect' then
    Result := btRoundRect
  else
    if S = 'ellipse' then
    Result := btEllipse
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToColor(S: string; Default: TColor): TColor;
var
  R, G, B: byte;
  P: integer;
begin
  Result := Default;
  S := Trim(S);
  P := Pos(' ', S);
  if P > 0 then
  begin
    R := StrToIntDef(Copy(S, 1, P - 1), 0);
    Delete(S, 1, P);
    S := TrimLeft(S);
    P := Pos(' ', S);
    if P > 0 then
    begin
      G := StrToIntDef(Copy(S, 1, P - 1), 0);
      Delete(S, 1, P);
      S := TrimLeft(S);
      if Length(S) > 0 then
      begin
        B := StrToIntDef(S, 0);
        Result := RGB(R, G, B);
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function StrToContentAlignment(S: string; Default: TXPContentAlignment):
TXPContentAlignment;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'left' then
    Result := caLeft
  else
    if S = 'center' then
    Result := caCenter
  else
    if S = 'right' then
    Result := caRight
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToFillType(S: string; Default: TXPFillType): TXPFillType;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'none' then
    Result := ftNone
  else
    if S = 'solid' then
    Result := ftSolid
  else
    if S = 'vertgradient' then
    Result := ftVertGradient
  else
    if S = 'horzgradient' then
    Result := ftHorzGradient
  else
    if S = 'radialgradient' then
    Result := ftRadialGradient
  else
    if S = 'tileimage' then
    Result := ftTileImage
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToFont(S: string; var Font: TXPFont): boolean;
var
  Size: string;
  P: integer;
begin
  Result := False;
  S := Trim(S);
  P := Pos(',', S);
  if P > 0 then
  begin
    Font.Name := AnsiString(TrimRight(Copy(S, 1, P - 1)));
    Delete(S, 1, P);
    S := TrimLeft(S);
    P := Pos(',', S);
    if P = 0 then
    begin
      Size := S;
      S := '';
    end
    else
    begin
      Size := TrimLeft(Copy(S, 1, P - 1));
      Delete(S, 1, P);
      S := TrimLeft(S);
    end;
    Font.Size := StrToIntDef(Size, Font.Size);
    if Length(S) = 0 then
      Font.Style := []
    else
    begin
      Size := AnsiLowerCase(Size);
      if Size = 'bold' then
        Font.Style := [fsBold]
      else
        if Size = 'italic' then
        Font.Style := [fsItalic]
      else
        if Size = 'bold italic' then
        Font.Style := [fsBold, fsItalic];
    end;
    Result := True;
  end;
end;

{------------------------------------------------------------------------------}
function StrToGlyphType(S: string; Default: TXPGlyphType): TXPGlyphType;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'none' then
    Result := gtNone
  else
    if S = 'imageglyph' then
    Result := gtImageGlyph
  else
    if S = 'fontglyph' then
    Result := gtFontGlyph
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToHAlign(S: string; Default: TXPHAlign): TXPHAlign;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'left' then
    Result := haLeft
  else
    if S = 'center' then
    Result := haCenter
  else
    if S = 'right' then
    Result := haRight
  else
    Result := Default;
end;

function StrToIconEffect(S: string; Default: TXPIconEffect): TXPIconEffect;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'none' then
    Result := ieNone
  else
    if S = 'glow' then
    Result := ieGlow
  else
    if S = 'shadow' then
    Result := ieShadow
  else
    if S = 'pulse' then
    Result := iePulse
  else
    if S = 'alpha' then
    Result := ieAlpha
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToImageLayout(S: string; Default: TXPImageLayout): TXPImageLayout;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'vertical' then
    Result := ilVertical
  else
    if S = 'horizontal' then
    Result := ilHorizontal
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToImageSelect(S: string; Default: TXPImageSelect): TXPImageSelect;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'none' then
    Result := isNone
  else
    if S = 'dpi' then
    Result := isDPI
  else
    if S = 'size' then
    Result := isSize
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToMargins(S: string; const Default: TXPMargins): TXPMargins;
var
  P: integer;
begin
  S := Trim(S);
  P := Pos(',', S);
  if P > 0 then
  begin
    Result.cxLeftWidth := StrToIntDef(Copy(S, 1, P - 1), Default.cxLeftWidth);
    Delete(S, 1, P);
    S := TrimLeft(S);
    P := Pos(',', S);
    if P > 0 then
    begin
      Result.cxRightWidth := StrToIntDef(Copy(S, 1, P - 1), Default.cxRightWidth);
      Delete(S, 1, P);
      S := TrimLeft(S);
      P := Pos(',', S);
      if P > 0 then
      begin
        Result.cyTopHeight := StrToIntDef(Copy(S, 1, P - 1), Default.cyTopHeight);
        Delete(S, 1, P);
        S := TrimLeft(S);
        if Length(S) > 0 then
          Result.cyBottomHeight := StrToIntDef(S, Default.cyBottomHeight)
        else
          Result := Default;
      end
      else
        Result := Default;
    end
    else
      Result := Default;
  end
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToOffsetType(S: string; Default: TXPOffsetType): TXPOffsetType;
const
  Offsets: array[TXPOffsetType] of string = (
    'topleft', 'topright', 'topmiddle', 'bottomleft', 'bottomright',
    'bottommiddle', 'middleleft', 'middleright', 'leftofcaption',
    'rightofcaption', 'leftoflastbutton', 'rightoflastbutton',
    'abovelastbutton', 'belowlastbutton'
    );
var
  I: TXPOffsetType;
begin
  S := AnsiLowerCase(Trim(S));
  Result := Default;
  for I := Low(Default) to High(Default) do
    if Offsets[I] = S then
    begin
      Result := I;
      break;
    end;
end;

{------------------------------------------------------------------------------}
function StrToPoint(S: string; const Default: TPoint): TPoint;
var
  P: integer;
begin
  S := Trim(S);
  P := Pos(',', S);
  if P > 0 then
  begin
    Result.x := StrToIntDef(Copy(S, 1, P - 1), Default.x);
    Delete(S, 1, P);
    S := TrimLeft(S);
    if Length(S) > 0 then
      Result.y := StrToIntDef(S, Default.y)
    else
      Result := Default;
  end
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToRect(S: string; const Default: TRect): TRect;
var
  P: integer;
begin
  S := Trim(S);
  P := Pos(',', S);
  if P > 0 then
  begin
    Result.Left := StrToIntDef(Copy(S, 1, P - 1), Default.Left);
    Delete(S, 1, P);
    S := TrimLeft(S);
    P := Pos(',', S);
    if P > 0 then
    begin
      Result.Top := StrToIntDef(Copy(S, 1, P - 1), Default.Top);
      Delete(S, 1, P);
      S := TrimLeft(S);
      P := Pos(',', S);
      if P > 0 then
      begin
        Result.Right := StrToIntDef(Copy(S, 1, P - 1), Default.Right);
        Delete(S, 1, P);
        S := TrimLeft(S);
        if Length(S) > 0 then
          Result.Bottom := StrToIntDef(S, Default.Bottom)
        else
          Result := Default;
      end
      else
        Result := Default;
    end
    else
      Result := Default;
  end
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToShadowType(S: string; Default: TXPShadowType): TXPShadowType;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'none' then
    Result := stNone
  else
    if S = 'single' then
    Result := stSingle
  else
    if S = 'continuous' then
    Result := stContinuous
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToSize(S: string; const Default: TXPSize): TXPSize;
var
  P: integer;
begin
  S := Trim(S);
  P := Pos(',', S);
  if P > 0 then
  begin
    Result.cX := StrToIntDef(Copy(S, 1, P - 1), Default.cX);
    Delete(S, 1, P);
    S := TrimLeft(S);
    if Length(S) > 0 then
      Result.cY := StrToIntDef(S, Default.cY)
    else
      Result := Default;
  end
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToSizingType(S: string; Default: TXPSizingType): TXPSizingType;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'stretch' then
    Result := stStretch
  else
    if S = 'truesize' then
    Result := stTrueSize
  else
    if S = 'tile' then
    Result := stTile
  else
    if S = 'tilehorz' then
    Result := stTileHorz
  else
    if S = 'tilevert' then
    Result := stTileVert
  else
    if S = 'tilecenter' then
    Result := stTileCenter
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function StrToVAlign(S: string; Default: TXPVAlign): TXPVAlign;
begin
  S := AnsiLowerCase(Trim(S));
  if S = 'top' then
    Result := vaTop
  else
    if S = 'vcenter' then
    Result := vaCenter
  else
    if S = 'bottom' then
    Result := vaBottom
  else
    Result := Default;
end;

{------------------------------------------------------------------------------}
function XPMargins(Left, Right, Top, Bottom: integer): TXPMargins;
begin
  Result.cxLeftWidth := Left;
  Result.cxRightWidth := Right;
  Result.cyTopHeight := Top;
  Result.cyBottomHeight := Bottom;
end;

{------------------------------------------------------------------------------}
function XPSize(Width, Height: integer): TXPSize;
begin
  Result.cX := Width;
  Result.cY := Height;
end;

{------------------------------------------------------------------------------}
function NormalizeFileName(const FileName: string): string;
var
  I: integer;
begin
  Result := AnsiUpperCase(Trim(FileName));
  for I := 1 to Length(Result) do
    if AnsiPos(Result[I],'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_') = 0 then
      Result[I] := '_';
end;

end.
