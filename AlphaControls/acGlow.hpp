// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acGlow.pas' rev: 27.00 (Windows)

#ifndef AcglowHPP
#define AcglowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acglow
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool bGlowingDestroying;
extern DELPHI_PACKAGE int __fastcall ShowGlow(const System::Types::TRect &R, const System::Types::TRect &RealRect, const System::UnicodeString SkinSection, const System::UnicodeString Name, const int Margin, const int Alpha, HWND WndHandle, Scommondata::TsCommonData* SkinData = (Scommondata::TsCommonData*)(0x0));
extern DELPHI_PACKAGE void __fastcall HideGlow(int &ID);
extern DELPHI_PACKAGE void __fastcall ClearGlows(bool ManualFreeing = false);
}	/* namespace Acglow */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACGLOW)
using namespace Acglow;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcglowHPP
