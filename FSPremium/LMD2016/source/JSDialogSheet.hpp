// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDialogSheet.pas' rev: 31.00 (Windows)

#ifndef JsdialogsheetHPP
#define JsdialogsheetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <JSDialog.hpp>
#include <JSDialogs.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdialogsheet
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSCustomDialogSheet;
class DELPHICLASS TJSDialogSheet;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TJSCustomDialogSheet : public Jsdialog::TJSDialog
{
	typedef Jsdialog::TJSDialog inherited;
	
private:
	System::Classes::TWndMethod FOldWndProc;
	Vcl::Forms::TCustomForm* FActiveForm;
	
protected:
	void __fastcall ActiveFormWndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TJSCustomDialogSheet(System::Classes::TComponent* AOwner);
	virtual int __fastcall Execute(System::Classes::TComponent* aOwner)/* overload */;
	virtual int __fastcall Close(const int AModalResult);
public:
	/* TJSCustomDialog.Destroy */ inline __fastcall virtual ~TJSCustomDialogSheet(void) { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Execute(void){ return Jsdialog::TJSCustomDialog::Execute(); }
	
};


class PASCALIMPLEMENTATION TJSDialogSheet : public TJSCustomDialogSheet
{
	typedef TJSCustomDialogSheet inherited;
	
__published:
	__property BorderStyle = {default=0};
	__property Position = {default=4};
	__property DialogStyle = {default=1};
public:
	/* TJSCustomDialogSheet.Create */ inline __fastcall virtual TJSDialogSheet(System::Classes::TComponent* AOwner) : TJSCustomDialogSheet(AOwner) { }
	
public:
	/* TJSCustomDialog.Destroy */ inline __fastcall virtual ~TJSDialogSheet(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jsdialogsheet */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDIALOGSHEET)
using namespace Jsdialogsheet;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdialogsheetHPP
