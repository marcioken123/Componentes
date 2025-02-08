// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDebugUnit.pas' rev: 34.00 (Windows)

#ifndef LmddebugunitHPP
#define LmddebugunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddebugunit
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDDebug(const System::UnicodeString Fmt, System::TVarRec *Args, const int Args_High)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDDebug(const System::UnicodeString Msg)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDMessageToStr(const int WM_Number);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWMCommandButtonNotify(const int CN_Number);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWMCommandListBoxNotify(const int CN_Number);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWMCommandComboBoxNotify(const int CN_Number);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWMCommandEditNotify(const int CN_Number);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWindowsStyleToString(unsigned AStyle);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWindowExStyleToString(unsigned AExStyle);
}	/* namespace Lmddebugunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDEBUGUNIT)
using namespace Lmddebugunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddebugunitHPP
