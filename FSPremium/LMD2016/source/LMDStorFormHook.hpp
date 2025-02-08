// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorFormHook.pas' rev: 31.00 (Windows)

#ifndef LmdstorformhookHPP
#define LmdstorformhookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <System.TypInfo.hpp>
#include <LMDStorBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorformhook
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorFormHook;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStorFormHook : public Lmdstorbase::TLMDStorComponent
{
	typedef Lmdstorbase::TLMDStorComponent inherited;
	
private:
	bool FEnabled;
	bool FHandled;
	System::Classes::TNotifyEvent FOwnerFormCreate;
	System::Classes::TNotifyEvent FOwnerFormShow;
	System::Classes::TNotifyEvent FOwnerFormDestroy;
	System::Classes::TNotifyEvent FOnLoading;
	System::Classes::TNotifyEvent FOnSaving;
	Vcl::Forms::TCloseQueryEvent FOwnerFormClose;
	int FID;
	Vcl::Forms::TForm* __fastcall GetOwnerForm(void);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall RestoreEvents(void);
	void __fastcall SetEvents(void);
	DYNAMIC void __fastcall OwnerFormCreate(System::TObject* Sender);
	DYNAMIC void __fastcall OwnerFormClose(System::TObject* Sender, bool &CanClose);
	DYNAMIC void __fastcall OwnerFormDestroy(System::TObject* Sender);
	DYNAMIC void __fastcall DoOnLoading(void);
	DYNAMIC void __fastcall DoOnSaving(void);
	
public:
	__fastcall virtual TLMDStorFormHook(System::Classes::TComponent* aOwner);
	__property Vcl::Forms::TForm* Form = {read=GetOwnerForm};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property System::Classes::TNotifyEvent OnLoading = {read=FOnLoading, write=FOnLoading};
	__property System::Classes::TNotifyEvent OnSaving = {read=FOnSaving, write=FOnSaving};
	__property int ID = {read=FID, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStorFormHook(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorformhook */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORFORMHOOK)
using namespace Lmdstorformhook;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorformhookHPP
