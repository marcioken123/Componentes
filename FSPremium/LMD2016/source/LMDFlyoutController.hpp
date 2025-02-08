// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFlyoutController.pas' rev: 31.00 (Windows)

#ifndef LmdflyoutcontrollerHPP
#define LmdflyoutcontrollerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdflyoutcontroller
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFlyoutController;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFlyoutPosition : unsigned char { fopTop, fopRight, fopBottom, fopLeft };

class PASCALIMPLEMENTATION TLMDFlyoutController : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	bool FActive;
	Vcl::Controls::TControl* FControl;
	Vcl::Extctrls::TTimer* FTimer;
	bool FHiding;
	bool FShowing;
	System::Types::TPoint FPosition;
	TLMDFlyoutPosition FDestination;
	int FTriggerDistance;
	bool FControlVisible;
	int FStep;
	void __fastcall SetControl(Vcl::Controls::TControl* aControl);
	void __fastcall SetDestination(const TLMDFlyoutPosition Value);
	void __fastcall SetTriggerDistance(const int Value);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetStep(const int Value);
	
protected:
	bool __fastcall HasControl(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall Timer(System::TObject* Sender);
	virtual void __fastcall Show(void);
	virtual void __fastcall Hide(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDFlyoutController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFlyoutController(void);
	
__published:
	__property About = {default=0};
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl, stored=HasControl};
	__property TLMDFlyoutPosition Destination = {read=FDestination, write=SetDestination, nodefault};
	
public:
	__property System::Types::TPoint Position = {read=FPosition, write=FPosition};
	
__published:
	__property int TriggerDistance = {read=FTriggerDistance, write=SetTriggerDistance, nodefault};
	__property int Step = {read=FStep, write=SetStep, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdflyoutcontroller */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFLYOUTCONTROLLER)
using namespace Lmdflyoutcontroller;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdflyoutcontrollerHPP
