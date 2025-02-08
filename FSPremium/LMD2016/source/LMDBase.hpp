// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBase.pas' rev: 31.00 (Windows)

#ifndef LmdbaseHPP
#define LmdbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <LMDButtonBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbase
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDStandardEvent)(System::TObject* Sender, bool &Cancel);

typedef void __fastcall (__closure *TLMDIndexEvent)(System::TObject* Sender, int Index);

//-- var, const, procedure ---------------------------------------------------
#define IDB_GLYPHBMP L"LMDBMPGLYPH"
#define IDB_FONTBMP L"LMDBMPFONT"
#define IDB_FILEBMP L"LMDBMPFILE"
#define IDB_CDROMBMP L"LMDBMPCDROM"
#define IDB_HINTICONERROR L"HINTICONERROR"
#define IDB_HINTICONWARNING L"HINTICONWARNING"
#define IDB_HINTICONINFO L"HINTICONINFO"
#define IDB_HINTICONQUESTION L"HINTICONQUESTION"
extern DELPHI_PACKAGE void __fastcall LMDRaiseDockError(System::Classes::TComponent* tmp, System::Classes::TComponent* tmp1);
extern DELPHI_PACKAGE void __fastcall LMDCreateHandle(Vcl::Controls::TWinControl* aControl);
extern DELPHI_PACKAGE void __fastcall LMDGetGlyphKind(Vcl::Graphics::TBitmap* aValue, Lmdbuttonbase::TLMDGlyphKind Kind);
extern DELPHI_PACKAGE void __fastcall LMDGetSysButton(Vcl::Graphics::TBitmap* aValue);
}	/* namespace Lmdbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASE)
using namespace Lmdbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbaseHPP
