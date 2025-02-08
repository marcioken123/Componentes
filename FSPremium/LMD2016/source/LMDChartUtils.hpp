// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartUtils.pas' rev: 31.00 (Windows)

#ifndef LmdchartutilsHPP
#define LmdchartutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <LMDChartLine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartutils
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::Types::TPoint, 4> TPointsArr;

enum DECLSPEC_DENUM TLMDChartTickTypes : unsigned char { ttInside, ttOutside, ttCross, ttNone };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall DrawRectangleShadow(int ALeft, int ATop, int AWidth, int AHeight, Vcl::Graphics::TBitmap* ATarget, System::Uitypes::TColor FShadowColor, System::Byte FShadowDepth, System::Byte FShadowTransparency, bool FShadow);
extern DELPHI_PACKAGE void __fastcall PieSlice(Vcl::Graphics::TCanvas* ATarget, const System::Types::TRect &AArea, double AAngleStart, double AAngleEnd);
extern DELPHI_PACKAGE void __fastcall DnutSlice(Vcl::Graphics::TCanvas* ATarget, const System::Types::TRect &AArea, double AAngleStart, double AAngleEnd, int SliceWidth);
extern DELPHI_PACKAGE void __fastcall DrawTransparency(Vcl::Graphics::TBitmap* ATarget, Vcl::Graphics::TBitmap* AWhiteBuf, Vcl::Graphics::TBitmap* ABlackBuf, bool AShadow, System::Uitypes::TColor AShadowColor, System::Byte AShadowDepth, System::Byte AShadowAlpha, System::Byte AGfxAlpha);
extern DELPHI_PACKAGE void __fastcall DrawLines(const TPointsArr &points, Vcl::Graphics::TCanvas* ATarget)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawLines(int pointX1, int pointY1, int pointX2, int pointY2, int pointX3, int pointY3, int pointX4, int pointY4, Vcl::Graphics::TCanvas* ATarget)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawLineWithoutMove(int x, int y, Vcl::Graphics::TCanvas* ATarget);
extern DELPHI_PACKAGE void __fastcall DrawLine(int AStartX, int AStartY, int AEndX, int AEndY, Vcl::Graphics::TCanvas* ATarget);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall rgb(System::Byte r, System::Byte g, System::Byte b);
extern DELPHI_PACKAGE void __fastcall HGradienCalc(System::Uitypes::TColor AFromColor, System::Uitypes::TColor AToColor, System::Uitypes::TColor *AColorArray, const int AColorArray_High);
extern DELPHI_PACKAGE void __fastcall Box(Vcl::Graphics::TCanvas* ATarget, const System::Types::TRect &ABox, int ADepth, bool AShaded);
extern DELPHI_PACKAGE void __fastcall Plane(Vcl::Graphics::TCanvas* ATarget, const System::Types::TPoint &ALineStart, const System::Types::TPoint &ALineEnd, int ADepth, TPointsArr &AToRet);
extern DELPHI_PACKAGE void __fastcall Line(Vcl::Graphics::TCanvas* ATarget, const System::Types::TPoint &AStartPoint, int ADepth);
extern DELPHI_PACKAGE void __fastcall PolygonExtrude(Vcl::Graphics::TCanvas* ATarget, System::Types::TPoint *APoly, const int APoly_High, int ADepth, bool AShaded);
extern DELPHI_PACKAGE void __fastcall HermitSplineExtArea(Vcl::Graphics::TCanvas* ATarget, System::Types::TPoint *ar, const int ar_High, int steps, double a, int ZeroLevel);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall ShadowColor(System::Uitypes::TColor Color, System::Byte Value);
extern DELPHI_PACKAGE System::Variant __fastcall SmartRoundUp(const System::Variant &Value, const System::Variant &Step);
extern DELPHI_PACKAGE System::Variant __fastcall SmartRoundDown(const System::Variant &Value, const System::Variant &Step);
extern DELPHI_PACKAGE void __fastcall DrawXTick(Vcl::Graphics::TCanvas* ATarget, int AXPosition, int AYPosition, int ATickSize, TLMDChartTickTypes ATickTyp, Lmdchartline::TLMDChartLine* ALine);
extern DELPHI_PACKAGE void __fastcall DrawYTick(Vcl::Graphics::TCanvas* ATarget, int AXPosition, int AYPosition, int ATickSize, TLMDChartTickTypes ATickTyp, Lmdchartline::TLMDChartLine* ALine);
}	/* namespace Lmdchartutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTUTILS)
using namespace Lmdchartutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartutilsHPP
