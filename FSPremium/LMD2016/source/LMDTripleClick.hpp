// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTripleClick.pas' rev: 31.00 (Windows)

#ifndef LmdtripleclickHPP
#define LmdtripleclickHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtripleclick
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTripleClick;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDMouseSensitivity : unsigned char { ctoOwner, ctoWindows };

class PASCALIMPLEMENTATION TLMDTripleClick : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Vcl::Controls::TControl* FControl;
	TLMDMouseSensitivity FMouseSensitivity;
	unsigned FDoubleClickTimeout;
	int FDoubleClickCX;
	int FDoubleClickCY;
	System::Classes::TWndMethod FNativeWinProc;
	unsigned FLastClickTime;
	System::Byte FClickCount;
	System::Classes::TNotifyEvent FOnTripleClick;
	bool FHideDoubleClickEvent;
	int FFirstClickX;
	int FFirstClickY;
	void __fastcall SetControl(Vcl::Controls::TControl* AControl);
	void __fastcall SetMouseSensitivity(TLMDMouseSensitivity AMouseSensitivity);
	void __fastcall SetDoubleClickTimeout(unsigned AOwnerTimout);
	void __fastcall GetOSMouseSensitivity(void);
	void __fastcall WindowProc(Winapi::Messages::TMessage &Msg);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDTripleClick(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTripleClick(void);
	
__published:
	__property About = {default=0};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=SetControl};
	__property int DeltaX = {read=FDoubleClickCX, write=FDoubleClickCX, default=0};
	__property int DeltaY = {read=FDoubleClickCY, write=FDoubleClickCY, default=0};
	__property unsigned DoubleClickTimeout = {read=FDoubleClickTimeout, write=SetDoubleClickTimeout, default=0};
	__property bool HideDoubleClickEvent = {read=FHideDoubleClickEvent, write=FHideDoubleClickEvent, default=0};
	__property TLMDMouseSensitivity MouseSensitivity = {read=FMouseSensitivity, write=SetMouseSensitivity, default=0};
	__property System::Classes::TNotifyEvent OnTripleClick = {read=FOnTripleClick, write=FOnTripleClick};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtripleclick */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTRIPLECLICK)
using namespace Lmdtripleclick;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtripleclickHPP
