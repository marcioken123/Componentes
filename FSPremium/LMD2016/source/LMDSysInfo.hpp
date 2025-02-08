// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysinfoHPP
#define LmdsysinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDCPUInfoObject.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysInfo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysInfo : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::Classes::TStringList* FEnvironment;
	Lmdcpuinfoobject::TLMDCPUInfoObject* FCPUInfo;
	void __fastcall Dummy(int index, System::UnicodeString aString);
	void __fastcall DummyInt(int index, int AInt);
	void __fastcall DummyInt64(int index, const __int64 AInt);
	void __fastcall DummyByte(System::Byte aByte);
	void __fastcall DummyStrings(System::Classes::TStringList* AList);
	void __fastcall DummyBool(int index, bool aBool);
	System::UnicodeString __fastcall GetInfoString(int index);
	int __fastcall GetInfoLongInt(int index);
	__int64 __fastcall GetInfoLongLongInt(int index);
	System::UnicodeString __fastcall GetFileName(void);
	System::Classes::TStringList* __fastcall GetFonts(void);
	System::Classes::TStringList* __fastcall GetPrinters(void);
	System::Byte __fastcall GetProcessorNumber(void);
	System::Byte __fastcall GetColorDepth(void);
	bool __fastcall GetInfoBool(int index);
	void __fastcall SetInfoBool(int index, bool State);
	System::Classes::TStringList* __fastcall GetEnvString(void);
	int __fastcall GetKeyboardDelay(void);
	void __fastcall SetKeyboardDelay(int aValue);
	int __fastcall GetKeyboardSpeed(void);
	void __fastcall SetKeyboardSpeed(int aValue);
	System::UnicodeString __fastcall GetLocalInfo(int index);
	void __fastcall SetLocalInfo(int index, System::UnicodeString aValue);
	
public:
	__fastcall virtual TLMDSysInfo(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSysInfo(void);
	Lmdtypes::TLMDPercent __fastcall FreeSys(void);
	Lmdtypes::TLMDPercent __fastcall FreeGDI(void);
	Lmdtypes::TLMDPercent __fastcall FreeUSR(void);
	__property System::UnicodeString TempFileName = {read=GetFileName};
	void __fastcall GetDriveList(System::Classes::TStringList* aList);
	Lmdsysin::TLMDDriveInfo __fastcall GetDriveInfo(System::UnicodeString aDrive);
	System::UnicodeString __fastcall GetDriveTypeString(unsigned aType);
	System::UnicodeString __fastcall GetEnvironmentValue(System::UnicodeString aEnvironmentString);
	bool __fastcall SetEnvironmentValue(System::UnicodeString aEnvironmentString, const System::UnicodeString aValue);
	void __fastcall SetDesktopWallpaper(const System::Sysutils::TFileName aBitmapPath);
	System::Types::TRect __fastcall GetScreenRect(void);
	System::Types::TRect __fastcall GetWorkRect(void);
	__property System::UnicodeString Username = {read=GetInfoString, index=2};
	__property System::UnicodeString UserCompany = {read=GetInfoString, index=1};
	
__published:
	__property About = {default=0};
	__property System::Classes::TStringList* AllFonts = {read=GetFonts, write=DummyStrings, stored=false};
	__property System::Classes::TStringList* AllPrinters = {read=GetPrinters, write=DummyStrings, stored=false};
	__property System::UnicodeString CurrentUser = {read=GetInfoString, write=Dummy, stored=false, index=0};
	__property System::UnicodeString RegisteredCompany = {read=GetInfoString, write=Dummy, stored=false, index=1};
	__property System::UnicodeString RegisteredOwner = {read=GetInfoString, write=Dummy, stored=false, index=2};
	__property int ScreenSaverDelay = {read=GetInfoLongInt, write=DummyInt, stored=false, index=7, nodefault};
	__property System::UnicodeString VersionWIN = {read=GetInfoString, write=Dummy, stored=false, index=3};
	__property System::UnicodeString WinPath = {read=GetInfoString, write=Dummy, stored=false, index=4};
	__property System::UnicodeString WinSysPath = {read=GetInfoString, write=Dummy, stored=false, index=5};
	__property System::Classes::TStringList* Environment = {read=GetEnvString, write=DummyStrings, stored=false};
	__property System::UnicodeString FreeGdiRes = {read=GetInfoString, write=Dummy, stored=false, index=6};
	__property System::UnicodeString FreeUsrRes = {read=GetInfoString, write=Dummy, stored=false, index=7};
	__property System::UnicodeString FreeSysRes = {read=GetInfoString, write=Dummy, stored=false, index=8};
	__property int BuildNumber = {read=GetInfoLongInt, write=DummyInt, stored=false, index=0, nodefault};
	__property __int64 MemPhysTotal = {read=GetInfoLongLongInt, write=DummyInt64, stored=false, index=1};
	__property __int64 MemPhysFree = {read=GetInfoLongLongInt, write=DummyInt64, stored=false, index=2};
	__property __int64 MemVirtTotal = {read=GetInfoLongLongInt, write=DummyInt64, stored=false, index=3};
	__property __int64 MemVirtFree = {read=GetInfoLongLongInt, write=DummyInt64, stored=false, index=4};
	__property __int64 MemVirtExtended = {read=GetInfoLongLongInt, write=DummyInt64, stored=false, index=7};
	__property __int64 MemPageTotal = {read=GetInfoLongLongInt, write=DummyInt64, stored=false, index=5};
	__property __int64 MemPageFree = {read=GetInfoLongLongInt, write=DummyInt64, stored=false, index=6};
	__property System::UnicodeString MemoryLoaded = {read=GetInfoString, write=Dummy, stored=false, index=9};
	__property System::UnicodeString Platform = {read=GetInfoString, write=Dummy, stored=false, index=10};
	__property System::UnicodeString TempPath = {read=GetInfoString, write=Dummy, stored=false, index=11};
	__property System::UnicodeString Computername = {read=GetInfoString, write=Dummy, stored=false, index=12};
	__property System::Byte ProcessorNumber = {read=GetProcessorNumber, write=DummyByte, stored=false, nodefault};
	__property System::UnicodeString ProcessorType = {read=GetInfoString, write=Dummy, stored=false, index=13};
	__property Lmdcpuinfoobject::TLMDCPUInfoObject* ProcessorInfo = {read=FCPUInfo};
	__property System::Byte ColorDepth = {read=GetColorDepth, write=DummyByte, stored=false, nodefault};
	__property System::UnicodeString DefaultLanguageString = {read=GetInfoString, write=Dummy, stored=false, index=14};
	__property System::UnicodeString TimeZone = {read=GetInfoString, write=Dummy, stored=false, index=15};
	__property int TimeZoneDiff = {read=GetInfoLongInt, write=DummyInt, stored=false, index=9, nodefault};
	__property bool PlusAvailable = {read=GetInfoBool, write=DummyBool, stored=false, index=9, nodefault};
	__property int ScreenWidth = {read=GetInfoLongInt, write=DummyInt, stored=false, index=10, nodefault};
	__property int ScreenHeight = {read=GetInfoLongInt, write=DummyInt, stored=false, index=11, nodefault};
	__property int ScreenPPi = {read=GetInfoLongInt, write=DummyInt, stored=false, index=12, nodefault};
	__property System::UnicodeString LocaleCalendarType = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=0};
	__property System::UnicodeString LocaleCurrencyDigits = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=1};
	__property System::UnicodeString LocaleICurrency = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=2};
	__property System::UnicodeString LocaleDigits = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=3};
	__property System::UnicodeString LocaleFirstDayOfWeek = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=4};
	__property System::UnicodeString LocaleFirstWeekOfYear = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=5};
	__property System::UnicodeString LocaleZero = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=6};
	__property System::UnicodeString LocaleMeasureSystem = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=7};
	__property System::UnicodeString LocaleNegativeCurrencyFormat = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=8};
	__property System::UnicodeString LocaleNegativeNumberFormat = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=9};
	__property System::UnicodeString LocaleTime = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=10};
	__property System::UnicodeString LocaleMorningSymbol = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=11};
	__property System::UnicodeString LocaleAfternoonSymbol = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=12};
	__property System::UnicodeString LocaleCurrencySymbol = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=13};
	__property System::UnicodeString LocaleDateSeparator = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=14};
	__property System::UnicodeString LocaleDecimalSeparator = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=15};
	__property System::UnicodeString LocaleNumericGrouping = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=16};
	__property System::UnicodeString LocaleListSeparator = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=17};
	__property System::UnicodeString LocaleLongDateFormat = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=18};
	__property System::UnicodeString LocaleMonthDecimalSeparator = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=19};
	__property System::UnicodeString LocaleCurrencyGrouping = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=20};
	__property System::UnicodeString LocaleThousandSeparator = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=21};
	__property System::UnicodeString LocaleNegativeSign = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=22};
	__property System::UnicodeString LocalePositiveSign = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=23};
	__property System::UnicodeString LocaleShortDateFormat = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=24};
	__property System::UnicodeString LocaleThousand = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=25};
	__property System::UnicodeString LocaleTimeSeparator = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=26};
	__property System::UnicodeString LocaleShortTimeFormat = {read=GetLocalInfo, write=SetLocalInfo, stored=false, index=27};
	__property bool NumLockState = {read=GetInfoBool, write=SetInfoBool, stored=false, index=0, nodefault};
	__property bool CapsLockState = {read=GetInfoBool, write=SetInfoBool, stored=false, index=1, nodefault};
	__property bool ScrollLockState = {read=GetInfoBool, write=SetInfoBool, stored=false, index=2, nodefault};
	__property int DefaultLanguageID = {read=GetInfoLongInt, stored=false, index=8, nodefault};
	__property int KeyboardDelay = {read=GetKeyboardDelay, write=SetKeyboardDelay, stored=false, nodefault};
	__property int KeyboardSpeed = {read=GetKeyboardSpeed, write=SetKeyboardSpeed, stored=false, nodefault};
	__property bool WindowAnimation = {read=GetInfoBool, write=SetInfoBool, stored=false, index=3, nodefault};
	__property bool WarningBeep = {read=GetInfoBool, write=SetInfoBool, stored=false, index=4, nodefault};
	__property bool ScreenSaveActive = {read=GetInfoBool, write=SetInfoBool, stored=false, index=5, nodefault};
	__property bool FontSmoothing = {read=GetInfoBool, write=SetInfoBool, stored=false, index=6, nodefault};
	__property bool DragFullWindows = {read=GetInfoBool, write=SetInfoBool, stored=false, index=7, nodefault};
	__property bool SnapToDefaultButton = {read=GetInfoBool, write=SetInfoBool, stored=false, index=8, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSINFO)
using namespace Lmdsysinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysinfoHPP
