// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSDialogCheck.pas' rev: 31.00 (Windows)

#ifndef JsdialogcheckHPP
#define JsdialogcheckHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <JSDialog.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jsdialogcheck
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TJSDialogCheck;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TJSDialogCheck : public Jsdialog::TJSDialog
{
	typedef Jsdialog::TJSDialog inherited;
	
	
private:
	typedef System::DynamicArray<bool> _TJSDialogCheck__1;
	
	
private:
	_TJSDialogCheck__1 FCheckResult;
	
protected:
	virtual void __fastcall DoCreated(void);
	virtual void __fastcall DoDialogClose(System::TObject* Sender);
	virtual bool __fastcall DoGetRadioButtonChecked(Vcl::Controls::TControl* AControl);
	virtual void __fastcall InitialiseControl(Jsdialog::TControlType AControlType, Vcl::Controls::TControl* AControl, System::Classes::TCollectionItem* AControlItem);
	virtual void __fastcall InitialiseControlClass(Jsdialog::TControlType AControlType, Vcl::Controls::TControlClass &AControlClass);
	
public:
	__fastcall virtual TJSDialogCheck(System::Classes::TComponent* AOwner);
	bool __fastcall GetCheckResult(const int aValue);
	
__published:
	__property DialogOptions = {default=258};
public:
	/* TJSCustomDialog.Destroy */ inline __fastcall virtual ~TJSDialogCheck(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Jsdialogcheck */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSDIALOGCHECK)
using namespace Jsdialogcheck;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JsdialogcheckHPP
