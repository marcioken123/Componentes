// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.PCX.pas' rev: 34.00 (Windows)

#ifndef Vcltee_PcxHPP
#define Vcltee_PcxHPP

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

namespace Vcltee
{
namespace Pcx
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LoadFromFileX(const System::UnicodeString FileName, Vcl::Graphics::TBitmap* const Bitmap);
extern DELPHI_PACKAGE void __fastcall TeePCXToStream(System::Classes::TStream* Stream, Vcl::Graphics::TBitmap* const Bitmap, System::Byte PcxType);
extern DELPHI_PACKAGE void __fastcall SaveToFileX(const System::UnicodeString FileName, Vcl::Graphics::TBitmap* const Bitmap, System::Byte PcxType);
}	/* namespace Pcx */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_PCX)
using namespace Vcltee::Pcx;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_PcxHPP
