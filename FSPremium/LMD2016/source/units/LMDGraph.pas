unit LMDGraph;
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

LMDGraph unit (RM)
------------------

Changes
-------
Release 10.0 (August 2009)
 + To TLMDFillStyle was added sfPng style

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Graphics, Classes, Types, Math,
  LMDUnicode, LMDSysIn;

type
  // <-- from LMD ElPack
  TLMDTextDrawType = (tdtNormal, tdtShadowed, tdtRaised);
  TLMDExButtonState = (ebsUp, ebsDisabled, ebsDown, ebsExclusive, ebsArrDown);
  TLMDVerticalAlign = (vaTop, vaMiddle, vaBottom);
  // ------------------
  {General}
  TLMDAngle=0..360;
  {3.X} TLMDDDArrowSize=2..10;
  TLMDBevelWidth=0..50;
  TLMDBorderWidth=0..255;
  //TLMDColorCount=2..236;
  TLMDColorCount=2..65535;
  TLMDShadowDepth=0..40;
  {ShadowStyle}
  TLMDShadowStyle=(hssNone, hssSolid, hssTracing);
  TLMDOrientation = (toHorizontal, toVertical);

  {TLMBevel}
  TLMDBevelStyle=(bvNone, bvLowered, bvRaised, bvFrameLowered, bvFrameRaised,
                  bvNormal, bvShadow, bvSpace, bvFlat);
  TLMDBevelMode=(bmCustom, bmStandard, bmEdge, bmWindows);

  TLMDBorderStyle=(lsNone, lsSingle,
                   lsLowered, lsRaised,
                   lsRaisedspb, lsLoweredspb,
                   lsRaisedExt, lsLoweredExt,
                   lsFrameInset, lsFrameOffset,
                   lsWindowBorder,
                   lsSingleRaised, lsSingleLowered,
                   lsDoubleRaised, lsDoubleLowered);

  {3.X, was placed in LMDExtCS before}
  TLMDEdgeStyle=(etRaisedInner, etRaisedOuter, etSunkenInner, etSunkenOuter,
                etBump, etEtched, etRaised, etSunken);
  TLMDFrameSide=(fsBottom, fsLeft, fsRight, fsTop);
  TLMDPosition=TLMDFrameSide;
  TLMDFrameSides=set of TLMDFrameSide;

  TLMDBorderSide = (ebsLeft, ebsRight, ebsTop, ebsBottom);
  TLMDBorderSides = set of TLMDBorderSide;
  //TElBorderSides=TLMDBorderSides;

const
  LMDFullBorderSides: TLMDBorderSides = [ebsLeft, ebsRight, ebsTop, ebsBottom];

type
  TLMDCutType = (ctNone, ctLine, ctRound);
  TLMDValueType = (vtAbsolute, vtPercent);
  TLMDCutValueUsage = (cvuBoth, cvuXOnly, cvuYOnly, cvuMin, cvuMax, cvuAverage);

  TLMDRectangleCorner = (rcTopLeft, rcTopRight, rcBottomLeft, rcBottomRight);
  {$NODEFINE TLMDCornerCut}
  TLMDCornerCut = array[TLMDRectangleCorner] of TLMDCutType;
  (*$HPPEMIT 'namespace Lmdgraph' *)
  (*$HPPEMIT '{' *)
  (*$HPPEMIT 'typedef Byte TLMDCornerCut[3];'*)
  (*$HPPEMIT '#define TLMDCornerCut TLMDCornerCut*'*)
  (*$HPPEMIT '}' *)
const
  cRoundCutCorners: TLMDCornerCut = (ctRound, ctRound, ctRound, ctRound);
  cLineCutCorners: TLMDCornerCut = (ctLine, ctLine, ctLine, ctLine);
  cRectCorners: TLMDCornerCut = (ctNone, ctNone, ctNone, ctNone);
    

type
  {3.X -> for TLMDGlyphTextLayout}
  TLMDTextArrange=(taLeft,taLeftTop,taRight,taRightTop,
                   taTop,taTopLeft, taBottom, taBottomLeft);

  {Labels}
  TLMDAlignment=(agTopLeft, agTopCenter, agTopRight, agCenterLeft,
                 agCenter, agCenterRight, agBottomLeft, agBottomCenter,
                 agBottomRight);

  TLMDFillStyle=(sfNone, sfBrushBitmap, sfBrush, sfBitmap, sfBitmapList, sfGradient, sfPng);

  TLMDTileMode=(tmNone, tmCenter, tmStretch, tmTile, tmVerticalTile, tmHorizontalTile);

  TLMDGradientStyle=(gstHorizontal, gstVertical, gstSquare, gstElliptic,
                     gstTopLeft, gstTopRight, gstBottomLeft, gstBottomRight,
                     gstTopLeftDiagonal, gstTopRightDiagonal{, gstRadial});

  TLMDBackgroundType = (bgtTileBitmap, bgtStretchBitmap, bgtColorFill,
                        bgtCenterBitmap, bgtTopLeftBitmap, bgtHorzGradient,
                        bgtVertGradient, bgtSquareGradient, bgtEllipticGradient,
                        bgtTopLeftGradient, bgtTopRightGradient, bgtBottomLeftGradient,
                        bgtBottomRightGradient, bgtTopLeftDiagonalGradient, bgtTopRightDiagonalGradient);

  TLMDDrawTextStyle=(dtDisabled,
                     dtEnabled,      {Draw String Enabled}
                     dt3DDisabled,   {Disabled State is drawn 3D}
                     dtClip,         {perform Clipping of Text within Rect}
                     dtAccelChar,
                     {--> flags for TLMDGlyphTextLayout}
                     dtAutoSize,
                     dtRectText,      {returns in scrRect destination rect of drawn text}
                     dtRectGlyph,     {returns in scrRect destination rect of drawn glyph}
                     dtRectGlyphText, {returns in scrRect destination rect of drawn text and glyph}
                     dtCalculate,     {calculate only, draw nothing}
                     dtGhostGlyph,    {draw text and use GlyphRect settings to align}
                     dtRectClip       {clip text output to available destination Rect, required for Path/End Ellipsis}
                     {--}
                     );
  TLMDDrawTextStyles=set of TLMDDrawTextStyle;

  TLMDGlyphTextFocusStyle = (fcControl, fcText, fcGlyph, fcGlyphText, fcNone);

  {3D-Style}
  TLMDThreeDStyle=(tdNone, tdSunken, tdRaised, tdSunkenShadow, tdRaisedShadow,
                   tdPColorSunken, tdPColorRaised, tdShadow, tdOutline, tdExtrude, tdExtrudeEnh);
  TLMDThreeDOrientation=(toBottomLeft, toBottomRight, toTopLeft, toTopRight);

  {Disabled-Style}
  TLMDDisabledStyle=(dsAuto, dsStandard, ds3d, dsNone);

  {Transparent-Style}
  TLMDTransparentMode=(tpNone, tpRestoreBack, tpTransparentColor, tpRBTranspColor);

  {3.02, moved default objects and types}
  {============================================================================}
  {TLMDBitmapStyle}
  TLMDBitmapStyle=(sbNone, sbAutosize, sbCenter, sbStretch, sbTile,
                   sbKeepAspRatio, sbKeepWidth, sbKeepHeight);

  {TLMDDirection}
  TLMDDirection=(tdRight, tdDown, tdLeft, tdUp);

  {3.5: TLMDBaseMeter Types}
  TLMDMeterDirection=(mdHorizontal, mdVertical, mdHorizontalReverse, mdVerticalReverse);
  TLMDMeterTextOptions=(toNoText, toCaption, toPercent);

  {graphical objects}
  {============================================================================}

const
  {Flags for Label}
  TLMDALIGNFLAGS:array[TLMDAlignment] of Word=
     (DT_Left, DT_Center, DT_RIGHT,
      DT_VCENTER or DT_Left, DT_VCENTER or DT_Center, DT_VCENTER or DT_RIGHT,
      DT_BOTTOM or DT_Left, DT_BOTTOM or DT_Center, DT_BOTTOM or DT_RIGHT);
  AllFrameSides: TLMDFrameSides = [fsLeft, fsRight, fsTop, fsBottom];
  {helper array for gradient's styles}
  LMDBackgroundType2GradientStyle: array[TLMDBackgroundType] of TLMDGradientStyle =
  (gstHorizontal, gstHorizontal, gstHorizontal, gstHorizontal, gstHorizontal,
   gstHorizontal, gstVertical, gstSquare, gstElliptic, gstTopLeft, gstTopRight,
   gstBottomLeft, gstBottomRight, gstTopLeftDiagonal, gstTopRightDiagonal);
   type
  {TLMDSavePixelFormat}
  TLMDSavePixelFormat=(spfDefault, spfMono, spf4bit, spf8bit, spf16bit);

  {LightColor-Styles}
  TLMDLightColor = (lcNone, lcBlue, lcRed, lcGreen, lcYellow, lcMarine, lcPurple);

  {--> TLMDGlyphTextFocusStyle, TLMDExtendedStyle}
  function LMDConvertFocusStyle(aValue:TLMDGlyphTextFocusStyle):TLMDDrawTextStyles;

  {routines}
  procedure LMDGetLightColors(aColorStyle:TLMDLightColor; var aC1, aC2:TColor);

  function LMDCornerCut(aTL, aTR, aBR, aBL: TLMDCutType): TLMDCornerCut;
  function LMDByteToCornerCut(aByte: byte): TLMDCornerCut;
  function LMDCornerCutToByte(aCC: TLMDCornerCut): byte;

  function LMDByteToFrameSides(aByte: byte): TLMDFrameSides;
  function LMDFrameSidesToByte(aFS: TLMDFrameSides): byte;

  procedure LMDCalcCutValues(var CutX, CutY: integer; px, py: integer; xvt, yvt: TLMDValueType; cvu: TLMDCutValueUsage; R: TRect);


implementation


function LMDCornerCut(aTL, aTR, aBR, aBL: TLMDCutType): TLMDCornerCut;
begin
  result[rcTopLeft] := aTL;
  result[rcTopRight] := aTR;
  result[rcBottomRight] := aBR;
  result[rcBottomLeft] := aBL;
end;

function LMDByteToCornerCut(aByte: byte): TLMDCornerCut;
begin
  //TL TR BR BL
  //00 00 00 00
  result[rcTopLeft] := TLMDCutType(aByte shr 6);
  result[rcTopRight] := TLMDCutType((aByte shr 4) and 3);
  result[rcBottomRight] := TLMDCutType((aByte shr 2) and 3);
  result[rcBottomLeft] := TLMDCutType(aByte and 3) ;
end;

function LMDCornerCutToByte(aCC: TLMDCornerCut): byte;
begin
  //TL TR BR BL
  //00 00 00 00
  result := (ord(aCC[rcTopLeft]) shl 6) + (ord(aCC[rcTopRight]) shl 4) + (ord(aCC[rcBottomRight]) shl 2) + ord(aCC[rcBottomLeft]);
end;

function LMDByteToFrameSides(aByte: byte): TLMDFrameSides;
begin
  result := [];
  if (aByte and 1) = 1 then result := result + [fsLeft];
  if (aByte and 2) = 2 then result := result + [fsTop];
  if (aByte and 4) = 4 then result := result + [fsRight];
  if (aByte and 8) = 8 then result := result + [fsBottom];
end;


function LMDFrameSidesToByte(aFS: TLMDFrameSides): byte;
begin
  result := 0;
  if fsLeft in aFS then result := result + 1;
  if fsTop  in aFS then result := result + 2;
  if fsRight in aFS then result := result + 4;
  if fsBottom in aFS then result := result + 8;
end;

// <-- from original LMDGraph.pas
function LMDConvertFocusStyle(aValue:TLMDGlyphTextFocusStyle):TLMDDrawTextStyles;
begin
  case aValue of
    fcText:result:=[dtRectText];
    fcGlyph:result:=[dtRectGlyph];
    fcGlyphText:result:=[dtRectGlyphText];
  else
    result:=[];
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDGetLightColors(aColorStyle:TLMDLightColor; var aC1, aC2:TColor);
begin
  case aColorStyle of
    lcNone:begin aC1:=clBtnFace; aC2:=clBtnFace;end;
    lcRed:begin aC1:=clRed; aC2:=clMaroon; end;
    lcGreen:begin aC1:=clLime; aC2:=clGreen; end;
    lcBlue:begin aC1:=clBlue; aC2:=clNavy; end;
    lcYellow:begin aC1:=clYellow; aC2:=clOlive; end;
    lcMarine:begin aC1:=clAqua; aC2:=clTeal; end;
    lcPurple:begin aC1:=clFuchsia; aC2:=clPurple;end;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDCalcCutValues(var CutX, CutY: integer; px, py: integer; xvt, yvt: TLMDValueType; cvu: TLMDCutValueUsage; R: TRect);
var
  ac, w, h: integer;
begin
  if xvt = vtAbsolute then
    CutX := px
  else
    begin
      w := R.Right - R.Left;
      CutX := MulDiv(w, px, 100);
    end;
  if yvt = vtAbsolute then
    CutY := py
  else
    begin
      h := R.Bottom - R.Top;
      CutY := MulDiv(h, py, 100);
    end;
  case cvu of
    cvuBoth: ;
    cvuXOnly: CutY := CutX;
    cvuYOnly: CutX := CutY;
    cvuMin: if CutX > CutY then
              CutX := CutY
            else
              CutY := CutX;
    cvuMax: if CutX < CutY then
              CutX := CutY
            else
              CutY := CutX;
    cvuAverage: begin
                  ac := (CutX + CutY) div 2;
                  CutX := ac;
                  CutY := ac;
                end;
  end;
end;

end.
