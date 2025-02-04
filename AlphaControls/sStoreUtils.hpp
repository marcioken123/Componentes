// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sStoreUtils.pas' rev: 27.00 (Windows)

#ifndef SstoreutilsHPP
#define SstoreutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.Win.Registry.hpp>	// Pascal unit
#include <System.IniFiles.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sstoreutils
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReadIniString(const System::UnicodeString Section, const System::UnicodeString Named, const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReadIniString(const System::UnicodeString Section, const System::UnicodeString Named, System::Inifiles::TMemIniFile* r)/* overload */;
extern DELPHI_PACKAGE int __fastcall ReadIniInteger(const System::UnicodeString Section, const System::UnicodeString Named, int Value, System::Inifiles::TMemIniFile* r)/* overload */;
extern DELPHI_PACKAGE void __fastcall ReadIniStrings(System::Classes::TStrings* Value, const System::UnicodeString Section, const System::UnicodeString Named, System::Inifiles::TMemIniFile* r)/* overload */;
extern DELPHI_PACKAGE void __fastcall ReadIniStrings(System::Classes::TStrings* Value, const System::UnicodeString Section, const System::UnicodeString Named, const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE int __fastcall ReadIniInteger(const System::UnicodeString Section, const System::UnicodeString Named, int Value, const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReadRegString(HKEY Key, const System::UnicodeString Section, const System::UnicodeString Named);
extern DELPHI_PACKAGE void __fastcall WriteRegString(HKEY Key, const System::UnicodeString Section, const System::UnicodeString Named, const System::UnicodeString Value);
extern DELPHI_PACKAGE void __fastcall DeleteRegParam(HKEY Key, const System::UnicodeString Section, const System::UnicodeString Named);
extern DELPHI_PACKAGE void __fastcall WriteRegInteger(const System::UnicodeString Section, const System::UnicodeString Named, int Value);
extern DELPHI_PACKAGE void __fastcall WriteIniStr(const System::UnicodeString Section, const System::UnicodeString Named, const System::UnicodeString Value, const System::UnicodeString FileName)/* overload */;
extern DELPHI_PACKAGE void __fastcall WriteIniStr(const System::UnicodeString Section, const System::UnicodeString Named, const System::UnicodeString Value, System::Inifiles::TMemIniFile* IniFile)/* overload */;
extern DELPHI_PACKAGE void __fastcall WriteIniStrings(const System::UnicodeString Section, const System::UnicodeString Named, System::Classes::TStrings* Value, System::Inifiles::TMemIniFile* IniFile)/* overload */;
extern DELPHI_PACKAGE void __fastcall WriteIniStrings(const System::UnicodeString Section, const System::UnicodeString Named, const System::UnicodeString FileName, System::Classes::TStrings* Value)/* overload */;
extern DELPHI_PACKAGE void __fastcall WriteIniFont(const System::UnicodeString Section, const System::UnicodeString Named, Vcl::Graphics::TFont* Value, System::Inifiles::TMemIniFile* IniFile)/* overload */;
extern DELPHI_PACKAGE void __fastcall ReadIniFont(const System::UnicodeString Section, const System::UnicodeString Named, Vcl::Graphics::TFont* Value, System::Inifiles::TMemIniFile* IniFile)/* overload */;
extern DELPHI_PACKAGE void __fastcall ReadSection(System::Classes::TStringList* Src, System::Classes::TStringList* Dest, const System::UnicodeString Name);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ReadValue(System::Classes::TStringList* Src, const System::UnicodeString Section, const System::UnicodeString ValueName);
extern DELPHI_PACKAGE void __fastcall SaveFormPlacement(Vcl::Forms::TForm* Form, const System::UnicodeString IniFileName);
extern DELPHI_PACKAGE void __fastcall RestoreFormPlacement(Vcl::Forms::TForm* Form, const System::UnicodeString IniFileName);
}	/* namespace Sstoreutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSTOREUTILS)
using namespace Sstoreutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SstoreutilsHPP
