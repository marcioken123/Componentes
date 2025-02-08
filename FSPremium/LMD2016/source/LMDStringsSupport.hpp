// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStringsSupport.pas' rev: 31.00 (Windows)

#ifndef LmdstringssupportHPP
#define LmdstringssupportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstringssupport
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef System::Sysutils::TSysCharSet TCharSet;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall DelSpace1(const System::UnicodeString S);
extern DELPHI_PACKAGE int __fastcall WordPosition(const int N, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ExtractWord(int N, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE int __fastcall WordCount(const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetYear(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall CheckName(System::Classes::TStringList* List, const System::UnicodeString szStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SetHighLight(const System::UnicodeString Value, const System::UnicodeString szWords, const System::UnicodeString szBegin, const System::UnicodeString szEnd);
extern DELPHI_PACKAGE bool __fastcall IsAnyStr(const System::UnicodeString szStr, const System::UnicodeString *Arr, const int Arr_High, bool IgnoreCase = false);
}	/* namespace Lmdstringssupport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTRINGSSUPPORT)
using namespace Lmdstringssupport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstringssupportHPP
