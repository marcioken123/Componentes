// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSUnicode.pas' rev: 31.00 (Windows)

#ifndef JsunicodeHPP
#define JsunicodeHPP

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
#include <JSTypes.hpp>
#include <Vcl.Themes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsunicode
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool JSSupportsUnicode;
extern DELPHI_PACKAGE System::AnsiString __fastcall JSAnsiStringFromUnicodeWideString(System::WideString AText, unsigned ACharset)/* overload */;
extern DELPHI_PACKAGE System::WideString __fastcall JSUnicodeWideStringFromCompilerString(System::UnicodeString AText);
extern DELPHI_PACKAGE System::UnicodeString __fastcall JSCompilerStringFromUnicodeWideString(System::WideString AText);
extern DELPHI_PACKAGE void __fastcall JSDrawText(HDC AHwnd, System::UnicodeString AStr, Vcl::Graphics::TFont* const Font, System::Types::TRect &ARect, unsigned AFlags, bool NoFixedLength = false)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall JSFormat(const System::UnicodeString Format, const System::TVarRec *Args, const int Args_High);
extern DELPHI_PACKAGE System::UnicodeString __fastcall JSStringReplace(const System::UnicodeString S, const System::UnicodeString OldPattern, const System::UnicodeString NewPattern, System::Sysutils::TReplaceFlags Flags);
extern DELPHI_PACKAGE int __fastcall JSTextHeight(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString AStr);
extern DELPHI_PACKAGE int __fastcall JSTextWidth(Vcl::Graphics::TCanvas* ACanvas, const System::UnicodeString AStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall JSLowerCase(const System::UnicodeString AStr);
}	/* namespace Jsunicode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSUNICODE)
using namespace Jsunicode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsunicodeHPP
