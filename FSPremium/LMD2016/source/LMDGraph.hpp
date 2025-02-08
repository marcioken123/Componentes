// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGraph.pas' rev: 31.00 (Windows)

#ifndef LmdgraphHPP
#define LmdgraphHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <LMDUnicode.hpp>
#include <LMDSysIn.hpp>

//-- user supplied -----------------------------------------------------------
namespace Lmdgraph
{
typedef Byte TLMDCornerCut[3];
#define TLMDCornerCut TLMDCornerCut*
}

namespace Lmdgraph
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTextDrawType : unsigned char { tdtNormal, tdtShadowed, tdtRaised };

enum DECLSPEC_DENUM TLMDExButtonState : unsigned char { ebsUp, ebsDisabled, ebsDown, ebsExclusive, ebsArrDown };

enum DECLSPEC_DENUM TLMDVerticalAlign : unsigned char { vaTop, vaMiddle, vaBottom };

typedef System::Word TLMDAngle;

typedef System::Int8 TLMDDDArrowSize;

typedef System::Int8 TLMDBevelWidth;

typedef System::Byte TLMDBorderWidth;

typedef System::Word TLMDColorCount;

typedef System::Int8 TLMDShadowDepth;

enum DECLSPEC_DENUM TLMDShadowStyle : unsigned char { hssNone, hssSolid, hssTracing };

enum DECLSPEC_DENUM TLMDOrientation : unsigned char { toHorizontal, toVertical };

enum DECLSPEC_DENUM TLMDBevelStyle : unsigned char { bvNone, bvLowered, bvRaised, bvFrameLowered, bvFrameRaised, bvNormal, bvShadow, bvSpace, bvFlat };

enum DECLSPEC_DENUM TLMDBevelMode : unsigned char { bmCustom, bmStandard, bmEdge, bmWindows };

enum DECLSPEC_DENUM TLMDBorderStyle : unsigned char { lsNone, lsSingle, lsLowered, lsRaised, lsRaisedspb, lsLoweredspb, lsRaisedExt, lsLoweredExt, lsFrameInset, lsFrameOffset, lsWindowBorder, lsSingleRaised, lsSingleLowered, lsDoubleRaised, lsDoubleLowered };

enum DECLSPEC_DENUM TLMDEdgeStyle : unsigned char { etRaisedInner, etRaisedOuter, etSunkenInner, etSunkenOuter, etBump, etEtched, etRaised, etSunken };

enum DECLSPEC_DENUM TLMDFrameSide : unsigned char { fsBottom, fsLeft, fsRight, fsTop };

typedef TLMDFrameSide TLMDPosition;

typedef System::Set<TLMDFrameSide, TLMDFrameSide::fsBottom, TLMDFrameSide::fsTop> TLMDFrameSides;

enum DECLSPEC_DENUM TLMDBorderSide : unsigned char { ebsLeft, ebsRight, ebsTop, ebsBottom };

typedef System::Set<TLMDBorderSide, TLMDBorderSide::ebsLeft, TLMDBorderSide::ebsBottom> TLMDBorderSides;

enum DECLSPEC_DENUM TLMDCutType : unsigned char { ctNone, ctLine, ctRound };

enum DECLSPEC_DENUM TLMDValueType : unsigned char { vtAbsolute, vtPercent };

enum DECLSPEC_DENUM TLMDCutValueUsage : unsigned char { cvuBoth, cvuXOnly, cvuYOnly, cvuMin, cvuMax, cvuAverage };

enum DECLSPEC_DENUM TLMDRectangleCorner : unsigned char { rcTopLeft, rcTopRight, rcBottomLeft, rcBottomRight };

enum DECLSPEC_DENUM TLMDTextArrange : unsigned char { taLeft, taLeftTop, taRight, taRightTop, taTop, taTopLeft, taBottom, taBottomLeft };

enum DECLSPEC_DENUM TLMDAlignment : unsigned char { agTopLeft, agTopCenter, agTopRight, agCenterLeft, agCenter, agCenterRight, agBottomLeft, agBottomCenter, agBottomRight };

enum DECLSPEC_DENUM TLMDFillStyle : unsigned char { sfNone, sfBrushBitmap, sfBrush, sfBitmap, sfBitmapList, sfGradient, sfPng };

enum DECLSPEC_DENUM TLMDTileMode : unsigned char { tmNone, tmCenter, tmStretch, tmTile, tmVerticalTile, tmHorizontalTile };

enum DECLSPEC_DENUM TLMDGradientStyle : unsigned char { gstHorizontal, gstVertical, gstSquare, gstElliptic, gstTopLeft, gstTopRight, gstBottomLeft, gstBottomRight, gstTopLeftDiagonal, gstTopRightDiagonal };

enum DECLSPEC_DENUM TLMDBackgroundType : unsigned char { bgtTileBitmap, bgtStretchBitmap, bgtColorFill, bgtCenterBitmap, bgtTopLeftBitmap, bgtHorzGradient, bgtVertGradient, bgtSquareGradient, bgtEllipticGradient, bgtTopLeftGradient, bgtTopRightGradient, bgtBottomLeftGradient, bgtBottomRightGradient, bgtTopLeftDiagonalGradient, bgtTopRightDiagonalGradient };

enum DECLSPEC_DENUM TLMDDrawTextStyle : unsigned char { dtDisabled, dtEnabled, dt3DDisabled, dtClip, dtAccelChar, dtAutoSize, dtRectText, dtRectGlyph, dtRectGlyphText, dtCalculate, dtGhostGlyph, dtRectClip };

typedef System::Set<TLMDDrawTextStyle, TLMDDrawTextStyle::dtDisabled, TLMDDrawTextStyle::dtRectClip> TLMDDrawTextStyles;

enum DECLSPEC_DENUM TLMDGlyphTextFocusStyle : unsigned char { fcControl, fcText, fcGlyph, fcGlyphText, fcNone };

enum DECLSPEC_DENUM TLMDThreeDStyle : unsigned char { tdNone, tdSunken, tdRaised, tdSunkenShadow, tdRaisedShadow, tdPColorSunken, tdPColorRaised, tdShadow, tdOutline, tdExtrude, tdExtrudeEnh };

enum DECLSPEC_DENUM TLMDThreeDOrientation : unsigned char { toBottomLeft, toBottomRight, toTopLeft, toTopRight };

enum DECLSPEC_DENUM TLMDDisabledStyle : unsigned char { dsAuto, dsStandard, ds3d, dsNone };

enum DECLSPEC_DENUM TLMDTransparentMode : unsigned char { tpNone, tpRestoreBack, tpTransparentColor, tpRBTranspColor };

enum DECLSPEC_DENUM TLMDBitmapStyle : unsigned char { sbNone, sbAutosize, sbCenter, sbStretch, sbTile, sbKeepAspRatio, sbKeepWidth, sbKeepHeight };

enum DECLSPEC_DENUM TLMDDirection : unsigned char { tdRight, tdDown, tdLeft, tdUp };

enum DECLSPEC_DENUM TLMDMeterDirection : unsigned char { mdHorizontal, mdVertical, mdHorizontalReverse, mdVerticalReverse };

enum DECLSPEC_DENUM TLMDMeterTextOptions : unsigned char { toNoText, toCaption, toPercent };

enum DECLSPEC_DENUM TLMDSavePixelFormat : unsigned char { spfDefault, spfMono, spf4bit, spf8bit, spf16bit };

enum DECLSPEC_DENUM TLMDLightColor : unsigned char { lcNone, lcBlue, lcRed, lcGreen, lcYellow, lcMarine, lcPurple };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDBorderSides LMDFullBorderSides;
extern DELPHI_PACKAGE TLMDCornerCut cRoundCutCorners;
extern DELPHI_PACKAGE TLMDCornerCut cLineCutCorners;
extern DELPHI_PACKAGE TLMDCornerCut cRectCorners;
extern DELPHI_PACKAGE System::StaticArray<System::Word, 9> TLMDALIGNFLAGS;
extern DELPHI_PACKAGE TLMDFrameSides AllFrameSides;
extern DELPHI_PACKAGE System::StaticArray<TLMDGradientStyle, 15> LMDBackgroundType2GradientStyle;
extern DELPHI_PACKAGE TLMDCornerCut __fastcall LMDCornerCut(TLMDCutType aTL, TLMDCutType aTR, TLMDCutType aBR, TLMDCutType aBL);
extern DELPHI_PACKAGE TLMDCornerCut __fastcall LMDByteToCornerCut(System::Byte aByte);
extern DELPHI_PACKAGE System::Byte __fastcall LMDCornerCutToByte(TLMDCornerCut aCC);
extern DELPHI_PACKAGE TLMDFrameSides __fastcall LMDByteToFrameSides(System::Byte aByte);
extern DELPHI_PACKAGE System::Byte __fastcall LMDFrameSidesToByte(TLMDFrameSides aFS);
extern DELPHI_PACKAGE TLMDDrawTextStyles __fastcall LMDConvertFocusStyle(TLMDGlyphTextFocusStyle aValue);
extern DELPHI_PACKAGE void __fastcall LMDGetLightColors(TLMDLightColor aColorStyle, System::Uitypes::TColor &aC1, System::Uitypes::TColor &aC2);
extern DELPHI_PACKAGE void __fastcall LMDCalcCutValues(int &CutX, int &CutY, int px, int py, TLMDValueType xvt, TLMDValueType yvt, TLMDCutValueUsage cvu, const System::Types::TRect &R);
}	/* namespace Lmdgraph */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRAPH)
using namespace Lmdgraph;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgraphHPP
