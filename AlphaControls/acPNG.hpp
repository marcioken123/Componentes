// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acPNG.pas' rev: 27.00 (Windows)

#ifndef AcpngHPP
#define AcpngHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Math.hpp>	// Pascal unit
#include <acZLibEx.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acpng
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TColorScheme : unsigned char { csUnknown, csIndexed, csG, csGA, csRGB, csRGBA, csBGR, csBGRA, csCMY, csCMYK, csCIELab, csYCbCr, csPhotoYCC };

enum DECLSPEC_DENUM Acpng__1 : unsigned char { coAlpha, coApplyGamma, coNeedByteSwap, coLabByteRange, coLabChromaOffset };

typedef System::Set<Acpng__1, Acpng__1::coAlpha, Acpng__1::coLabChromaOffset> TConvertOptions;

enum DECLSPEC_DENUM TRawPaletteFormat : unsigned char { pfInterlaced8Triple, pfInterlaced8Quad, pfPlane8Triple, pfPlane8Quad, pfInterlaced16Triple, pfInterlaced16Quad, pfPlane16Triple, pfPlane16Quad };

typedef void __fastcall (__closure *TConversionMethod)(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);

class DELPHICLASS TColorManager;
class PASCALIMPLEMENTATION TColorManager : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<int> _TColorManager__1;
	
	
private:
	bool FChanged;
	System::Byte FSourceBPS;
	System::Byte FTargetBPS;
	System::Byte FSourceSPP;
	System::Byte FTargetSPP;
	float FMainGamma;
	float FDisplayGamma;
	System::StaticArray<System::Byte, 256> FGammaTable;
	System::StaticArray<float, 3> FYCbCrCoefficients;
	_TColorManager__1 FCrToRedTable;
	_TColorManager__1 FCbToBlueTable;
	_TColorManager__1 FCrToGreenTable;
	_TColorManager__1 FCbToGreenTable;
	TColorScheme FSourceScheme;
	TColorScheme FTargetScheme;
	TConversionMethod FRowConversion;
	TConvertOptions FSourceOptions;
	TConvertOptions FTargetOptions;
	
protected:
	System::Byte __fastcall ComponentGammaConvert(System::Byte Value);
	System::Word __fastcall ComponentNoConvert16(System::Word Value);
	System::Byte __fastcall ComponentNoConvert8(System::Byte Value);
	System::Byte __fastcall ComponentScaleConvert(System::Word Value);
	System::Byte __fastcall ComponentScaleGammaConvert(System::Word Value);
	System::Byte __fastcall ComponentSwapScaleGammaConvert(System::Word Value);
	System::Byte __fastcall ComponentSwapScaleConvert(System::Word Value);
	System::Word __fastcall ComponentSwapConvert(System::Word Value);
	void __fastcall RowConvertBGR2BGR(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertBGR2RGB(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertCIELAB2BGR(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertCIELAB2RGB(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertCMYK2BGR(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertCMYK2RGB(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertGray(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertIndexed8(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertIndexedBoth16(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertIndexedSource16(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertIndexedTarget16(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertRGB2BGR(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertRGB2RGB(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertPhotoYCC2BGR(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertPhotoYCC2RGB(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertYCbCr2BGR(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall RowConvertYCbCr2RGB(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	void __fastcall CreateYCbCrLookup(void);
	Vcl::Graphics::TPixelFormat __fastcall GetPixelFormat(int Index);
	void __fastcall PrepareConversion(void);
	void __fastcall SetSourceBitsPerSample(const System::Byte Value);
	void __fastcall SetTargetBitsPerSample(const System::Byte Value);
	void __fastcall SetSourceColorScheme(const TColorScheme Value);
	void __fastcall SetTargetColorScheme(const TColorScheme Value);
	void __fastcall SetSourceSamplesPerPixel(const System::Byte Value);
	void __fastcall SetTargetSamplesPerPixel(const System::Byte Value);
	
public:
	__fastcall TColorManager(void);
	void __fastcall ConvertRow(void * const *Source, const int Source_High, void * Target, unsigned Count, System::Byte Mask);
	HPALETTE __fastcall CreateColorPalette(void * const *Data, const int Data_High, TRawPaletteFormat DataFormat, unsigned ColorCount, bool RGB);
	HPALETTE __fastcall CreateGrayscalePalette(bool MinimumIsWhite);
	void __fastcall Error(const System::UnicodeString Msg);
	void __fastcall SetGamma(float MainGamma, float DisplayGamma = 2.200000E+00f);
	__property System::Byte SourceBitsPerSample = {read=FSourceBPS, write=SetSourceBitsPerSample, nodefault};
	__property TColorScheme SourceColorScheme = {read=FSourceScheme, write=SetSourceColorScheme, nodefault};
	__property TConvertOptions SourceOptions = {read=FSourceOptions, write=FSourceOptions, nodefault};
	__property Vcl::Graphics::TPixelFormat SourcePixelFormat = {read=GetPixelFormat, index=0, nodefault};
	__property System::Byte SourceSamplesPerPixel = {read=FSourceSPP, write=SetSourceSamplesPerPixel, nodefault};
	__property System::Byte TargetBitsPerSample = {read=FTargetBPS, write=SetTargetBitsPerSample, nodefault};
	__property TColorScheme TargetColorScheme = {read=FTargetScheme, write=SetTargetColorScheme, nodefault};
	__property TConvertOptions TargetOptions = {read=FTargetOptions, write=FTargetOptions, nodefault};
	__property Vcl::Graphics::TPixelFormat TargetPixelFormat = {read=GetPixelFormat, index=1, nodefault};
	__property System::Byte TargetSamplesPerPixel = {read=FTargetSPP, write=SetTargetSamplesPerPixel, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TColorManager(void) { }
	
};


typedef System::DynamicArray<System::Byte> TByteArray;

typedef System::DynamicArray<unsigned> TCardinalArray;

typedef System::DynamicArray<float> TFloatArray;

class DELPHICLASS TLZ77Decoder;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLZ77Decoder : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Aczlibex::TZStreamRec FStream;
	int FZLibResult;
	int FFlushMode;
	bool FAutoReset;
	int __fastcall GetAvailableInput(void);
	int __fastcall GetAvailableOutput(void);
	
public:
	__fastcall TLZ77Decoder(int FlushMode, bool AutoReset);
	void __fastcall Decode(void * &Source, void * &Dest, int PackedSize, int UnpackedSize);
	void __fastcall DecodeEnd(void);
	void __fastcall DecodeInit(void);
	__property int AvailableInput = {read=GetAvailableInput, nodefault};
	__property int AvailableOutput = {read=GetAvailableOutput, nodefault};
	__property int ZLibResult = {read=FZLibResult, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLZ77Decoder(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM Acpng__4 : unsigned char { ioBigEndian, ioUseGamma };

typedef System::Set<Acpng__4, Acpng__4::ioBigEndian, Acpng__4::ioUseGamma> TImageOptions;

enum DECLSPEC_DENUM TCompressionType : unsigned char { ctUnknown, ctNone, ctLZ77 };

struct TImageProperties;
typedef TImageProperties *PImageProperties;

struct DECLSPEC_DRECORD TImageProperties
{
public:
	TImageOptions Options;
	unsigned Width;
	TColorScheme ColorScheme;
	System::Byte BitsPerSample;
	System::Byte SamplesPerPixel;
	TCompressionType Compression;
};


typedef System::StaticArray<char, 4> TChunkType;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TPNGChunkHeader
{
public:
	unsigned Length;
	TChunkType ChunkType;
};
#pragma pack(pop)


class DELPHICLASS TPNGGraphic;
class PASCALIMPLEMENTATION TPNGGraphic : public Vcl::Graphics::TBitmap
{
	typedef Vcl::Graphics::TBitmap inherited;
	
private:
	TColorManager* FColorManager;
	System::Types::TRect FProgressRect;
	unsigned FBasePosition;
	System::Classes::TStream* FStream;
	TImageProperties FImageProperties;
	TLZ77Decoder* FDecoder;
	int FIDATSize;
	void *FRawBuffer;
	void *FCurrentSource;
	TPNGChunkHeader FHeader;
	unsigned FCurrentCRC;
	int FSourceBPP;
	HPALETTE FPalette;
	TByteArray FTransparency;
	System::Uitypes::TColor FTransparentColor;
	System::Uitypes::TColor FBackgroundColor;
	void __fastcall ApplyFilter(System::Byte Filter, System::PByte Line, System::PByte PrevLine, System::PByte Target, int BPP, int BytesPerRow);
	bool __fastcall IsChunk(const TChunkType ChunkType);
	unsigned __fastcall LoadAndSwapHeader(void);
	void __fastcall LoadBackgroundColor(const void *Description);
	void __fastcall LoadIDAT(const void *Description);
	void __fastcall LoadTransparency(const void *Description);
	void __fastcall ReadDataAndCheckCRC(void);
	void __fastcall ReadRow(void * RowBuffer, int BytesPerRow);
	int __fastcall SetupColorDepth(int ColorType, int BitDepth);
	
public:
	bool Reflected;
	__fastcall virtual TPNGGraphic(void);
	__fastcall virtual ~TPNGGraphic(void);
	virtual void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &Rect);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod bool __fastcall CanLoad(const System::UnicodeString FileName)/* overload */;
	__classmethod bool __fastcall CanLoad(System::Classes::TStream* Stream)/* overload */;
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	bool __fastcall ReadImageProperties(System::Classes::TStream* Stream, unsigned ImageIndex);
	__property System::Uitypes::TColor BackgroundColor = {read=FBackgroundColor, nodefault};
	__property TByteArray Transparency = {read=FTransparency};
	__property TColorManager* ColorManager = {read=FColorManager};
	__property TImageProperties ImageProperties = {read=FImageProperties, write=FImageProperties};
};


//-- var, const, procedure ---------------------------------------------------
#define DefaultDisplayGamma  (2.200000E+00)
extern DELPHI_PACKAGE System::StaticArray<System::Byte, 8> PNGMagic;
extern DELPHI_PACKAGE bool UseACPng;
extern DELPHI_PACKAGE void __fastcall SwapLong(System::PInteger P, unsigned Count)/* overload */;
extern DELPHI_PACKAGE HICON __fastcall MakeIcon32(Vcl::Graphics::TBitmap* Img, bool UpdateAlphaChannell = false);
extern DELPHI_PACKAGE HICON __fastcall MakeCompIcon(Vcl::Graphics::TBitmap* Img, System::Uitypes::TColor BGColor = (System::Uitypes::TColor)(0x1fffffff));
extern DELPHI_PACKAGE void __fastcall UpdateTransPixels(Vcl::Graphics::TBitmap* Img);
}	/* namespace Acpng */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACPNG)
using namespace Acpng;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcpngHPP
