// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStreamUtils.pas' rev: 31.00 (Windows)

#ifndef LmdstreamutilsHPP
#define LmdstreamutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDWave.hpp>
#include <LMDStrings.hpp>
#include <LMDProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstreamutils
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDBmpSaveDIBStream(System::Classes::TStream* Stream, Vcl::Graphics::TBitmap* Bitmap, int Colors);
extern DELPHI_PACKAGE void __fastcall stWriteInteger(System::Classes::TStream* Stream, int aValue);
extern DELPHI_PACKAGE void __fastcall stWriteString(System::Classes::TStream* Stream, const System::UnicodeString aValue);
extern DELPHI_PACKAGE void __fastcall stWriteStringList(System::Classes::TStream* Stream, System::Classes::TStrings* aValue, bool Compressed);
extern DELPHI_PACKAGE void __fastcall stWriteByte(System::Classes::TStream* Stream, System::Byte aValue);
extern DELPHI_PACKAGE void __fastcall stWriteWord(System::Classes::TStream* Stream, System::Word aValue);
extern DELPHI_PACKAGE void __fastcall stWriteWave(System::Classes::TStream* Stream, Lmdwave::TLMDWave* aValue, bool Compressed);
extern DELPHI_PACKAGE void __fastcall stWriteBitmap(System::Classes::TStream* Stream, Vcl::Graphics::TBitmap* aValue, bool Compressed, int Colors);
extern DELPHI_PACKAGE int __fastcall stReadInteger(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE System::UnicodeString __fastcall stReadString(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE void __fastcall stReadStringList(System::Classes::TStream* Stream, System::Classes::TStrings* aValue, bool Compressed);
extern DELPHI_PACKAGE System::Byte __fastcall stReadByte(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE System::Word __fastcall stReadWord(System::Classes::TStream* Stream);
extern DELPHI_PACKAGE void __fastcall stReadWave(System::Classes::TStream* Stream, Lmdwave::TLMDWave* aValue, bool Compressed);
extern DELPHI_PACKAGE void __fastcall stReadBitmap(System::Classes::TStream* Stream, Vcl::Graphics::TBitmap* aValue, bool Compressed);
}	/* namespace Lmdstreamutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTREAMUTILS)
using namespace Lmdstreamutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstreamutilsHPP
