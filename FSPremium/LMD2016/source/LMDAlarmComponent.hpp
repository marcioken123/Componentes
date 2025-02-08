// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDAlarmComponent.pas' rev: 31.00 (Windows)

#ifndef LmdalarmcomponentHPP
#define LmdalarmcomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Classes.hpp>
#include <System.SyncObjs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdalarmcomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAlarmItem;
class DELPHICLASS TLMDAlarmItems;
struct TLMDAlarmListItem;
class DELPHICLASS TLMDAlarmThread;
class DELPHICLASS TLMDAlarmTimerThread;
class DELPHICLASS TLMDAlarmComponent;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDAlarmItemMode : unsigned char { imFixed, imInterval };

enum DECLSPEC_DENUM TLMDAlarmInterval : unsigned char { aiCustomInterval, aiSeconds, aiMinutes, aiHours, aiDays, aiWeeks, aiMonths, aiYears };

typedef void __fastcall (*TLMDAlarmCustomInterval)(System::TObject* Sender, __int64 &anInterval, TLMDAlarmInterval &intervalIs);

class PASCALIMPLEMENTATION TLMDAlarmItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::TDateTime FLastExec;
	System::TDateTime FLastCalc;
	System::TDateTime FDateTime;
	System::UnicodeString FCaption;
	__int64 FPriority;
	__int64 FPassTimes;
	__int64 FExecTimes;
	__int64 FRepeatTimes;
	__int64 FId;
	__int64 FInterval;
	TLMDAlarmItemMode FMode;
	TLMDAlarmInterval FIntervalMode;
	TLMDAlarmCustomInterval FOnCustom;
	void __fastcall SetTime(System::UnicodeString aValue);
	System::UnicodeString __fastcall GetTime(void);
	void __fastcall SetDate(System::UnicodeString aValue);
	System::UnicodeString __fastcall GetDate(void);
	void __fastcall SetDateTime(System::TDateTime aValue);
	void __fastcall ReadDate(System::Classes::TReader* Reader);
	void __fastcall ReadTime(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	System::TDateTime __fastcall getNextAlarm(void)/* overload */;
	System::TDateTime __fastcall getNextAlarm(System::TDateTime from)/* overload */;
	
public:
	__fastcall virtual TLMDAlarmItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDAlarmItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::TDateTime ExecutedLast = {read=FLastExec};
	__property __int64 Executed = {read=FExecTimes};
	__property __int64 PassTimes = {read=FPassTimes};
	__property System::UnicodeString Date = {read=GetDate, write=SetDate};
	__property System::UnicodeString Time = {read=GetTime, write=SetTime};
	void __fastcall Update(void);
	
__published:
	__property Index;
	__property DisplayName = {default=0};
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property System::TDateTime DateTime = {read=FDateTime, write=SetDateTime};
	__property __int64 Ident = {read=FId, write=FId};
	__property __int64 RepeatTimes = {read=FRepeatTimes, write=FRepeatTimes, default=-1};
	__property __int64 Interval = {read=FInterval, write=FInterval, default=0};
	__property TLMDAlarmInterval IntervalMode = {read=FIntervalMode, write=FIntervalMode, default=3};
	__property TLMDAlarmItemMode Mode = {read=FMode, write=FMode, default=0};
	__property __int64 Priority = {read=FPriority, write=FPriority, default=0};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAlarmItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDAlarmItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDAlarmComponent* FOwner;
	HIDESBASE TLMDAlarmItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDAlarmItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Classes::TCollectionNotification Action);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDAlarmItems(TLMDAlarmComponent* Owner);
	__fastcall virtual ~TLMDAlarmItems(void);
	HIDESBASE TLMDAlarmItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	int __fastcall GetIndexByID(int ID);
	__property TLMDAlarmItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDAlarmListItem
{
public:
	System::TDateTime DT;
	__int64 priority;
	__int64 index;
};


typedef TLMDAlarmListItem *PLMDAlarmListItem;

class PASCALIMPLEMENTATION TLMDAlarmThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDAlarmComponent* FOwner;
	System::Classes::TList* FEventList;
	__int64 FEventNr;
	System::Syncobjs::TCriticalSection* FOValid;
	System::Syncobjs::TCriticalSection* FLockEventList;
	NativeUInt FEventListSemaphore;
	
public:
	void __fastcall SetOwner(TLMDAlarmComponent* anOwner);
	void __fastcall ExecuteTheEvent(void);
	virtual void __fastcall Execute(void);
	__fastcall TLMDAlarmThread(bool CreateSuspended, TLMDAlarmComponent* Owner);
	__fastcall virtual ~TLMDAlarmThread(void);
	void __fastcall AddEvent(const TLMDAlarmListItem &anEvent);
};


class PASCALIMPLEMENTATION TLMDAlarmTimerThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDAlarmComponent* FOwner;
	System::Syncobjs::TCriticalSection* FOValid;
	
public:
	void __fastcall SetOwner(TLMDAlarmComponent* anOwner);
	virtual void __fastcall Execute(void);
	__fastcall TLMDAlarmTimerThread(bool CreateSuspended, TLMDAlarmComponent* Owner);
	__fastcall virtual ~TLMDAlarmTimerThread(void);
};


typedef void __fastcall (__closure *TLMDAlarmEvent)(System::TObject* Sender, TLMDAlarmItem* item);

typedef void __fastcall (__closure *TLMDAlarmInitItemEvent)(System::TObject* Sender, TLMDAlarmItem* item, System::TDateTime &aDateTime);

class PASCALIMPLEMENTATION TLMDAlarmComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FPriority;
	bool FActive;
	System::TDateTime FStartTime;
	TLMDAlarmItems* FItems;
	TLMDAlarmTimerThread* FAlarmTimerThread;
	TLMDAlarmThread* FAlarmThread;
	System::Classes::TList* FAlarmList;
	System::Syncobjs::TCriticalSection* FExecTimer;
	unsigned FSleepTime;
	Lmdinictrl::TLMDIniCtrl* FIniLink;
	Lmdinictrl::TLMDIniUse FIniUse;
	System::UnicodeString FSection;
	TLMDAlarmEvent FOnAlarm;
	TLMDAlarmInitItemEvent FOnInitItem;
	void __fastcall SetItems(TLMDAlarmItems* aValue);
	void __fastcall SetActive(bool aValue);
	void __fastcall SetIniLink(Lmdinictrl::TLMDIniCtrl* aValue);
	bool __fastcall SaveSection(void);
	
protected:
	void __fastcall ClearAlarmList(void);
	bool __fastcall AddAlarmItems(int anItem);
	bool __fastcall RemoveAlarmItems(int anItem);
	bool __fastcall RemoveAlarmItemsByID(int anID);
	void __fastcall DoTimer(System::TObject* Sender);
	void __fastcall ReadData(void);
	virtual void __fastcall ResetItems(void);
	void __fastcall WriteData(void);
	
public:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	int __fastcall AddItem(System::UnicodeString ADisplayName, System::UnicodeString ACaption, System::TDateTime ADateTime, __int64 AIdent, __int64 ARepeatTimes, __int64 AInterval, TLMDAlarmInterval AIntervalMode = (TLMDAlarmInterval)(0x1), TLMDAlarmItemMode AMode = (TLMDAlarmItemMode)(0x0), __int64 APriority = 0LL);
	void __fastcall ClearItems(void);
	__fastcall virtual TLMDAlarmComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDAlarmComponent(void);
	void __fastcall InitItems(void);
	void __fastcall RemoveItem(int anItem);
	
__published:
	__property About = {default=0};
	__property TLMDAlarmItems* Items = {read=FItems, write=SetItems};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property bool PriorityExec = {read=FPriority, write=FPriority, default=0};
	__property unsigned SleepTime = {read=FSleepTime, write=FSleepTime, default=500};
	__property Lmdinictrl::TLMDIniCtrl* IniLink = {read=FIniLink, write=SetIniLink};
	__property Lmdinictrl::TLMDIniUse IniUse = {read=FIniUse, write=FIniUse, default=2};
	__property System::UnicodeString Section = {read=FSection, write=FSection, stored=SaveSection};
	__property TLMDAlarmEvent OnAlarm = {read=FOnAlarm, write=FOnAlarm};
	__property TLMDAlarmInitItemEvent OnInitItem = {read=FOnInitItem, write=FOnInitItem};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncSecond(System::TDateTime dt, __int64 Seconds);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncMinute(System::TDateTime dt, __int64 Minutes);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncHour(System::TDateTime dt, __int64 Hours);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncDay(System::TDateTime dt, __int64 Days);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncWeek(System::TDateTime dt, __int64 Weeks);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncMonth(System::TDateTime dt, __int64 Months);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncYear(System::TDateTime dt, __int64 Years);
}	/* namespace Lmdalarmcomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDALARMCOMPONENT)
using namespace Lmdalarmcomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdalarmcomponentHPP
