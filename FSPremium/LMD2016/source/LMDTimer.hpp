// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTimer.pas' rev: 31.00 (Windows)

#ifndef LmdtimerHPP
#define LmdtimerHPP

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
#include <Winapi.MMSystem.hpp>
#include <LMDClass.hpp>
#include <LMDConst.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtimer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDThreadedTimer;
class DELPHICLASS TLMDHiTimer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDThreadedTimer : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDHiTimer* FTimer;
	Lmdclass::TLMDTimerInterval FInterval;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__property Lmdclass::TLMDTimerInterval Interval = {read=FInterval, write=FInterval, nodefault};
	__fastcall TLMDThreadedTimer(TLMDHiTimer* aOwner);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TLMDThreadedTimer(void) { }
	
};


class PASCALIMPLEMENTATION TLMDHiTimer : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FEnabled;
	bool FInternalFlag;
	unsigned FInterval;
	unsigned FTimerID;
	timecaps_tag FTimerCaps;
	System::Classes::TNotifyEvent FOnTimer;
	HWND FWindowHandle;
	TLMDThreadedTimer* FThread;
	System::Classes::TThreadPriority FThreadPriority;
	bool FSynchronize;
	bool FUseThread;
	void __fastcall SetThreadPriority(System::Classes::TThreadPriority aValue);
	void __fastcall SetUseThread(bool aValue);
	void __fastcall SetEnabled(bool aValue);
	void __fastcall SetInterval(unsigned aValue);
	void __fastcall SetOnTimer(System::Classes::TNotifyEvent aValue);
	void __fastcall UpdateTimer(void);
	void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	timecaps_tag __fastcall GetCaps(void);
	int __fastcall GetInteger(int index);
	
protected:
	DYNAMIC void __fastcall Timer(void);
	
public:
	__fastcall virtual TLMDHiTimer(System::Classes::TComponent* AOwner);
	__fastcall TLMDHiTimer(System::Classes::TComponent* aOwner, Lmdclass::TLMDTimerInterval Interval);
	__fastcall virtual ~TLMDHiTimer(void);
	__property int MaxInterval = {read=GetInteger, index=0, nodefault};
	__property int MinInterval = {read=GetInteger, index=1, nodefault};
	
__published:
	__property About = {default=0};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=1000};
	__property System::Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=SetOnTimer};
	__property bool Synchronize = {read=FSynchronize, write=FSynchronize, default=1};
	__property bool UseThread = {read=FUseThread, write=SetUseThread, default=1};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=SetThreadPriority, default=3};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtimer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTIMER)
using namespace Lmdtimer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtimerHPP
