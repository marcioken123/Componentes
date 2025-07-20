// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTranslate.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetranslateHPP
#define Vcltee_TeetranslateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetranslate
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall TeeCanTranslate(System::UnicodeString &S, System::UnicodeString &HotKeyList);
extern DELPHI_PACKAGE void __fastcall TeeTranslateAControl(System::Classes::TComponent* const AControl, System::Classes::TComponent* const *ExcludedChilds, const int ExcludedChilds_High);
extern DELPHI_PACKAGE int __fastcall TeeLanguageRegistry(void);
extern DELPHI_PACKAGE void __fastcall TeeLanguageSaveRegistry(int LanguageNum);
}	/* namespace Teetranslate */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETRANSLATE)
using namespace Vcltee::Teetranslate;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetranslateHPP
