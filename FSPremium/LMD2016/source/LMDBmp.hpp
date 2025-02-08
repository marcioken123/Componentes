// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBmp.pas' rev: 31.00 (Windows)

#ifndef LmdbmpHPP
#define LmdbmpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbmp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDWrongPixelFormat;
class DELPHICLASS ELMDWrongBmpSize;
struct TLMDStepRGB;
struct TLMDRGB;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDWrongPixelFormat : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDWrongPixelFormat(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDWrongPixelFormat(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDWrongPixelFormat(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDWrongPixelFormat(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDWrongPixelFormat(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDWrongPixelFormat(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDWrongPixelFormat(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDWrongPixelFormat(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDWrongPixelFormat(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDWrongPixelFormat(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDWrongPixelFormat(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDWrongPixelFormat(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDWrongPixelFormat(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDWrongBmpSize : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDWrongBmpSize(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDWrongBmpSize(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDWrongBmpSize(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDWrongBmpSize(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDWrongBmpSize(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDWrongBmpSize(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDWrongBmpSize(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDWrongBmpSize(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDWrongBmpSize(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDWrongBmpSize(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDWrongBmpSize(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDWrongBmpSize(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDWrongBmpSize(void) { }
	
};

#pragma pack(pop)

typedef short TLMDBrightness;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDStepRGB
{
public:
	System::Byte r;
	System::Byte g;
	System::Byte b;
};
#pragma pack(pop)


typedef TLMDStepRGB *PLMDStepRGB;

typedef System::StaticArray<TLMDStepRGB, 11000> TLMDStepArray;

typedef TLMDStepArray *PLMDStepArray;

struct DECLSPEC_DRECORD TLMDRGB
{
	
public:
	union
	{
		struct 
		{
			int all;
		};
		struct 
		{
			System::Byte R;
			System::Byte G;
			System::Byte B;
			System::Byte further;
		};
		
	};
};


typedef void __fastcall (__closure *TLMDProgressEvent)(int RowNum);

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDBmpGrayScale(Vcl::Graphics::TBitmap* bmp, const System::Types::TRect &bmpRect, Vcl::Graphics::TBitmap* target, const System::Types::TPoint &targetPt);
extern DELPHI_PACKAGE void __fastcall LMDBmpFlipVertical(Vcl::Graphics::TBitmap* ASource, Vcl::Graphics::TBitmap* ATarget)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDBmpFlipVertical(Vcl::Graphics::TBitmap* bmp, const System::Types::TRect &bmpRect, Vcl::Graphics::TBitmap* target, const System::Types::TPoint &targetPt)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDBmpFlipHorizontal(Vcl::Graphics::TBitmap* ASource, Vcl::Graphics::TBitmap* ATarget)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDBmpFlipHorizontal(Vcl::Graphics::TBitmap* bmp, const System::Types::TRect &bmpRect, Vcl::Graphics::TBitmap* target, const System::Types::TPoint &targetPt)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDBmpRotate(Vcl::Graphics::TBitmap* const ASource, Vcl::Graphics::TBitmap* &ADest, double AAngle)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDBmpRotate(Vcl::Graphics::TBitmap* const ASource, Vcl::Graphics::TBitmap* &ADest, double AAngle, const System::Types::TPoint &AOldCenter, System::Types::TPoint &ANewCenter)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDBmpAlphaBlend(Vcl::Graphics::TBitmap* bmp1, Vcl::Graphics::TBitmap* bmp2, const System::Types::TRect &bmpRect, const System::Types::TPoint &bmp2Pt, Vcl::Graphics::TBitmap* target, float Strength, const System::Types::TPoint &targetPt);
extern DELPHI_PACKAGE void __fastcall LMDBmpInvert(Vcl::Graphics::TBitmap* bmp, const System::Types::TRect &bmpRect, Vcl::Graphics::TBitmap* target, const System::Types::TPoint &targetPt);
extern DELPHI_PACKAGE void __fastcall LMDBMPBrightness(Vcl::Graphics::TBitmap* bmp, const System::Types::TRect &bmpRect, Vcl::Graphics::TBitmap* target, const System::Types::TPoint &targetPt, TLMDBrightness brightness);
extern DELPHI_PACKAGE void __fastcall LMDBmpBrightnessEC(Vcl::Graphics::TBitmap* bmp, const System::Types::TRect &bmpRect, Vcl::Graphics::TBitmap* target, const System::Types::TPoint &targetPt, TLMDBrightness brightness, System::Uitypes::TColor ec);
extern DELPHI_PACKAGE HRGN __fastcall LMDBmpCreateRgn(Vcl::Graphics::TBitmap* aSourceBitmap, System::Uitypes::TColor aTransparentColor);
}	/* namespace Lmdbmp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBMP)
using namespace Lmdbmp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbmpHPP
