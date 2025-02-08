// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTTPSupp.pas' rev: 31.00 (Windows)

#ifndef LmdhttpsuppHPP
#define LmdhttpsuppHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhttpsupp
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall BuildCookies(System::Classes::TStrings* Cookies)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall BuildCookies(const System::UnicodeString szCookies)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall ExtractSetCookies(const System::UnicodeString szHeader, bool DeleteExCookies = true)/* overload */;
extern DELPHI_PACKAGE void __fastcall ExtractSetCookies(const System::UnicodeString szHeader, System::Classes::TStrings* FGetCookies, bool DeleteExCookies)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTTPDecode(const System::UnicodeString AStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTTPEncode(const System::UnicodeString szStr, const System::UnicodeString szSpace = L"+");
extern DELPHI_PACKAGE void __fastcall ExtractHeaderFields(const System::Sysutils::TSysCharSet &Separators, const System::Sysutils::TSysCharSet &WhiteSpace, const System::UnicodeString Content, System::Classes::TStrings* Strings, bool Decode, bool StripQuotes = false);
extern DELPHI_PACKAGE void __fastcall ExtractHTTPFields(const System::Sysutils::TSysCharSet &Separators, const System::Sysutils::TSysCharSet &WhiteSpace, const System::UnicodeString Content, System::Classes::TStrings* Strings, bool StripQuotes = false);
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTTPGetHeader(const System::UnicodeString szHeader, const System::UnicodeString szHeaderName)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTTPGetHeader(System::WideChar * szHeader, const System::UnicodeString szHeaderName)/* overload */;
extern DELPHI_PACKAGE System::TDateTime __fastcall ParseDate(const System::UnicodeString DateStr);
extern DELPHI_PACKAGE System::TDateTime __fastcall ParseDateEx(const System::UnicodeString DateStr, System::UnicodeString DateFormat);
}	/* namespace Lmdhttpsupp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTTPSUPP)
using namespace Lmdhttpsupp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhttpsuppHPP
