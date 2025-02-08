// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRASSupport.pas' rev: 31.00 (Windows)

#ifndef LmdrassupportHPP
#define LmdrassupportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <LMDURLSupp.hpp>
#include <LMDRAS.hpp>
#include <System.Win.Registry.hpp>
#include <LMDRASCF.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrassupport
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
#define RAS_DEFAULT_KEY L"\\RemoteAccess"
#define RAS_DEFAULT_VALUE L"InternetProfile"
extern DELPHI_PACKAGE bool __fastcall RASConnect(Lmdurlsupp::TLMDInternetOptions* IO);
extern DELPHI_PACKAGE bool __fastcall RASDisconnect(void);
}	/* namespace Lmdrassupport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRASSUPPORT)
using namespace Lmdrassupport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrassupportHPP
