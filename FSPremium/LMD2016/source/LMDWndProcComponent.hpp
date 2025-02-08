// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWndProcComponent.pas' rev: 31.00 (Windows)

#ifndef LmdwndproccomponentHPP
#define LmdwndproccomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwndproccomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWndProcComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDWndProcComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FEnabled;
	bool FDesignEnabled;
	bool FHooked;
	bool FSilent;
	System::Byte FMDIForm;
	System::Classes::TWndMethod FWndProcOld;
	void *FClientWndProcOld;
	void *FClientInstance;
	bool __fastcall NewWndProc(void);
	void __fastcall SetDesignEnabled(bool aValue);
	void __fastcall SetHandleApp(bool aValue);
	
protected:
	bool FDestroying;
	bool FHandleApp;
	bool FHandleMDI;
	Vcl::Forms::TForm* __fastcall GetOwnerForm(void);
	HWND __fastcall GetOwnerHandle(void);
	virtual void __fastcall SetEnabled(bool aValue);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	bool __fastcall RestoreWndProc(void);
	void __fastcall CallPrevWndProc(Winapi::Messages::TMessage &Message);
	virtual bool __fastcall AppWndProc(Winapi::Messages::TMessage &Message);
	bool __fastcall ExistWndProcOld(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall RestoreState(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DesignEnabledChanged(void);
	virtual void __fastcall EnabledChanged(void);
	__property bool DesignEnabled = {read=FDesignEnabled, write=SetDesignEnabled, default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool HandleApp = {read=FHandleApp, write=SetHandleApp, default=0};
	__property System::Byte MDIForm = {read=FMDIForm, nodefault};
	__property System::Classes::TWndMethod PrevWndProc = {read=FWndProcOld};
	
public:
	__fastcall virtual TLMDWndProcComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDWndProcComponent(void);
	bool __fastcall ValidOwner(void);
	void __fastcall SilentRemove(void);
	__property HWND WndHandle = {read=GetOwnerHandle, nodefault};
	__property Vcl::Forms::TForm* WndOwner = {read=GetOwnerForm};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwndproccomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWNDPROCCOMPONENT)
using namespace Lmdwndproccomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwndproccomponentHPP
