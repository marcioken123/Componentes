// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeTarga.pas' rev: 34.00 (Windows)

#ifndef TeetargaHPP
#define TeetargaHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teetarga
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTGAImage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTGAImage : public Vcl::Graphics::TBitmap
{
	typedef Vcl::Graphics::TBitmap inherited;
	
public:
	virtual void __fastcall LoadFromFile(const System::UnicodeString Filename);
public:
	/* TBitmap.Create */ inline __fastcall virtual TTGAImage()/* overload */ : Vcl::Graphics::TBitmap() { }
	/* TBitmap.Create */ inline __fastcall TTGAImage(int AWidth, int AHeight)/* overload */ : Vcl::Graphics::TBitmap(AWidth, AHeight) { }
	/* TBitmap.Destroy */ inline __fastcall virtual ~TTGAImage() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LoadFromFileX(System::UnicodeString FileName, Vcl::Graphics::TBitmap* const BitMap);
extern DELPHI_PACKAGE void __fastcall SaveToFileX(System::UnicodeString FileName, Vcl::Graphics::TBitmap* const BitMap, System::Byte MyPcxType);
}	/* namespace Teetarga */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEETARGA)
using namespace Teetarga;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeetargaHPP
