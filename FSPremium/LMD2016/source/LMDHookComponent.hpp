// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHookComponent.pas' rev: 31.00 (Windows)

#ifndef LmdhookcomponentHPP
#define LmdhookcomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhookcomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomHookComponent;
class DELPHICLASS TLMDHookComponent;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDHookEvent)(System::TObject* Sender, Winapi::Messages::TMessage &Message, bool &Handled);

class PASCALIMPLEMENTATION TLMDCustomHookComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FActive;
	bool FDesignActive;
	bool FEnabled;
	TLMDHookEvent FOnBeforeProcess;
	TLMDHookEvent FOnAfterProcess;
	Vcl::Controls::TControl* FControl;
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetControl(Vcl::Controls::TControl* newValue);
	void __fastcall SetActive(bool newValue);
	void __fastcall SetDesignActive(bool newValue);
	
protected:
	bool __fastcall HasControl(void);
	DYNAMIC void __fastcall Init(void);
	DYNAMIC void __fastcall RestoreState(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall TriggerBeforeProcessEvent(Winapi::Messages::TMessage &Msg, bool &Handled);
	virtual void __fastcall TriggerAfterProcessEvent(Winapi::Messages::TMessage &Msg, bool &Handled);
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	
public:
	__fastcall virtual TLMDCustomHookComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomHookComponent(void);
	__property bool Active = {read=FActive, write=SetActive, default=1};
	__property bool DesignActive = {read=FDesignActive, write=SetDesignActive, default=0};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl, stored=HasControl};
	__property TLMDHookEvent OnBeforeProcess = {read=FOnBeforeProcess, write=FOnBeforeProcess};
	__property TLMDHookEvent OnAfterProcess = {read=FOnAfterProcess, write=FOnAfterProcess};
};


class PASCALIMPLEMENTATION TLMDHookComponent : public TLMDCustomHookComponent
{
	typedef TLMDCustomHookComponent inherited;
	
private:
	TLMDHookEvent FOnMessage;
	
protected:
	virtual void __fastcall TriggerBeforeProcessEvent(Winapi::Messages::TMessage &Msg, bool &Handled);
	
public:
	__fastcall virtual TLMDHookComponent(System::Classes::TComponent* aOwner);
	
__published:
	__property About = {default=0};
	__property Control;
	__property TLMDHookEvent OnMessage = {read=FOnMessage, write=FOnMessage};
public:
	/* TLMDCustomHookComponent.Destroy */ inline __fastcall virtual ~TLMDHookComponent(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhookcomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHOOKCOMPONENT)
using namespace Lmdhookcomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhookcomponentHPP
