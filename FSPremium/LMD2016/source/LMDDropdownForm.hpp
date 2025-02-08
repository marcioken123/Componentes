// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDropdownForm.pas' rev: 31.00 (Windows)

#ifndef LmddropdownformHPP
#define LmddropdownformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Forms.hpp>
#include <LMDClass.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddropdownform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDropDownForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDropDownForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
protected:
	System::Classes::TNotifyEvent FOnChange;
	System::Classes::TNotifyEvent FOnDeactivate;
	virtual void __fastcall TriggerChangeEvent(void);
	virtual void __fastcall OkBtnClick(System::TObject* Sender);
	virtual void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	virtual void __fastcall CancelBtnClick(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall WMQueryEndSession(Winapi::Messages::TMessage &Message);
	
public:
	bool IsModal;
	__fastcall virtual TLMDDropDownForm(System::Classes::TComponent* AOwner, int Dummy);
	virtual void __fastcall SetFormThemed(bool Value);
	virtual void __fastcall SetThemeMode(Lmdclass::TLMDThemeMode AMode);
	
__published:
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnDeactivate = {read=FOnDeactivate, write=FOnDeactivate};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDDropDownForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDDropDownForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDropDownForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddropdownform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDROPDOWNFORM)
using namespace Lmddropdownform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddropdownformHPP
