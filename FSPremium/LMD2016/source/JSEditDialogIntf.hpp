// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSEditDialogIntf.pas' rev: 31.00 (Windows)

#ifndef JseditdialogintfHPP
#define JseditdialogintfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <JSEditDialog.hpp>
#include <JSTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jseditdialogintf
{
//-- forward type declarations -----------------------------------------------
__interface IJSEditDialogControl;
typedef System::DelphiInterface<IJSEditDialogControl> _di_IJSEditDialogControl;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{91E6FD85-AE20-4637-A524-5025A236E238}") IJSEditDialogControl  : public System::IInterface 
{
	virtual Vcl::Controls::TWinControl* __fastcall ActiveControl(void) = 0 ;
	virtual Vcl::Controls::TWinControl* __fastcall ActiveControlInError(void) = 0 ;
	virtual void __fastcall AdjustControlLayout(const int AWidth) = 0 ;
	virtual void __fastcall SetActiveControlInError(Vcl::Controls::TWinControl* AControl) = 0 ;
	virtual int __fastcall GetRequiredWidth(void) = 0 ;
	virtual void __fastcall SetDialog(Jseditdialog::TJSCustomEditDialog* JSDialog) = 0 ;
	virtual bool __fastcall ValidateInput(/* out */ System::UnicodeString &Message, const System::Uitypes::TModalResult ModalResult) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jseditdialogintf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSEDITDIALOGINTF)
using namespace Jseditdialogintf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JseditdialogintfHPP
