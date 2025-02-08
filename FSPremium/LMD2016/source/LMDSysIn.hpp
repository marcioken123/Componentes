// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysIn.pas' rev: 34.00 (Windows)

#ifndef LmdsysinHPP
#define LmdsysinHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysin
{
//-- forward type declarations -----------------------------------------------
struct TOSVERSIONINFOEX;
struct TLMDDriveInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDInfoType : unsigned char { itUser, itWinDir, itCurrentDir32, itCurrentDiskFree32, itCurrentDiskSize32, itSystemDir, itReg_Owner32, itReg_Company32, itVersion, itColorDepth, itScreenSaverDelay, itMemSize, itFreeSysRes, itFreeGDIRes, itFreeUserRes, itComputerName32, itMajorVerNr32, itBuildNr32, itMemLoaded32, itMemFree32, itMemPageFree32, itMemPageTotal32, itMemVirtFree32, itMemVirtTotal32, itPlatformID32, itPlatform32, itProcessorCont32, itProcessor32, itTempPath32, itDOSVersion, itNumLock, itCapsLock, itScroll, itCurrentDateTime, itProgCompany, itProgName, itProgVersion, itFileVersion, itFileVersionFull, itFileVersionBuild, itProgCopyright, itProgTrademark, itProgDescription, itProgComments, itCPUSpeed, itTimeElapsedSinceBoot, 
	itLastBootTime };

enum DECLSPEC_DENUM TLMDVersionInfoType : unsigned char { viCompany, viName, viVersion, viCopyright, viTrademark, viDescription, viComments, viFileVersion, viFileVersionFull, viFileVersionBuild };

#pragma pack(push,1)
struct DECLSPEC_DRECORD TOSVERSIONINFOEX
{
public:
	unsigned dwOSVersionInfoSize;
	unsigned dwMajorVersion;
	unsigned dwMinorVersion;
	unsigned dwBuildNumber;
	unsigned dwPlatformId;
	System::StaticArray<System::WideChar, 128> szCSDVersion;
	System::Word wServicePackMajor;
	System::Word wServicePackMinor;
	System::Word wSuiteMask;
	System::Byte wProductType;
	System::Byte wReserved;
};
#pragma pack(pop)


typedef _OSVERSIONINFOW *POSVersionInfo;

enum DECLSPEC_DENUM TLMDSysPlatform : unsigned char { pfWin95, pfWin98, pfWinME, pfWinNT, pfWin2K, pfWinXP, pfWin2003Server, pfWinVista, pfWin2008server, pfWin7, pfWin2008R2Server, pfWin8, pfWin2012Server, pfWin81, pfWin2012R2Server, pfWin10, pfWin2016Server };

struct DECLSPEC_DRECORD TLMDDriveInfo
{
public:
	unsigned ditype;
	__int64 diTotalSpace;
	__int64 diFreeSpace;
	unsigned diSectorsPerCluster;
	unsigned diBytesPerSector;
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 NC_ADJUSTRIGHT = System::Int8(0x1);
static const System::Int8 NC_ADJUSTLEFT = System::Int8(0x2);
static const System::Int8 NC_SMALLCAPTION = System::Int8(0x4);
static const System::Int8 NC_HASICON = System::Int8(0x8);
static const System::Int8 NC_ISICONIC = System::Int8(0x10);
static const System::Int8 NC_SINGLEBORDER = System::Int8(0x20);
extern DELPHI_PACKAGE bool LMDSIWindows95;
extern DELPHI_PACKAGE bool LMDSIWindows98;
extern DELPHI_PACKAGE bool LMDSIWindowsNT;
extern DELPHI_PACKAGE bool LMDSIWindows2000;
extern DELPHI_PACKAGE bool LMDSIWindows2000AdvancedServer;
extern DELPHI_PACKAGE bool LMDSIWindowsME;
extern DELPHI_PACKAGE bool LMDSIWindowsXP;
extern DELPHI_PACKAGE bool LMDSIWindowsXPHome;
extern DELPHI_PACKAGE bool LMDSIWindowsXPProf;
extern DELPHI_PACKAGE bool LMDSINETServer;
extern DELPHI_PACKAGE bool LMDSIWindowsExtension;
extern DELPHI_PACKAGE bool LMDSIWindowsXPServer;
extern DELPHI_PACKAGE bool LMDSIWindowsVista;
extern DELPHI_PACKAGE bool LMDSIWindows7;
extern DELPHI_PACKAGE bool LMDSIWindows8;
extern DELPHI_PACKAGE bool LMDSIWindows81;
extern DELPHI_PACKAGE bool LMDSIWindows10;
extern DELPHI_PACKAGE bool LMDSIWindowsXPTabletEdition;
extern DELPHI_PACKAGE bool LMDSIWindowXPMediaCenterEdition;
extern DELPHI_PACKAGE bool LMDSIWindowsNTUp;
extern DELPHI_PACKAGE bool LMDSIWindows2000Up;
extern DELPHI_PACKAGE bool LMDSIWindowsXPUp;
extern DELPHI_PACKAGE bool LMDSIWindowsXPSP2;
extern DELPHI_PACKAGE bool LMDSIWindowsXPSP3;
extern DELPHI_PACKAGE bool LMDSIWindowsXPSP2Up;
extern DELPHI_PACKAGE bool LMDSIWindows2003Up;
extern DELPHI_PACKAGE bool LMDSIWindowsVistaUp;
extern DELPHI_PACKAGE bool LMDSIWindowsWindows7Up;
extern DELPHI_PACKAGE bool LMDSIWindowsWindows8Up;
extern DELPHI_PACKAGE bool LMDSIUnicodeDelphi;
extern DELPHI_PACKAGE TLMDSysPlatform LMDSysPlatform;
extern DELPHI_PACKAGE void __fastcall LMDPlatformNotImplemented(void);
extern DELPHI_PACKAGE void __fastcall LMDNCCalcDrawingArea(HWND Handle, System::Types::TRect &dRecT, System::Types::TRect &rText, System::Word &sflag);
extern DELPHI_PACKAGE int __fastcall LMDNCBITMAPHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCBITMAPWIDTH(void);
extern DELPHI_PACKAGE int __fastcall LMDNCCAPTIONHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCDLGBORDERWIDTH(void);
extern DELPHI_PACKAGE int __fastcall LMDNCDLGBORDERHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCFIXBORDERWIDTH(void);
extern DELPHI_PACKAGE int __fastcall LMDNCFIXBORDERHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCSIZEBORDERWIDTH(void);
extern DELPHI_PACKAGE int __fastcall LMDNCSIZEBORDERHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCBORDERWIDTH(void);
extern DELPHI_PACKAGE int __fastcall LMDNCBORDERHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCSMALLCAPTIONHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCSMALLBITMAPHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCSMALLBITMAPWIDTH(void);
extern DELPHI_PACKAGE int __fastcall LMDNCCAPTIONICONHEIGHT(void);
extern DELPHI_PACKAGE int __fastcall LMDNCCAPTIONICONWIDTH(void);
extern DELPHI_PACKAGE bool __fastcall LMDSIStretchBltPossible(void);
extern DELPHI_PACKAGE bool __fastcall LMDSIFontSmoothing(void);
extern DELPHI_PACKAGE System::Byte __fastcall LMDSIColorDepth(void);
extern DELPHI_PACKAGE int __fastcall LMDSIScreenSaverDelay(void);
extern DELPHI_PACKAGE bool __fastcall LMDSINumLock(void);
extern DELPHI_PACKAGE bool __fastcall LMDSICapsLock(void);
extern DELPHI_PACKAGE bool __fastcall LMDSIScrollLock(void);
extern DELPHI_PACKAGE bool __fastcall LMDGetOSVersionInfoEx(TOSVERSIONINFOEX &AVerInfo);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIMajorVersionNr(void);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIMinorVersionNr(void);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIProductType(void);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIVIPlatformID(void);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIBuildNr(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIVersionString(void);
extern DELPHI_PACKAGE System::Byte __fastcall LMDSIMemLoaded(void);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIMemTotal(void);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIMemFree(void);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIMemPageFree(void);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIMemPageTotal(void);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIMemVirtFree(void);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIMemVirtExtended(void);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIMemVirtTotal(void);
extern DELPHI_PACKAGE bool __fastcall LMDSIOLDWindowsNT(void);
extern DELPHI_PACKAGE unsigned __fastcall LMDSIPlatformID(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIPlatformStr(void);
extern DELPHI_PACKAGE System::Byte __fastcall LMDSIProcessorCount(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIProcessorTypeStr(void);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIFreeSysRes(void);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIFreeGDIRes(void);
extern DELPHI_PACKAGE System::Word __fastcall LMDSIFreeUserRes(void);
extern DELPHI_PACKAGE TLMDDriveInfo __fastcall LMDSIDriveInfo(const System::UnicodeString aDrive);
extern DELPHI_PACKAGE void __fastcall LMDSIDriveList(System::Classes::TStringList* aList);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIDriveTypeStr(unsigned aType);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSITempPath(void);
extern DELPHI_PACKAGE void __fastcall LMDSIEnvironment(System::Classes::TStringList* aList);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIWindowsDirectory(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSISystemDirectory(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSITempFile(const System::UnicodeString prefix = L"tmp");
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIRegisteredCompany(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIRegisteredOwner(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIVersionStr(void);
extern DELPHI_PACKAGE System::Extended __fastcall LMDSIVersionNr(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIComputerName(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIUserName(void);
extern DELPHI_PACKAGE int __fastcall LMDSISystemDefaultLanguageID(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSILanguageNameFromID(int AID);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSISystemDefaultLanguageName(void);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIGetTimeZone(void);
extern DELPHI_PACKAGE int __fastcall LMDSIGetTimeZoneBias(void);
extern DELPHI_PACKAGE int __fastcall LMDSIIconHeight(void);
extern DELPHI_PACKAGE int __fastcall LMDSIIconWidth(void);
extern DELPHI_PACKAGE int __fastcall LMDSISmallIconHeight(void);
extern DELPHI_PACKAGE int __fastcall LMDSISmallIconWidth(void);
extern DELPHI_PACKAGE int __fastcall LMDSIDPIAwareIconSize(void);
extern DELPHI_PACKAGE int __fastcall LMDSIDPIAwareSmallIconSize(void);
extern DELPHI_PACKAGE int __fastcall LMDSILogPixelsX(void);
extern DELPHI_PACKAGE unsigned __fastcall LMDSISystemIconListHandle(bool aLarge);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIVersionInfo(TLMDVersionInfoType inf);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetSystemInfoString(TLMDInfoType inf, int DevideBy, System::UnicodeString DateTimeFormat);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSIInfoToString(TLMDInfoType aValue);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDGetLocalInfo(int index);
extern DELPHI_PACKAGE __int64 __fastcall LMDSIRdtsc(void);
extern DELPHI_PACKAGE double __fastcall LMDSIGetCPUSpeed(void);
extern DELPHI_PACKAGE double __fastcall LMDSITimeElapsedSinceBoot(void);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDSILastBootTime(void);
}	/* namespace Lmdsysin */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSIN)
using namespace Lmdsysin;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysinHPP
