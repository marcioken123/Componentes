// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxUtils.pas' rev: 31.00 (Windows)

#ifndef LmdfxutilsHPP
#define LmdfxutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <LMDFxBitmap.hpp>
#include <LMDSysIn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxutils
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef System::Set<char, _DELPHI_SET_CHAR(0), _DELPHI_SET_CHAR(255)> TTokenSeparators;

enum DECLSPEC_DENUM TLMDFxMaskMode : unsigned char { mmExclude, mmInclude };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Graphics::TPixelFormat CPixelFormat;
extern DELPHI_PACKAGE HWND CaptureHandle;
extern DELPHI_PACKAGE void __fastcall CaptureMouse(const HWND Wnd);
extern DELPHI_PACKAGE void __fastcall EndCapture(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetToken(System::UnicodeString &S)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetToken(System::UnicodeString &S, System::UnicodeString Separators)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetToken(System::UnicodeString &S, const TTokenSeparators &Separators)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall RectToString(const System::Types::TRect &R);
extern DELPHI_PACKAGE System::Types::TRect __fastcall StringToRect(System::UnicodeString S);
extern DELPHI_PACKAGE System::WideString __fastcall FormatStr(HDC DC, System::WideString S, int Width)/* overload */;
extern DELPHI_PACKAGE int __fastcall RectWidth(const System::Types::TRect &R);
extern DELPHI_PACKAGE int __fastcall RectHeight(const System::Types::TRect &R);
extern DELPHI_PACKAGE System::Types::TRect __fastcall RectVCenter(System::Types::TRect &R, const System::Types::TRect &Bounds);
extern DELPHI_PACKAGE System::Types::TRect __fastcall RectHCenter(System::Types::TRect &R, const System::Types::TRect &Bounds);
extern DELPHI_PACKAGE System::Types::TRect __fastcall RectCenter(System::Types::TRect &R, const System::Types::TRect &Bounds);
extern DELPHI_PACKAGE System::Types::TRect __fastcall RectOffset(const System::Types::TRect &ARect, int Offset);
extern DELPHI_PACKAGE bool __fastcall IsRectEmpty(const System::Types::TRect &Rect);
extern DELPHI_PACKAGE System::Types::TRect __fastcall MarginRect(const System::Types::TRect &ARect, const System::Types::TRect &AMargin);
extern DELPHI_PACKAGE bool __fastcall RectInRect(const System::Types::TRect &ARect, const System::Types::TRect &ABounds);
extern DELPHI_PACKAGE bool __fastcall CompareRect(const System::Types::TRect &Rect1, const System::Types::TRect &Rect2);
extern DELPHI_PACKAGE bool __fastcall PointInPolygon(const System::Types::TPoint &P, const System::Types::TPoint *Points, const int Points_High);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall GetClientOrigin(Vcl::Controls::TControl* AControl);
extern DELPHI_PACKAGE System::Types::TRect __fastcall GetRealClientRect(Vcl::Controls::TControl* AControl);
extern DELPHI_PACKAGE System::Types::TRect __fastcall GetRealBoundsRect(Vcl::Controls::TControl* AControl);
extern DELPHI_PACKAGE void __fastcall DrawFrameControlGlyph(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, unsigned AType, unsigned AStyle, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE int __fastcall DrawText(Vcl::Graphics::TCanvas* ACanvas, System::WideString AText, System::Types::TRect &Bounds, unsigned Flag)/* overload */;
extern DELPHI_PACKAGE int __fastcall DrawText(Vcl::Graphics::TCanvas* ACanvas, System::WideString AText, int X, int Y)/* overload */;
extern DELPHI_PACKAGE int __fastcall DrawVerticalText(Vcl::Graphics::TCanvas* Canvas, System::WideString AText, const System::Types::TRect &Bounds, unsigned Flag, bool FromTop);
extern DELPHI_PACKAGE int __fastcall TextWidth(Vcl::Graphics::TCanvas* Canvas, System::WideString AText, int Flags = 0x0);
extern DELPHI_PACKAGE int __fastcall TextHeight(Vcl::Graphics::TCanvas* Canvas, System::WideString AText);
extern DELPHI_PACKAGE void __fastcall MoveTo(Vcl::Graphics::TCanvas* Canvas, int X, int Y);
extern DELPHI_PACKAGE void __fastcall LineTo(Vcl::Graphics::TCanvas* Canvas, int X, int Y, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall DrawEdge(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, System::Uitypes::TColor RaisedColor, System::Uitypes::TColor SunkenColor)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawEdge(Vcl::Graphics::TCanvas* Canvas, int ALeft, int ATop, int ARight, int ABottom, System::Uitypes::TColor RaisedColor, System::Uitypes::TColor SunkenColor)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawRect(Vcl::Graphics::TCanvas* Canvas, int ALeft, int ATop, int ARight, int ABottom, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawFocusRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall FillRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall FillRect(Vcl::Graphics::TCanvas* Canvas, int ALeft, int ATop, int ARight, int ABottom, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall FillEllipse(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall FillEllipse(Vcl::Graphics::TCanvas* Canvas, int ALeft, int ATop, int ARight, int ABottom, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawRoundRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, int Radius, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall FillRoundRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, int Radius, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall FillGradientRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, System::Uitypes::TColor BeginColor, System::Uitypes::TColor EndColor, bool Vertical);
extern DELPHI_PACKAGE void __fastcall FillRadialGradientRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, System::Uitypes::TColor BeginColor, System::Uitypes::TColor EndColor, const System::Types::TPoint &Pos);
extern DELPHI_PACKAGE void __fastcall FillHalftoneRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, System::Uitypes::TColor Color, System::Uitypes::TColor HalfColor);
extern DELPHI_PACKAGE void __fastcall DrawPolygon(Vcl::Graphics::TCanvas* Canvas, System::Types::TPoint *Points, const int Points_High, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall FillPolygon(Vcl::Graphics::TCanvas* Canvas, System::Types::TPoint *Points, const int Points_High, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE void __fastcall FillHalftonePolygon(Vcl::Graphics::TCanvas* Canvas, System::Types::TPoint *Points, const int Points_High, System::Uitypes::TColor Color, System::Uitypes::TColor HalfColor);
extern DELPHI_PACKAGE void __fastcall DrawIcon(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, Vcl::Graphics::TIcon* AIcon)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawIcon(HDC DC, const System::Types::TRect &ARect, Vcl::Graphics::TIcon* AIcon)/* overload */;
extern DELPHI_PACKAGE void __fastcall DrawGlyphShadow(Vcl::Graphics::TCanvas* Canvas, int X, int Y, Lmdfxbitmap::TLMDFxBitmap* Glyph, System::Uitypes::TColor Color);
extern DELPHI_PACKAGE HBRUSH __fastcall CreateHalftoneBrush(System::Uitypes::TColor Color);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReadString(System::Classes::TStream* S);
extern DELPHI_PACKAGE void __fastcall WriteString(System::Classes::TStream* S, System::UnicodeString Value);
extern DELPHI_PACKAGE HRGN __fastcall CreateRegionFromBitmap(Lmdfxbitmap::TLMDFxBitmap* Bitmap, int Left, int Top);
extern DELPHI_PACKAGE HRGN __fastcall CreateRegionFromPicture(Vcl::Graphics::TPicture* APicture, int Width, int Height, System::Uitypes::TColor MaskColor, TLMDFxMaskMode MaskMode);
extern DELPHI_PACKAGE int __fastcall GetKeyBoardDelayInterval(void);
extern DELPHI_PACKAGE int __fastcall GetKeyBoardSpeedInterval(void);
extern DELPHI_PACKAGE bool __fastcall HasMMX(void);
extern DELPHI_PACKAGE void __fastcall EMMS(void);
extern DELPHI_PACKAGE System::WideString __fastcall StringToWideString(unsigned CodePage, const System::AnsiString s);
extern DELPHI_PACKAGE Vcl::Graphics::TPixelFormat __fastcall GetPixelFormat(void);
}	/* namespace Lmdfxutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXUTILS)
using namespace Lmdfxutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxutilsHPP
