// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSEditDialogs.pas' rev: 31.00 (Windows)

#ifndef JseditdialogsHPP
#define JseditdialogsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <JSEditDialog.hpp>
#include <JSDialogs.hpp>
#include <JSEditEvents.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <JSTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jseditdialogs
{
//-- forward type declarations -----------------------------------------------
struct TJSFooterRec;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TJSFooterRec
{
public:
	System::UnicodeString Text;
	Jsdialogs::TTaskDialogIcon Icon;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Jseditdialog::TJSEditDialogClass JSEditDialogClass;
extern DELPHI_PACKAGE System::UnicodeString __fastcall InputBoxEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, const System::UnicodeString ADefault, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1));
extern DELPHI_PACKAGE System::UnicodeString __fastcall InputBox(const System::UnicodeString ACaption, const System::UnicodeString APrompt, const System::UnicodeString ADefault);
extern DELPHI_PACKAGE bool __fastcall InputDateEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::TDate &AValue, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1));
extern DELPHI_PACKAGE bool __fastcall InputDate(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::TDate &AValue);
extern DELPHI_PACKAGE bool __fastcall InputTimeEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::TTime &AValue, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1));
extern DELPHI_PACKAGE bool __fastcall InputTime(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::TTime &AValue);
extern DELPHI_PACKAGE bool __fastcall InputCalendarEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::TDate &AValue, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1));
extern DELPHI_PACKAGE bool __fastcall InputCalendar(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::TDate &AValue);
extern DELPHI_PACKAGE bool __fastcall InputQueryEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &AValue, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1))/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputQuery(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &AValue)/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputQueryVerification(const System::UnicodeString ACaption, const System::UnicodeString APrompt, const System::UnicodeString AVerification, System::UnicodeString &AValue, bool &AVerificationResult);
extern DELPHI_PACKAGE bool __fastcall InputQueryEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt1, const System::UnicodeString APrompt2, System::UnicodeString &AValue1, System::UnicodeString &AValue2, const Jseditdialog::TJSCaptionAlignment ACaptionAlignment = (Jseditdialog::TJSCaptionAlignment)(0x1))/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputQuery(const System::UnicodeString ACaption, const System::UnicodeString APrompt1, const System::UnicodeString APrompt2, System::UnicodeString &AValue1, System::UnicodeString &AValue2, const Jseditdialog::TJSCaptionAlignment ACaptionAlignment = (Jseditdialog::TJSCaptionAlignment)(0x1))/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputComboEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &AValue, const bool AFixedList, System::Classes::TStrings* AItems, const TJSFooterRec &AFooter, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1), const System::UnicodeString AInstruction = System::UnicodeString(), System::UnicodeString AContent = System::UnicodeString(), Vcl::Graphics::TGraphic* AGlyph = (Vcl::Graphics::TGraphic*)(0x0))/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputComboEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &AValue, const bool AFixedList, System::Classes::TStrings* AItems, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1), const System::UnicodeString AInstruction = System::UnicodeString(), System::UnicodeString AContent = System::UnicodeString(), Vcl::Graphics::TGraphic* AGlyph = (Vcl::Graphics::TGraphic*)(0x0))/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputCombo(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &AValue, const bool AFixedList, System::Classes::TStrings* AItems)/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputComboEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, int &AItemIndex, const bool AFixedList, System::Classes::TStrings* AItems, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1))/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputCombo(const System::UnicodeString ACaption, const System::UnicodeString APrompt, int &AItemIndex, const bool AFixedList, System::Classes::TStrings* AItems)/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputList(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &AValue, System::Classes::TStrings* AItems)/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputListEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, System::UnicodeString &AValue, System::Classes::TStrings* AItems, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1))/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputList(const System::UnicodeString ACaption, const System::UnicodeString APrompt, int &AItemIndex, System::Classes::TStrings* AItems)/* overload */;
extern DELPHI_PACKAGE bool __fastcall InputListEx(const System::UnicodeString ACaption, const System::UnicodeString APrompt, int &AItemIndex, System::Classes::TStrings* AItems, Jseditdialog::TJSCaptionPosition ACaptionPosition = (Jseditdialog::TJSCaptionPosition)(0x1))/* overload */;
}	/* namespace Jseditdialogs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSEDITDIALOGS)
using namespace Jseditdialogs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JseditdialogsHPP
