// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShMisc.pas' rev: 31.00 (Windows)

#ifndef LmdshmiscHPP
#define LmdshmiscHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.ShlObj.hpp>
#include <LMDShBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshmisc
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellSortDirection : unsigned char { sdAscending, sdDescending, sdAsIs };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDSetClipboardText(const System::UnicodeString aText);
extern DELPHI_PACKAGE bool __fastcall LMDIsElement(unsigned Element, unsigned Flag);
extern DELPHI_PACKAGE int __fastcall LMDSafeStrToInt(const System::UnicodeString Value);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDFileSizeToStr(int aSize);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDFileDateToStr(System::TDateTime aDate);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDFileTimeToStr(System::TDateTime aTime);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDFileDateTimeToStr(System::TDateTime aDateTime);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDStrRetToStr(Winapi::Shlobj::PItemIDList aPIDL, _STRRET &StrRet, const System::UnicodeString Flag = System::UnicodeString());
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDStrRetToString(Winapi::Shlobj::PItemIDList aPIDL, const _STRRET &StrRet, const System::UnicodeString Flag = System::UnicodeString());
extern DELPHI_PACKAGE System::AnsiString __fastcall LMDStrRetToStringEx(Winapi::Shlobj::PItemIDList aPIDL, _STRRET &StrRet, const System::UnicodeString Flag = System::UnicodeString());
extern DELPHI_PACKAGE void __fastcall StrRetFree(_STRRET &StrRet);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDConstToStr(int value);
}	/* namespace Lmdshmisc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHMISC)
using namespace Lmdshmisc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshmiscHPP
