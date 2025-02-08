// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDialogSheets.pas' rev: 31.00 (Windows)

#ifndef JsdialogsheetsHPP
#define JsdialogsheetsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <JSDialog.hpp>
#include <JSDialogSheet.hpp>
#include <JSDialogs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdialogsheets
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall ShowInfoSheet(const System::UnicodeString AInstruction, const System::UnicodeString AContent, Jsdialog::TJSSheetLocation ALocation);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowTimedInfoSheet(const System::UnicodeString AInstruction, const System::UnicodeString AContent, Jsdialog::TJSSheetLocation ALocation, Jsdialogs::TCommonButtons AButtons = (Jsdialogs::TCommonButtons() << Jsdialogs::TCommonButton::cbClose ), const int ATimeOut = 0x3, const bool AIsModal = false, Jsdialog::TDialogCloseEvent ACloseCallback = 0x0, Jsdialog::TTimerEvent ATimerCallback = 0x0);
extern DELPHI_PACKAGE System::Uitypes::TModalResult __fastcall ShowModalTimedInfoSheet(const System::UnicodeString AInstruction, const System::UnicodeString AContent, Jsdialog::TJSSheetLocation ALocation, Jsdialogs::TCommonButtons AButtons = (Jsdialogs::TCommonButtons() << Jsdialogs::TCommonButton::cbClose ), const int ATimeOut = 0x3);
}	/* namespace Jsdialogsheets */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDIALOGSHEETS)
using namespace Jsdialogsheets;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdialogsheetsHPP
