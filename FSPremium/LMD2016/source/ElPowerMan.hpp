// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElPowerMan.pas' rev: 31.00 (Windows)

#ifndef ElpowermanHPP
#define ElpowermanHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <ElBaseComp.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elpowerman
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElPowerManager;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElPowerResumeType : unsigned char { prtNormal, prtCritical, prtAutomatic, prtStandby };

enum DECLSPEC_DENUM TElPowerStatus : unsigned char { psUnknown, psInactive, psActive };

enum DECLSPEC_DENUM TElBatteryState : unsigned char { bsUnknown, bsNoBattery, bsHigh, bsLow, bsCritical, bsCharging };

typedef void __fastcall (__closure *TElPowerQueryEvent)(System::TObject* Sender, bool UserInterfaceAllowed, bool &Allowed);

typedef void __fastcall (__closure *TElPowerResumeEvent)(System::TObject* Sender, TElPowerResumeType ResumeAfter);

class PASCALIMPLEMENTATION TElPowerManager : public Elbasecomp::TElBaseComponent
{
	typedef Elbasecomp::TElBaseComponent inherited;
	
protected:
	TElPowerResumeEvent FOnResume;
	System::Classes::TNotifyEvent FOnSuspend;
	System::Classes::TNotifyEvent FOnBatteryLow;
	System::Classes::TNotifyEvent FOnPowerStatusChange;
	TElPowerQueryEvent FOnQuerySuspend;
	System::Classes::TNotifyEvent FOnSuspendAborted;
	TElPowerQueryEvent FOnQueryStandby;
	System::Classes::TNotifyEvent FOnStandbyAborted;
	System::Classes::TNotifyEvent FOnStandby;
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoSuspend(void);
	virtual void __fastcall DoBatteryLow(void);
	virtual void __fastcall DoQuerySuspend(bool UIAllowed, bool &SuspendAllowed);
	virtual void __fastcall DoPowerStatusChange(void);
	virtual void __fastcall DoSuspendAborted(void);
	virtual void __fastcall DoResume(TElPowerResumeType ResumeType);
	TElPowerStatus __fastcall GetACPowerStatus(void);
	TElBatteryState __fastcall GetBatteryState(void);
	int __fastcall GetBatteryLifePercent(void);
	virtual void __fastcall DoStandby(void);
	virtual void __fastcall DoStandbyAborted(void);
	virtual void __fastcall DoQueryStandby(bool UIAllowed, bool &SuspendAllowed);
	
public:
	__property TElPowerStatus ACPowerStatus = {read=GetACPowerStatus, nodefault};
	__property TElBatteryState BatteryState = {read=GetBatteryState, nodefault};
	__property int BatteryLifePercent = {read=GetBatteryLifePercent, nodefault};
	
__published:
	__property TElPowerResumeEvent OnResume = {read=FOnResume, write=FOnResume};
	__property System::Classes::TNotifyEvent OnSuspend = {read=FOnSuspend, write=FOnSuspend};
	__property System::Classes::TNotifyEvent OnBatteryLow = {read=FOnBatteryLow, write=FOnBatteryLow};
	__property System::Classes::TNotifyEvent OnPowerStatusChange = {read=FOnPowerStatusChange, write=FOnPowerStatusChange};
	__property TElPowerQueryEvent OnQuerySuspend = {read=FOnQuerySuspend, write=FOnQuerySuspend};
	__property TElPowerQueryEvent OnQueryStandby = {read=FOnQueryStandby, write=FOnQueryStandby};
	__property System::Classes::TNotifyEvent OnSuspendAborted = {read=FOnSuspendAborted, write=FOnSuspendAborted};
	__property System::Classes::TNotifyEvent OnStandbyAborted = {read=FOnStandbyAborted, write=FOnStandbyAborted};
	__property System::Classes::TNotifyEvent OnStandby = {read=FOnStandby, write=FOnStandby};
	__property Enabled = {default=0};
public:
	/* TElBaseComponent.Create */ inline __fastcall virtual TElPowerManager(System::Classes::TComponent* AOwner) : Elbasecomp::TElBaseComponent(AOwner) { }
	/* TElBaseComponent.Destroy */ inline __fastcall virtual ~TElPowerManager(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elpowerman */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPOWERMAN)
using namespace Elpowerman;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElpowermanHPP
