// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDwmApi.pas' rev: 31.00 (Windows)

#ifndef LmddwmapiHPP
#define LmddwmapiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Dwmapi.hpp>
#include <Winapi.UxTheme.hpp>
#include <LMDSysIn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddwmapi
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::LongBool LMDDwmEnabled;
extern DELPHI_PACKAGE bool __fastcall LMDWndDwmDisable(NativeUInt Handle);
extern DELPHI_PACKAGE bool __fastcall LMDWndDwmEnable(NativeUInt Handle);
extern DELPHI_PACKAGE bool __fastcall LMDWndIsDwmEnabled(NativeUInt Handle);
extern DELPHI_PACKAGE void __fastcall LMDDwmUpdate(void);
}	/* namespace Lmddwmapi */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDWMAPI)
using namespace Lmddwmapi;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddwmapiHPP
