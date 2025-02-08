// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInetConst.pas' rev: 31.00 (Windows)

#ifndef LmdinetconstHPP
#define LmdinetconstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.WinInet.hpp>
#include <LMDWebConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinetconst
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 20> Lmdinetconst__1;

typedef System::StaticArray<System::UnicodeString, 34> Lmdinetconst__2;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MAX_INET_ERRORS = System::Int8(0x21);
static const System::Int8 MAX_HTTP_ERRORS = System::Int8(0x14);
static const System::Int8 DE_HTTP_ERROR = System::Int8(0x2);
extern DELPHI_PACKAGE Lmdinetconst__1 HTTP_ERROR_STRINGS;
extern DELPHI_PACKAGE System::StaticArray<unsigned, 20> HTTP_ERROR_CODES;
extern DELPHI_PACKAGE System::StaticArray<unsigned, 34> INET_ERROR_CODES;
extern DELPHI_PACKAGE Lmdinetconst__2 INET_ERROR_STRINGS;
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetInternetError(unsigned dwError);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetHTTPError(unsigned dwError);
}	/* namespace Lmdinetconst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINETCONST)
using namespace Lmdinetconst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinetconstHPP
