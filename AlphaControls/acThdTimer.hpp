// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acThdTimer.pas' rev: 27.00 (Windows)

#ifndef ActhdtimerHPP
#define ActhdtimerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <System.SyncObjs.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acthdtimer
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TacTimerThread;
class DELPHICLASS TacThreadedTimer;
class PASCALIMPLEMENTATION TacTimerThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
public:
	TacThreadedTimer* OwnerTimer;
	unsigned Interval;
	System::Syncobjs::TSimpleEvent* TimeEvent;
	virtual void __fastcall Execute(void);
	void __fastcall DoTimer(void);
public:
	/* TThread.Create */ inline __fastcall TacTimerThread(void)/* overload */ : System::Classes::TThread() { }
	/* TThread.Create */ inline __fastcall TacTimerThread(bool CreateSuspended)/* overload */ : System::Classes::TThread(CreateSuspended) { }
	/* TThread.Destroy */ inline __fastcall virtual ~TacTimerThread(void) { }
	
};


class PASCALIMPLEMENTATION TacThreadedTimer : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool FEnabled;
	unsigned FInterval;
	System::Classes::TNotifyEvent FOnTimer;
	TacTimerThread* FTimerThread;
	System::Classes::TThreadPriority FThreadPriority;
	void __fastcall KillTimer(void);
	void __fastcall StartTimer(void);
	
protected:
	bool Executing;
	System::TObject* FOwner;
	bool InHandler;
	void __fastcall UpdateTimer(void);
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetInterval(unsigned Value);
	void __fastcall SetOnTimer(System::Classes::TNotifyEvent Value);
	void __fastcall SetThreadPriority(System::Classes::TThreadPriority Value);
	void __fastcall Timer(void);
	virtual void __fastcall TimeHandler(void);
	void __fastcall TimeEvent(System::TObject* Sender);
	
public:
	__fastcall virtual TacThreadedTimer(System::Classes::TComponent* AOwner);
	__fastcall virtual TacThreadedTimer(System::Classes::TComponent* AOwner, bool ChangeEvent);
	__fastcall virtual ~TacThreadedTimer(void);
	void __fastcall Reset(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=1000};
	__property System::Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=SetOnTimer};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=SetThreadPriority, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Acthdtimer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACTHDTIMER)
using namespace Acthdtimer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ActhdtimerHPP
