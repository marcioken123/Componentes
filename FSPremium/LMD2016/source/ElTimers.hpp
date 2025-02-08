// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTimers.pas' rev: 31.00 (Windows)

#ifndef EltimersHPP
#define EltimersHPP

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
#include <Winapi.MMSystem.hpp>
#include <System.SysUtils.hpp>
#include <ElComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDElConst.hpp>
#include <LMDUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltimers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomElTimer;
class DELPHICLASS TElTimer;
class DELPHICLASS TElPoolTimer;
class DELPHICLASS TElTimerPoolItem;
class DELPHICLASS TElTimerPoolItems;
class DELPHICLASS TTimerThread;
class DELPHICLASS TElTimerPool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomElTimer : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FEnabled;
	unsigned FInterval;
	bool FOneTime;
	System::Classes::TNotifyEvent FOnTimer;
	int FTag;
	void __fastcall SetInterval(const unsigned Value);
	
protected:
	virtual void __fastcall DoTick(void);
	virtual void __fastcall DoTimer(void);
	virtual void __fastcall SetEnabled(const bool Value);
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property unsigned Interval = {read=FInterval, write=SetInterval, default=1000};
	__property bool OneTime = {read=FOneTime, write=FOneTime, nodefault};
	__property System::Classes::TNotifyEvent OnTimer = {read=FOnTimer, write=FOnTimer};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	
public:
	__fastcall virtual TCustomElTimer(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCustomElTimer(void) { }
	
};


class PASCALIMPLEMENTATION TElTimer : public TCustomElTimer
{
	typedef TCustomElTimer inherited;
	
private:
	unsigned FTimerID;
	HWND FWnd;
	void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall SetEnabled(const bool Value);
	
public:
	__fastcall virtual TElTimer(void);
	__fastcall virtual ~TElTimer(void);
	__property Enabled;
	__property Interval = {default=1000};
	__property OneTime;
	__property OnTimer;
	__property Tag;
};


class PASCALIMPLEMENTATION TElPoolTimer : public TCustomElTimer
{
	typedef TCustomElTimer inherited;
	
private:
	unsigned FElapsed;
	TElTimerPoolItem* FOwner;
	
protected:
	virtual void __fastcall SetEnabled(const bool Value);
	
public:
	void __fastcall Tick(int TickCount);
	__property unsigned Elapsed = {read=FElapsed, write=FElapsed, nodefault};
	__property Enabled;
	__property Interval = {default=1000};
	__property OneTime;
	__property OnTimer;
	__property TElTimerPoolItem* Owner = {read=FOwner};
	__property Tag;
public:
	/* TCustomElTimer.Create */ inline __fastcall virtual TElPoolTimer(void) : TCustomElTimer() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElPoolTimer(void) { }
	
};


class PASCALIMPLEMENTATION TElTimerPoolItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TElPoolTimer* FTimer;
	System::Classes::TNotifyEvent FOnTimer;
	bool __fastcall GetEnabled(void);
	unsigned __fastcall GetInterval(void);
	bool __fastcall GetOneTime(void);
	System::Classes::TNotifyEvent __fastcall GetOnTimer(void);
	int __fastcall GetTag(void);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetInterval(const unsigned Value);
	void __fastcall SetOneTime(const bool Value);
	void __fastcall SetOnTimer(const System::Classes::TNotifyEvent Value);
	void __fastcall SetTag(const int Value);
	void __fastcall TimerTransfer(System::TObject* Sender);
	
public:
	__fastcall virtual TElTimerPoolItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElTimerPoolItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property TElPoolTimer* Timer = {read=FTimer};
	
__published:
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, nodefault};
	__property unsigned Interval = {read=GetInterval, write=SetInterval, default=1000};
	__property bool OneTime = {read=GetOneTime, write=SetOneTime, nodefault};
	__property System::Classes::TNotifyEvent OnTimer = {read=GetOnTimer, write=SetOnTimer};
	__property int Tag = {read=GetTag, write=SetTag, nodefault};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTimerPoolItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElTimerPoolItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TElTimerPool* FOwner;
	HIDESBASE TElTimerPoolItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TElTimerPoolItem* const Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TElTimerPoolItems(TElTimerPool* AOwner);
	HIDESBASE TElTimerPoolItem* __fastcall Add(void);
	TElTimerPoolItem* __fastcall AddTimer(bool Enabled, unsigned Interval, bool OneTime, System::Classes::TNotifyEvent OnTimerEvent);
	__property TElTimerPoolItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElTimerPoolItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTimerThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	unsigned fuDelay;
	unsigned fuResolution;
	Winapi::Mmsystem::TFNTimeCallBack flpFunction;
	unsigned fdwUser;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TTimerThread(void);
	__classmethod unsigned __fastcall timeSetEvent(unsigned uDelay, unsigned uResolution, Winapi::Mmsystem::TFNTimeCallBack lpFunction, unsigned dwUser, unsigned uFlags);
	__classmethod void __fastcall timeKillEvent(unsigned &uTimerID);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TTimerThread(void) { }
	
};


enum DECLSPEC_DENUM TElTimerMode : unsigned char { eltWindows, eltMMedia, eltThread };

class PASCALIMPLEMENTATION TElTimerPool : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	int FEnableCount;
	TElTimerPoolItems* FItems;
	unsigned FTimerID;
	unsigned FLastTick;
	TElTimerMode FTimerMode;
	HWND FWnd;
	bool FBlockEvents;
	void __fastcall SetItems(TElTimerPoolItems* Value);
	void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	void __fastcall SetTimerMode(const TElTimerMode Value);
	bool __fastcall GetPrecise _DEPRECATED_ATTRIBUTE0 (void);
	virtual void __fastcall SetPrecise _DEPRECATED_ATTRIBUTE0 (bool newValue);
	void __fastcall ReadTimerModeAsBool(System::Classes::TReader* Reader);
	
protected:
	void __fastcall KillCurrTimer(void);
	virtual void __fastcall EnableTimer(bool Enable);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TElTimerPool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTimerPool(void);
	void __fastcall Tick(int TickCount);
	TElTimerPoolItem* __fastcall AddTimer(bool Enabled, unsigned Interval, bool OneTime, System::Classes::TNotifyEvent OnTimerEvent);
	__property bool Precise = {read=GetPrecise, write=SetPrecise, nodefault};
	
__published:
	__property TElTimerPoolItems* Items = {read=FItems, write=SetItems};
	__property TElTimerMode TimerMode = {read=FTimerMode, write=SetTimerMode, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltimers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTIMERS)
using namespace Eltimers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltimersHPP
