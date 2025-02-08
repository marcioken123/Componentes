// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGraphUtils.pas' rev: 31.00 (Windows)

#ifndef LmdgraphutilsHPP
#define LmdgraphutilsHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <LMDRTLXConst.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDBmp.hpp>
#include <LMDUnicode.hpp>
#include <LMDGraph.hpp>
#include <LMDSysIn.hpp>
#include <LMDFXCaption.hpp>
#include <LMD3DCaption.hpp>
#include <LMDButtonLayout.hpp>
#include <LMDGradient.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <LMDButtonBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdgraphutils
{
//-- forward type declarations -----------------------------------------------
struct TColorRGB;
struct TColorBGRA;
struct TLMDWhereRect;
//-- type declarations -------------------------------------------------------
typedef System::LongBool __stdcall (*TAlphaBlend)(HDC DC, int p2, int p3, int p4, int p5, HDC DC6, int p7, int p8, int p9, int p10, _BLENDFUNCTION p11);

typedef System::LongBool __stdcall (*TTransparentBlt)(HDC DC, int p2, int p3, int p4, int p5, HDC DC6, int p7, int p8, int p9, int p10, unsigned p11);

enum DECLSPEC_DENUM TLMDArrowDir : unsigned char { eadLeft, eadUp, eadRight, eadDown };

typedef unsigned TLMDARGBColor;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TColorRGB
{
public:
	System::Byte R;
	System::Byte G;
	System::Byte B;
	System::Byte A;
};
#pragma pack(pop)


typedef TColorRGB *PColorRGB;

typedef TColorBGRA *PColorBGRA;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TColorBGRA
{
public:
	System::Byte Blue;
	System::Byte Green;
	System::Byte Red;
	System::Byte Alpha;
};
#pragma pack(pop)


struct DECLSPEC_DRECORD TLMDWhereRect
{
public:
	System::Types::TRect CompleteRect;
	System::Types::TRect TextRect;
	System::Types::TRect GlyphRect;
	System::Types::TRect ArrowRect;
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 DSF_CLIPRECT = System::Int8(0x1);
static const System::Int8 DSF_USEOFFSCREENBITMAP = System::Int8(0x4);
static const System::Int8 DSF_CENTER = System::Int8(0x8);
static const System::Int8 DSF_STRETCH = System::Int8(0x10);
static const System::Int8 DSF_TILE = System::Int8(0x20);
static const System::Int8 DSF_TRANSPARENCY = System::Int8(0x40);
static const System::Byte DSF_BRUSHCOPY = System::Byte(0x80);
static const System::Word DSF_TRANSPARENCY_MASK = System::Word(0x100);
static const System::Word DSF_KEEPWIDTH = System::Word(0x200);
static const System::Word DSF_KEEPHEIGHT = System::Word(0x400);
static const System::Word DSF_PALETTEREALIZE = System::Word(0x1000);
static const System::Word DSF_KEEPRATIO = System::Word(0x600);
static const System::Word DSF_STRETCHKEEPHEIGHT = System::Word(0x410);
static const System::Word DSF_STRETCHKEEPWIDTH = System::Word(0x210);
static const System::Word DSF_STRETCHKEEPRATIO = System::Word(0x610);
static const int ROP_DSPDxax = int(0xe20746);
static const int DT_LMDCUSTOMDRAW = int(0x10000000);
static const System::Word scWin = System::Word(0x9000);
static const System::Int8 MinDistForAntiAliasing = System::Int8(0x0);
static const System::Byte MaxDistForAntiAliasing = System::Byte(0xff);
extern DELPHI_PACKAGE void __fastcall LMDDrawParentBackground(HWND Wnd, HDC DC, System::Types::PRect ARect);
extern DELPHI_PACKAGE System::LongBool __stdcall LMDAlphaBlend(HDC DC, int p2, int p3, int p4, int p5, HDC DC6, int p7, int p8, int p9, int p10, _BLENDFUNCTION p11);
extern DELPHI_PACKAGE System::LongBool __stdcall LMDTransparentBlt(HDC DC, int p2, int p3, int p4, int p5, HDC DC6, int p7, int p8, int p9, int p10, unsigned p11);
extern DELPHI_PACKAGE void __fastcall LMDCheckHLSRange(int &hls);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDColorLighter(const System::Uitypes::TColor Color, const System::Byte Percent);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDColorDarker(const System::Uitypes::TColor OriginalColor, const System::Byte Percent);
extern DELPHI_PACKAGE int __fastcall LMDIncColor(const System::Uitypes::TColor Color, int RInc, int GInc, int BInc);
extern DELPHI_PACKAGE void __fastcall LMDExtDrawBkgnd2(HDC DC, const System::Types::TRect &R, const System::Types::TRect &DocRect, const System::Types::TPoint &Origin, System::Uitypes::TColor FillColor, Vcl::Graphics::TBitmap* SourceBitmap, Lmdgraph::TLMDBackgroundType DrawMode);
extern DELPHI_PACKAGE void __fastcall LMDExtDrawBkgnd(HDC DC, const System::Types::TRect &RectDoc, const System::Types::TRect &RectWindow, const System::Types::TRect &RectDC, const System::Types::TRect &RectOnDC, bool InvertedMode, System::Uitypes::TColor FillColor, System::Uitypes::TColor OverColor, Vcl::Graphics::TBitmap* SourceBitmap, Lmdgraph::TLMDBackgroundType DrawMode);
extern DELPHI_PACKAGE bool __fastcall LMDExtTextOut(Vcl::Graphics::TCanvas* const ACanvas, int X, int Y, int Options, System::Types::PRect Rect, Lmdtypes::TLMDString Str, int Count);
extern DELPHI_PACKAGE int __fastcall LMDRGBtoHLS(int rgbc);
extern DELPHI_PACKAGE int __fastcall LMDHLStoRGB(int hlsc);
extern DELPHI_PACKAGE int __fastcall LMDRGBToHSB(int rgbc);
extern DELPHI_PACKAGE void __fastcall LMDSetDisabled(Vcl::Graphics::TBitmap* FOriginal);
extern DELPHI_PACKAGE void __fastcall LMDSetGrayscaleDisabled(Vcl::Graphics::TBitmap* const FOriginal);
extern DELPHI_PACKAGE void __fastcall LMDAlphaCopyRect(HDC DestDC, const System::Types::TRect &Dest, HDC SourceDC, const System::Types::TRect &Source, System::Byte AlphaLevel, bool UseAlphaLevel);
extern DELPHI_PACKAGE void __fastcall LMDAlphaFillRect(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &ARect, System::Uitypes::TColor Color, System::Byte AlphaLevel)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDAlphaFillRect(NativeUInt ADC, const System::Types::TRect &ARect, System::Uitypes::TColor Color, System::Byte AlphaLevel)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDAlphaCopyRect2(HDC DestDC, const System::Types::TRect &Dest, HDC SourceDC, const System::Types::TRect &Source, Vcl::Graphics::TBitmap* Mask, System::Byte AlphaLevel);
extern DELPHI_PACKAGE bool __fastcall LMDIsAlphaEmpty(Vcl::Graphics::TBitmap* bmp);
extern DELPHI_PACKAGE int __fastcall LMDDrawTextW(HDC hDC, System::WideChar * lpString, int nCount, System::Types::TRect &lpRect, unsigned uFormat);
extern DELPHI_PACKAGE int __fastcall LMDDrawText(HDC hDC, const Lmdtypes::TLMDString lpString, int nCount, System::Types::TRect &lpRect, unsigned uFormat);
extern DELPHI_PACKAGE System::Types::TSize __fastcall LMDGetTextExtent(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString AText);
extern DELPHI_PACKAGE int __fastcall LMDGetTextHeight(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString AText);
extern DELPHI_PACKAGE int __fastcall LMDGetTextWidth(Vcl::Graphics::TCanvas* ACanvas, const Lmdtypes::TLMDString AText);
extern DELPHI_PACKAGE void __fastcall LMDDrawTypedTextW(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Bounds, const System::WideString Text, int Flags, Lmdgraph::TLMDTextDrawType DrawType);
extern DELPHI_PACKAGE void __fastcall LMDDrawTypedText(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Bounds, const System::UnicodeString Text, int Flags, Lmdgraph::TLMDTextDrawType DrawType);
extern DELPHI_PACKAGE void __fastcall LMDDrawTransparentBitmapEx(HDC DC, Vcl::Graphics::TBitmap* Bitmap, int X, int Y, const System::Types::TRect &Src, System::Uitypes::TColor Transparent);
extern DELPHI_PACKAGE void __fastcall LMDTiledPaint(Vcl::Graphics::TCanvas* Canvas, Vcl::Graphics::TBitmap* Bitmap, const System::Types::TRect &ARect)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDTiledPaint(HDC ADC, Vcl::Graphics::TBitmap* Bitmap, const System::Types::TRect &ARect)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDDrawButtonFrame(HDC DC, const System::Types::TRect &rc, bool Focused, bool Pushed, System::Uitypes::TColor ButtonColor, bool Thin, Lmdgraph::TLMDBorderSides BorderSides)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDDrawButtonFrame(HDC DC, const System::Types::TRect &rc, bool Focused, bool Pushed, System::Uitypes::TColor ButtonColor, bool Thin, System::Uitypes::TColor clrHighlight, System::Uitypes::TColor clrDkShadow, System::Uitypes::TColor clrFace, System::Uitypes::TColor clrShadow, Lmdgraph::TLMDBorderSides BorderSides)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDDrawFrame3D(Vcl::Graphics::TCanvas* aCanvas, System::Types::TRect &dRect, Lmdgraph::TLMDBevelStyle Style, System::Uitypes::TColor LightColor, System::Uitypes::TColor ShadowColor, int Depth);
extern DELPHI_PACKAGE bool __fastcall LMDDrawFrameShadow(Vcl::Graphics::TCanvas* aCanvas, System::Types::TRect &aRect, System::Uitypes::TColor LightColor, System::Uitypes::TColor ShadowColor, System::Uitypes::TColor BorderColor, Lmdgraph::TLMDBorderWidth WidthOuter, Lmdgraph::TLMDBorderWidth WidthInner, bool Transparent, System::Word flags);
extern DELPHI_PACKAGE int __fastcall LMDDrawStdFrameExt(Lmdgraph::TLMDBorderStyle Style);
extern DELPHI_PACKAGE bool __fastcall LMDDrawStdFrame(Vcl::Graphics::TCanvas* aCanvas, System::Types::TRect &aRect, Lmdgraph::TLMDBorderStyle Style, System::Word flags)/* overload */;
extern DELPHI_PACKAGE bool __fastcall LMDDrawStdFrame(HDC AHdc, System::Types::TRect &aRect, Lmdgraph::TLMDBorderStyle Style, System::Word flags)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDDrawBorder(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aBounds, System::Uitypes::TColor ULColor, System::Uitypes::TColor LRColor);
extern DELPHI_PACKAGE System::Byte __fastcall LMDGetCtrlBorderWidth(bool aCtl3D, Vcl::Forms::TBorderStyle aBorderStyle, bool useXP = false);
extern DELPHI_PACKAGE void __fastcall LMDBmpCreateFromRect(Vcl::Graphics::TBitmap* aValue, const System::Types::TRect &aRect, System::Uitypes::TColor fColor = (System::Uitypes::TColor)(0x1fffffff));
extern DELPHI_PACKAGE void __fastcall LMDBmpCreateGrayscale(Vcl::Graphics::TBitmap* Dest, Vcl::Graphics::TBitmap* Src);
extern DELPHI_PACKAGE void __fastcall LMDBmpCreateMasks(Vcl::Graphics::TBitmap* const srcBmp, Vcl::Graphics::TBitmap* Mask, Vcl::Graphics::TBitmap* NewImage, System::Uitypes::TColor MaskColor);
extern DELPHI_PACKAGE void __fastcall LMDBmpCreateMasksExt(Vcl::Graphics::TCanvas* srcCanvas, const System::Types::TRect &srcRect, Vcl::Graphics::TBitmap* aMask, Vcl::Graphics::TBitmap* NewImage, System::Uitypes::TColor MaskColor);
extern DELPHI_PACKAGE void __fastcall LMDBmpClipDraw(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Graphics::TBitmap* aBitmap, System::Word flags, int pos, System::Uitypes::TColor MaskColor);
extern DELPHI_PACKAGE void __fastcall LMDBmpClipDrawExt(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Graphics::TCanvas* srcCanvas, const System::Types::TRect &srcRect, System::Word flags, int pos, System::Uitypes::TColor MaskColor, System::TObject* Add);
extern DELPHI_PACKAGE void __fastcall LMDBmpDrawTransparent(Vcl::Graphics::TCanvas* ACanvas, int X, int Y, Vcl::Graphics::TBitmap* ABitmap, System::Uitypes::TColor AClTransparent);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDBmpDrawExt(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Graphics::TCanvas* srcCanvas, const System::Types::TRect &srcRect, System::Word flags, System::Uitypes::TColor TransColor, HPALETTE pal, System::TObject* Add);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDBmpDraw(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Graphics::TBitmap* aBitmap, System::Word flags, System::Uitypes::TColor TransColor);
extern DELPHI_PACKAGE void __fastcall LMDBmpDrawDisabledState(Vcl::Graphics::TBitmap* DestBmp, Vcl::Graphics::TBitmap* SrcBmp, int x, int y);
extern DELPHI_PACKAGE void __fastcall LMDBmpStretchDraw(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Graphics::TBitmap* aBitmap);
extern DELPHI_PACKAGE void __fastcall LMDCopyBmpSize(Vcl::Graphics::TBitmap* DestBmp, Vcl::Graphics::TBitmap* SrcBmp);
extern DELPHI_PACKAGE void __fastcall LMDMaskBmpDraw(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Graphics::TBitmap* aMask, Vcl::Graphics::TBitmap* Original, System::Uitypes::TColor MaskCol, System::Uitypes::TColor TransCol);
extern DELPHI_PACKAGE void __fastcall LMDFillPattern(HDC hdc, const System::Types::TRect &R, Vcl::Graphics::TBitmap* Pattern);
extern DELPHI_PACKAGE void __fastcall LMDFillTexture(HDC hdc, const System::Types::TRect &R, Vcl::Graphics::TBitmap* bm, const System::Types::TPoint &bmOffset);
extern DELPHI_PACKAGE void __fastcall LMDIcon2Bitmap(Vcl::Graphics::TIcon* aIcon, Vcl::Graphics::TBitmap* aBitmap, System::Uitypes::TColor aColor);
extern DELPHI_PACKAGE void __fastcall LMDBitmap2Icon(Vcl::Graphics::TBitmap* aBitmap, Vcl::Graphics::TIcon* aIcon, System::Uitypes::TColor TransparentColor);
extern DELPHI_PACKAGE void __fastcall LMDBmpFromDesktop(Vcl::Graphics::TBitmap* aBitmap, const System::Types::TRect &aRect);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDGradientGetColor(System::Uitypes::TColor Color, System::Uitypes::TColor EndColor, int CurrentStep, int ColorCount);
extern DELPHI_PACKAGE void __fastcall LMDGradientCreateColorList(System::Uitypes::TColor Color, System::Uitypes::TColor EndColor, Lmdgraph::TLMDColorCount ColorCount, System::Classes::TList* ColorList, bool Clear);
extern DELPHI_PACKAGE HPALETTE __fastcall LMDGradientCreatePalette(System::Classes::TList* ColorList);
extern DELPHI_PACKAGE bool __fastcall LMDBackgroundIsGradient(Lmdgraph::TLMDBackgroundType BGType);
extern DELPHI_PACKAGE System::Byte __fastcall LMDGetRedValue(System::Uitypes::TColor AColor);
extern DELPHI_PACKAGE System::Byte __fastcall LMDGetGreenValue(System::Uitypes::TColor AColor);
extern DELPHI_PACKAGE System::Byte __fastcall LMDGetBlueValue(System::Uitypes::TColor AColor);
extern DELPHI_PACKAGE System::Byte __fastcall LMDGetAlphaValue(unsigned AColor);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDGetColor(System::Byte ARed, System::Byte AGreen, System::Byte ABlue);
extern DELPHI_PACKAGE unsigned __fastcall LMDGetARGBColor(System::Byte AAlpha, System::Byte ARed, System::Byte AGreen, System::Byte ABlue);
extern DELPHI_PACKAGE System::Byte __fastcall LMDCalcProportion(System::Byte bv, System::Byte ev, int dist, int pos);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDCalcProportionColor(System::Uitypes::TColor bv, System::Uitypes::TColor ev, System::Byte dist, System::Byte pos);
extern DELPHI_PACKAGE int __fastcall LMDFastIntDistance(int x, int y);
extern DELPHI_PACKAGE void __fastcall LMDGradientPaint(HDC DC, const System::Types::TRect &aRect, System::Uitypes::TColor Color, System::Uitypes::TColor EndColor, Lmdgraph::TLMDColorCount ColorCount, Lmdgraph::TLMDGradientStyle gStyle, System::Word flags, int pos)/* overload */;
extern DELPHI_PACKAGE System::Types::TPoint __fastcall LMDPoint(int x, int y);
extern DELPHI_PACKAGE void __fastcall LMDGradientPaintExt(HDC DC, const System::Types::TRect &aRect, Lmdgraph::TLMDGradientStyle gStyle, System::Classes::TList* ColorList, HPALETTE Palette, System::Word flags, int pos)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDGradientPaintExt(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Lmdgraph::TLMDGradientStyle gStyle, System::Classes::TList* ColorList, HPALETTE Palette, System::Word flags, int pos)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDGradientPaint(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor Color, System::Uitypes::TColor EndColor, Lmdgraph::TLMDColorCount ColorCount, Lmdgraph::TLMDGradientStyle gStyle, System::Word flags, int pos)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDSuperGradientPaint(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, System::Uitypes::TColor *Color, const int Color_High, Lmdgraph::TLMDColorCount ColorCount, Lmdgraph::TLMDGradientStyle gStyle, System::Word flags, int pos);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDAlignRect(Lmdgraph::TLMDAlignment Alignment, const System::Types::TRect &srcRect, const System::Types::TRect &destRect);
extern DELPHI_PACKAGE System::Types::TRect __fastcall LMDAlignTextRect(Lmdgraph::TLMDAlignment Alignment, const System::UnicodeString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aRect, Vcl::Graphics::TFont* Font, bool MultiLine, bool Accel, int flags);
extern DELPHI_PACKAGE void __fastcall LMDDrawTextExt(Vcl::Graphics::TCanvas* aCanvas, const Lmdtypes::TLMDString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aRect, int flags, Lmdgraph::TLMDDrawTextStyles Extflags, System::Types::PRect NRect)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDDrawTextExt(Vcl::Graphics::TCanvas* aCanvas, const Lmdtypes::TLMDString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aRect, System::Word flags)/* overload */;
extern DELPHI_PACKAGE TLMDWhereRect __fastcall LMDDrawTextAndGlyphExt(Vcl::Graphics::TCanvas* aCanvas, const Lmdtypes::TLMDString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aDest, Vcl::Graphics::TCanvas* srcCanvas, System::Types::TRect &srcRect, Vcl::Graphics::TCanvas* aMaskCanvas, System::Uitypes::TColor TransColor, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, bool MultiLine, bool Accel, bool Transparent, Lmdgraph::TLMDDrawTextStyles ExtFlags, int flags);
extern DELPHI_PACKAGE void __fastcall LMDDrawTextAndGlyph(Vcl::Graphics::TCanvas* aCanvas, const Lmdtypes::TLMDString aString, Lmd3dcaption::TLMD3DCaption* Effects, const System::Types::TRect &aDest, Vcl::Graphics::TBitmap* aGlyph, Vcl::Graphics::TBitmap* aGlyphMask, Lmdglyphtextlayout::TLMDGlyphTextLayout* aLayout, bool MultiLine, bool Accel, bool Transparent, Lmdgraph::TLMDDrawTextStyles ExtFlags, int flags);
extern DELPHI_PACKAGE void __fastcall LMDDrawTextCalc(const Lmdtypes::TLMDString aString, Lmd3dcaption::TLMD3DCaption* Effects, System::Types::TRect &aRect, Vcl::Graphics::TFont* Font, bool MultiLine, bool Accel, int BExt, int flags);
extern DELPHI_PACKAGE void __fastcall LMDDrawTextCalcExt(Vcl::Graphics::TCanvas* Canvas, const Lmdtypes::TLMDString aString, Lmd3dcaption::TLMD3DCaption* Effects, System::Types::TRect &aRect, Vcl::Graphics::TFont* Font, bool MultiLine, bool Accel, int BExt, int flags);
extern DELPHI_PACKAGE bool __fastcall LMDDrawBtnFaceExt(Vcl::Controls::TWinControl* aControl, Vcl::Graphics::TCanvas* aCanvas, bool MouseIsOver, System::Types::TRect &dRect, Lmdbuttonbase::TLMDUserButtonStyle Style, Lmdbuttonbase::TLMDButtonState State, System::Word flags, System::Uitypes::TColor aColor, Lmdclass::TLMDThemeMode aTheme = (Lmdclass::TLMDThemeMode)(0x2));
extern DELPHI_PACKAGE bool __fastcall LMDDrawBtnFace(Vcl::Graphics::TCanvas* aCanvas, bool MouseIsOver, System::Types::TRect &dRect, Lmdbuttonbase::TLMDUserButtonStyle Style, Lmdbuttonbase::TLMDButtonState State, System::Word flags, System::Uitypes::TColor aColor);
extern DELPHI_PACKAGE bool __fastcall LMDDrawBtnIsFlat(Lmdbuttonbase::TLMDUserButtonStyle Style);
extern DELPHI_PACKAGE int __fastcall LMDGet3DTextWidth(const System::UnicodeString aString, Lmd3dcaption::TLMD3DCaption* Effects, Vcl::Graphics::TFont* aFont);
extern DELPHI_PACKAGE int __fastcall LMDGet3DTextHeight(Lmd3dcaption::TLMD3DCaption* Effects, Vcl::Graphics::TFont* aFont);
extern DELPHI_PACKAGE void __fastcall LMDFillSolidRect(HDC DC, const System::Types::TRect &Rect, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDFillSolidRect(HDC DC, int x, int y, int cx, int cy, System::Uitypes::TColor Color)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDDrawArrow(Vcl::Graphics::TCanvas* Canvas, TLMDArrowDir Dir, const System::Types::TRect &R, System::Uitypes::TColor Color, bool Enabled);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall LMDGetAveCharSize(Vcl::Graphics::TCanvas* Canvas);
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDAlphaPixel(System::Uitypes::TColor ASrcColor, System::Uitypes::TColor ADstColor, double AAlphaLevel);
extern DELPHI_PACKAGE void __fastcall LMDDrawSmoothLine(Vcl::Graphics::TBitmap* ABitmap, int AX1, int AY1, int AX2, int AY2, System::Uitypes::TColor AColor);
extern DELPHI_PACKAGE bool __fastcall LMDGetTextMetrics(HDC DC, tagTEXTMETRICW &TM);
}	/* namespace Lmdgraphutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGRAPHUTILS)
using namespace Lmdgraphutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdgraphutilsHPP
