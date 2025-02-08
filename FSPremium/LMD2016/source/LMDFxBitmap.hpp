// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxBitmap.pas' rev: 31.00 (Windows)

#ifndef LmdfxbitmapHPP
#define LmdfxbitmapHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Math.hpp>
#include <Vcl.Clipbrd.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxbitmap
{
//-- forward type declarations -----------------------------------------------
struct TLMDFxColorRec;
struct TLMDFxColorRecBor;
class DELPHICLASS TLMDFxBitmap;
class DELPHICLASS TLMDFxBitmapLink;
class DELPHICLASS TLMDFxBitmapList;
//-- type declarations -------------------------------------------------------
typedef unsigned TLMDFxColor;

typedef TLMDFxColor *PLMDFxColor;

typedef TLMDFxColorRec *PLMDFxColorRec;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDFxColorRec
{
	
public:
	union
	{
		struct 
		{
			System::Byte B;
			System::Byte G;
			System::Byte R;
			System::Byte A;
		};
		struct 
		{
			System::Word HiWord;
			System::Word LoWord;
		};
		struct 
		{
			unsigned Color;
		};
		
	};
};
#pragma pack(pop)


typedef TLMDFxColorRecBor *PLMDFxColorRecBor;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDFxColorRecBor
{
	
public:
	union
	{
		struct 
		{
			System::Byte R;
			System::Byte G;
			System::Byte B;
			System::Byte A;
		};
		struct 
		{
			System::Word HiWord;
			System::Word LoWord;
		};
		struct 
		{
			unsigned Color;
		};
		
	};
};
#pragma pack(pop)


typedef System::StaticArray<TLMDFxColor, 1> TLMDFxColorArray;

typedef TLMDFxColorArray *PLMDFxColorArray;

typedef System::StaticArray<TLMDFxColorRec, 1> TLMDFxColorRecArray;

typedef TLMDFxColorRecArray *PLMDFxColorRecArray;

typedef System::DynamicArray<TLMDFxColor> TArrayOfLMDFxColor;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxBitmap : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDFxColorArray *FBits;
	int FWidth;
	int FHeight;
	System::UnicodeString FName;
	tagBITMAPINFO FBitmapInfo;
	HBITMAP FHandle;
	HDC FDC;
	bool FAlphaBlend;
	bool FTransparent;
	bool FNewFormat;
	TLMDFxColor __fastcall GetPixel(int X, int Y);
	void __fastcall SetPixel(int X, int Y, TLMDFxColor Value);
	PLMDFxColor __fastcall GetPixelPtr(int X, int Y);
	PLMDFxColorArray __fastcall GetScanLine(int Y);
	
public:
	__fastcall virtual TLMDFxBitmap(void);
	__fastcall virtual ~TLMDFxBitmap(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	void __fastcall SetSize(int AWidth, int AHeight);
	void __fastcall Clear(TLMDFxColor Color);
	bool __fastcall Empty(void);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall SaveToBitmapFile(System::UnicodeString AFileName);
	void __fastcall LoadFromPcxStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromResource(const System::UnicodeString ResFileName, const System::UnicodeString ResName);
	TLMDFxBitmapLink* __fastcall GetBitmapLink(const System::Types::TRect &Rect)/* overload */;
	TLMDFxBitmapLink* __fastcall GetBitmapLink(System::UnicodeString Rect)/* overload */;
	void __fastcall CheckingTransparent(TLMDFxColor Color = (TLMDFxColor)(0x7f007f))/* overload */;
	void __fastcall CheckingTransparent(const System::Types::TRect &ARect, TLMDFxColor Color = (TLMDFxColor)(0x7f007f))/* overload */;
	void __fastcall CheckingAlphaBlend(void)/* overload */;
	void __fastcall CheckingAlphaBlend(const System::Types::TRect &ARect)/* overload */;
	void __fastcall SetAlpha(System::Byte Alpha)/* overload */;
	void __fastcall SetAlpha(System::Byte Alpha, const System::Types::TRect &Rect)/* overload */;
	void __fastcall SetBitmapHue(int Hue);
	void __fastcall ChangeBitmapSat(int DeltaSat);
	void __fastcall ChangeBitmapHue(int DeltaHue);
	void __fastcall ChangeBitmapBrightness(int DeltaBrightness);
	void __fastcall FlipHorz(void);
	void __fastcall DrawGraphic(Vcl::Graphics::TGraphic* Graphic, const System::Types::TRect &DstRect);
	void __fastcall FillRect(const System::Types::TRect &R, TLMDFxColor Color);
	void __fastcall Draw(HDC DC, int X, int Y)/* overload */;
	void __fastcall Draw(HDC DC, int X, int Y, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Draw(HDC DC, const System::Types::TRect &DstRect)/* overload */;
	void __fastcall Draw(HDC DC, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, int X, int Y)/* overload */;
	void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, int X, int Y, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &DstRect)/* overload */;
	void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Draw(TLMDFxBitmap* Bitmap, int X, int Y)/* overload */;
	void __fastcall Draw(TLMDFxBitmap* Bitmap, int X, int Y, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Draw(TLMDFxBitmap* Bitmap, const System::Types::TRect &DstRect)/* overload */;
	void __fastcall Draw(TLMDFxBitmap* Bitmap, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Tile(HDC DC, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Tile(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall Tile(TLMDFxBitmap* Bitmap, const System::Types::TRect &DstRect, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall TileClip(HDC DC, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall TileClip(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall TileClip(TLMDFxBitmap* Bitmap, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, const System::Types::TRect &SrcRect)/* overload */;
	void __fastcall MergeDraw(TLMDFxBitmap* Bitmap, int X, int Y, const System::Types::TRect &SrcRect);
	__property HBITMAP Handle = {read=FHandle, nodefault};
	__property HDC DC = {read=FDC, nodefault};
	__property PLMDFxColorArray Bits = {read=FBits};
	__property TLMDFxColor Pixels[int X][int Y] = {read=GetPixel, write=SetPixel/*, default*/};
	__property PLMDFxColor PixelPtr[int X][int Y] = {read=GetPixelPtr};
	__property PLMDFxColorArray ScanLine[int Y] = {read=GetScanLine};
	__property int Width = {read=FWidth, nodefault};
	__property int Height = {read=FHeight, nodefault};
	__property bool AlphaBlend = {read=FAlphaBlend, write=FAlphaBlend, nodefault};
	__property bool Transparent = {read=FTransparent, write=FTransparent, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property bool NewFormat = {read=FNewFormat, write=FNewFormat, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxBitmapLink : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDFxBitmap* FImage;
	System::Types::TRect FRect;
	System::UnicodeString FName;
	bool FMaskedBorder;
	bool FMaskedAngles;
	bool FMasked;
	int __fastcall GetBottom(void);
	int __fastcall GetLeft(void);
	int __fastcall GetRight(void);
	int __fastcall GetTop(void);
	void __fastcall SetBottom(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetRight(const int Value);
	void __fastcall SetTop(const int Value);
	bool __fastcall GetAssigned(void);
	
public:
	__fastcall TLMDFxBitmapLink(void);
	__fastcall virtual ~TLMDFxBitmapLink(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall CheckingMasked(void)/* overload */;
	void __fastcall CheckingMasked(const System::Types::TRect &Margin)/* overload */;
	void __fastcall Draw(Vcl::Graphics::TCanvas* Canvas, int X, int Y)/* overload */;
	void __fastcall Draw(TLMDFxBitmap* Bitmap, int X, int Y)/* overload */;
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	__property bool Assigned = {read=GetAssigned, nodefault};
	__property TLMDFxBitmap* Image = {read=FImage, write=FImage};
	__property System::Types::TRect Rect = {read=FRect, write=FRect};
	__property bool Masked = {read=FMasked, write=FMasked, nodefault};
	__property bool MaskedBorder = {read=FMaskedBorder, write=FMaskedBorder, nodefault};
	__property bool MaskedAngles = {read=FMaskedAngles, write=FMaskedAngles, nodefault};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property int Left = {read=GetLeft, write=SetLeft, nodefault};
	__property int Top = {read=GetTop, write=SetTop, nodefault};
	__property int Right = {read=GetRight, write=SetRight, nodefault};
	__property int Bottom = {read=GetBottom, write=SetBottom, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFxBitmapList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
public:
	TLMDFxBitmap* operator[](int index) { return this->Bitmaps[index]; }
	
private:
	TLMDFxBitmap* __fastcall GetImage(int index);
	TLMDFxBitmap* __fastcall GetBitmapByName(System::UnicodeString index);
	
public:
	__fastcall virtual TLMDFxBitmapList(void);
	__fastcall virtual ~TLMDFxBitmapList(void);
	virtual void __fastcall Clear(void);
	TLMDFxBitmapLink* __fastcall GetBitmapLink(TLMDFxBitmap* Image, const System::Types::TRect &Rect)/* overload */;
	TLMDFxBitmapLink* __fastcall GetBitmapLink(System::UnicodeString Name, const System::Types::TRect &Rect)/* overload */;
	TLMDFxBitmapLink* __fastcall GetBitmapLink(System::UnicodeString Name, System::UnicodeString Rect)/* overload */;
	__property TLMDFxBitmap* Bitmaps[int index] = {read=GetImage/*, default*/};
	__property TLMDFxBitmap* BitmapByName[System::UnicodeString index] = {read=GetBitmapByName};
};

#pragma pack(pop)

typedef TLMDFxColor __fastcall (*TLMDFxAlphaBlendPixel)(TLMDFxColor Src, TLMDFxColor Dst);

typedef void __fastcall (*TLMDFxAlphaBlendLine)(PLMDFxColor Src, PLMDFxColor Dst, int Count);

typedef void __fastcall (*TLMDFxTransparentLine)(PLMDFxColor Src, PLMDFxColor Dst, int Count);

typedef void __fastcall (*TLMDFxMoveLongword)(const void * Src, void * Dst, int Count);

typedef void __fastcall (*TLMDFxFillLongword)(void * Src, int Count, unsigned Value);

typedef void __fastcall (*TLMDFxFillLongwordRect)(void * Src, int W, int H, int X1, int Y1, int X2, int Y2, unsigned Value);

typedef void __fastcall (*TLMDFxFillAlpha)(void * Src, int Count, System::Byte Alpha);

typedef void __fastcall (*TLMDFxFillAlphaRect)(void * Src, int W, int H, int X1, int Y1, int X2, int Y2, System::Byte Alpha);

typedef void __fastcall (*TLMDFxClearAlpha)(void * Src, int Count, unsigned Value);

typedef void __fastcall (*TLMDFxStretchToDCOpaque)(HDC DstDC, int DstX, int DstY, int DstW, int DstH, TLMDFxBitmap* SrcBmp, int SrcX, int SrcY, int SrcW, int SrcH);

typedef void __fastcall (*TLMDFxStretchToDCTransparent)(HDC DstDC, int DstX, int DstY, int DstW, int DstH, TLMDFxBitmap* SrcBmp, int SrcX, int SrcY, int SrcW, int SrcH);

typedef void __fastcall (*TLMDFxStretchToDCAlphaBlend)(HDC DstDC, int DstX, int DstY, int DstW, int DstH, TLMDFxBitmap* SrcBmp, int SrcX, int SrcY, int SrcW, int SrcH);

typedef void __fastcall (*TLMDFxStretchToDibOpaque)(void * Bits, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, int BitsW, int BitsH, TLMDFxBitmap* Src, const System::Types::TRect &SrcRect);

typedef void __fastcall (*TLMDFxStretchToDibTransparent)(void * Bits, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, int BitsW, int BitsH, TLMDFxBitmap* Src, const System::Types::TRect &SrcRect);

typedef void __fastcall (*TLMDFxStretchToDibAlphaBlend)(void * Bits, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, int BitsW, int BitsH, TLMDFxBitmap* Src, const System::Types::TRect &SrcRect);

typedef void __fastcall (*TLMDFxStretchOpaque)(TLMDFxBitmap* Dst, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, TLMDFxBitmap* Src, const System::Types::TRect &SrcRect);

typedef void __fastcall (*TLMDFxStretchTransparent)(TLMDFxBitmap* Dst, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, TLMDFxBitmap* Src, const System::Types::TRect &SrcRect);

typedef void __fastcall (*TLMDFxStretchAlphaBlend)(TLMDFxBitmap* Dst, const System::Types::TRect &DstRect, const System::Types::TRect &DstClip, TLMDFxBitmap* &Src, const System::Types::TRect &SrcRect);

typedef void __fastcall (*TLMDFxBltOpaque)(TLMDFxBitmap* Dst, const System::Types::TRect &DstRect, TLMDFxBitmap* Src, int SrcX, int SrcY);

typedef void __fastcall (*TLMDFxBltTransparent)(TLMDFxBitmap* Dst, const System::Types::TRect &DstRect, TLMDFxBitmap* Src, int SrcX, int SrcY);

typedef void __fastcall (*TLMDFxBltAlphaBlend)(TLMDFxBitmap* Dst, const System::Types::TRect &DstRect, TLMDFxBitmap* Src, int SrcX, int SrcY);

typedef void * __fastcall (*TLMDFxGetBitsFromDC)(HDC DC, int &Width, int &Height, int &BitCount);

//-- var, const, procedure ---------------------------------------------------
static const int LMDFxTransparent = int(0x7f007f);
static const unsigned AlphaMask = unsigned(0xff000000);
extern DELPHI_PACKAGE TLMDFxColor LMDFxBlack;
extern DELPHI_PACKAGE TLMDFxColor LMDFxGray;
extern DELPHI_PACKAGE TLMDFxColor LMDFxWhite;
extern DELPHI_PACKAGE TLMDFxColor LMDFxMaroon;
extern DELPHI_PACKAGE TLMDFxColor LMDFxGreen;
extern DELPHI_PACKAGE TLMDFxColor LMDFxOlive;
extern DELPHI_PACKAGE TLMDFxColor LMDFxNavy;
extern DELPHI_PACKAGE TLMDFxColor LMDFxPurple;
extern DELPHI_PACKAGE TLMDFxColor LMDFxTeal;
extern DELPHI_PACKAGE TLMDFxColor LMDFxRed;
extern DELPHI_PACKAGE TLMDFxColor LMDFxLime;
extern DELPHI_PACKAGE TLMDFxColor LMDFxYellow;
extern DELPHI_PACKAGE TLMDFxColor LMDFxBlue;
extern DELPHI_PACKAGE TLMDFxColor LMDFxFuchsia;
extern DELPHI_PACKAGE TLMDFxColor LMDFxAqua;
extern DELPHI_PACKAGE TLMDFxColor LMDFxMenu;
extern DELPHI_PACKAGE TLMDFxColor LMDFxBorder;
extern DELPHI_PACKAGE TLMDFxColor LMDFxWindow;
extern DELPHI_PACKAGE TLMDFxColor LMDFxBtnFace;
extern DELPHI_PACKAGE TLMDFxColor LMDFxBtnShadow;
extern DELPHI_PACKAGE TLMDFxColor LMDFxHotHighlight;
extern DELPHI_PACKAGE TLMDFxColor LMDFxHighlight;
extern DELPHI_PACKAGE TLMDFxColor LMDFxHintBack;
extern DELPHI_PACKAGE TLMDFxColor LMDFxNone;
extern DELPHI_PACKAGE TLMDFxColor LMDFxTransparentVar;
extern DELPHI_PACKAGE bool EnableDibOperation;
extern DELPHI_PACKAGE TLMDFxAlphaBlendPixel PixelAlphaBlendFunc;
extern DELPHI_PACKAGE TLMDFxAlphaBlendLine LineAlphaBlendFunc;
extern DELPHI_PACKAGE TLMDFxTransparentLine LineTransparentFunc;
extern DELPHI_PACKAGE TLMDFxMoveLongword MoveLongwordFunc;
extern DELPHI_PACKAGE TLMDFxFillLongword FillLongwordFunc;
extern DELPHI_PACKAGE TLMDFxFillLongwordRect FillLongwordRectFunc;
extern DELPHI_PACKAGE TLMDFxFillAlpha FillAlphaFunc;
extern DELPHI_PACKAGE TLMDFxFillAlphaRect FillAlphaRectFunc;
extern DELPHI_PACKAGE TLMDFxClearAlpha ClearAlphaFunc;
extern DELPHI_PACKAGE TLMDFxStretchToDCOpaque StretchToDCOpaqueFunc;
extern DELPHI_PACKAGE TLMDFxStretchToDCAlphaBlend StretchToDCAlphaBlendFunc;
extern DELPHI_PACKAGE TLMDFxStretchToDCTransparent StretchToDCTransparentFunc;
extern DELPHI_PACKAGE TLMDFxGetBitsFromDC GetBitsFromDCFunc;
extern DELPHI_PACKAGE TLMDFxStretchToDibOpaque StretchToDibOpaqueFunc;
extern DELPHI_PACKAGE TLMDFxStretchToDibAlphaBlend StretchToDibAlphaBlendFunc;
extern DELPHI_PACKAGE TLMDFxStretchToDibTransparent StretchToDibTransparentFunc;
extern DELPHI_PACKAGE TLMDFxBltOpaque BltOpaqueFunc;
extern DELPHI_PACKAGE TLMDFxBltAlphaBlend BltAlphaBlendFunc;
extern DELPHI_PACKAGE TLMDFxBltTransparent BltTransparentFunc;
extern DELPHI_PACKAGE TLMDFxStretchOpaque StretchOpaqueFunc;
extern DELPHI_PACKAGE TLMDFxStretchAlphaBlend StretchAlphaBlendFunc;
extern DELPHI_PACKAGE TLMDFxStretchTransparent StretchTransparentFunc;
extern DELPHI_PACKAGE TLMDFxColor __fastcall LMDFxColor(System::Uitypes::TColor Color, System::Byte A = (System::Byte)(0xff))/* overload */;
extern DELPHI_PACKAGE TLMDFxColor __fastcall LMDFxColor(short R, short G, short B, System::Byte A = (System::Byte)(0xff))/* overload */;
extern DELPHI_PACKAGE TLMDFxColor __fastcall LMDFxColor(TLMDFxColorRec ColorRec)/* overload */;
extern DELPHI_PACKAGE System::Uitypes::TColor __fastcall LMDFxColorToColor(TLMDFxColor Color);
extern DELPHI_PACKAGE System::Word __fastcall LMDFxColorToColor16(TLMDFxColor Color);
extern DELPHI_PACKAGE System::Word __fastcall LMDFxColorToColor15(TLMDFxColor Color);
extern DELPHI_PACKAGE unsigned __fastcall FromRGB(unsigned Color32);
extern DELPHI_PACKAGE unsigned __fastcall ToRGB(unsigned Color);
extern DELPHI_PACKAGE System::Word __fastcall MulDiv16(System::Word Number, System::Word Numerator, System::Word Denominator);
}	/* namespace Lmdfxbitmap */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXBITMAP)
using namespace Lmdfxbitmap;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxbitmapHPP
