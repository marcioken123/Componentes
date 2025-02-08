// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFtpSupport.pas' rev: 31.00 (Windows)

#ifndef LmdftpsupportHPP
#define LmdftpsupportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdftpsupport
{
//-- forward type declarations -----------------------------------------------
struct TLMDFTPFileInfo;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDFTPFileInfo
{
public:
	System::UnicodeString szFileName;
	int iSize;
	System::TDateTime MTime;
};
#pragma pack(pop)


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDFTPFileInfo __fastcall LMDWebParseFtpListLine(System::UnicodeString Buf);
}	/* namespace Lmdftpsupport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFTPSUPPORT)
using namespace Lmdftpsupport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdftpsupportHPP
