// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Languages.Translate.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Languages_TranslateHPP
#define Fmxtee_Languages_TranslateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.Types.hpp>
#include <FMX.Forms.hpp>
#include <FMX.Controls.hpp>
#include <FMX.ExtCtrls.hpp>
#include <FMX.ListBox.hpp>
#include <FMX.StdCtrls.hpp>
#include <FMX.TabControl.hpp>
#include <FMX.Menus.hpp>
#include <FMXTee.Procs.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Languages
{
namespace Translate
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall TeeCanTranslate(System::UnicodeString &S, System::UnicodeString &HotKeyList);
extern DELPHI_PACKAGE void __fastcall TeeTranslateAControl(Fmx::Types::TFmxObject* const AControl, Fmx::Types::TFmxObject* const *ExcludedChilds, const int ExcludedChilds_High);
extern DELPHI_PACKAGE int __fastcall TeeLanguageRegistry(void);
extern DELPHI_PACKAGE void __fastcall TeeLanguageSaveRegistry(int LanguageNum);
}	/* namespace Translate */
}	/* namespace Languages */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_LANGUAGES_TRANSLATE)
using namespace Fmxtee::Languages::Translate;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_LANGUAGES)
using namespace Fmxtee::Languages;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Languages_TranslateHPP
