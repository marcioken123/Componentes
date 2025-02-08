// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysWindowsObject.pas' rev: 31.00 (Windows)

#ifndef LmdsyswindowsobjectHPP
#define LmdsyswindowsobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyswindowsobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysWindowsObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysWindowsDisplayInfo : unsigned char { wdiRegisteredOwner, wdiRegisteredCompany, wdiProductID, wdiProductName, wdiProductFullName, wdiPProductType, wdiPlatformID, wdiProductSuite, wdiMajorVersion, wdiMinorVersion, wdiBuildNumber, wdiVersionName, wdiCSDVersion, wdiServicePackMajor, wdiServicePackMinor, wdiInstallDate, wdiLastBoot, wdiUpTimeString, wdiSystemFolders, wdiEnvironment, wdiTempDir, wdiSysDir, wdiWinDir };

typedef System::Set<TLMDSysWindowsDisplayInfo, TLMDSysWindowsDisplayInfo::wdiRegisteredOwner, TLMDSysWindowsDisplayInfo::wdiWinDir> TLMDSysWindowsDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 23> Lmdsyswindowsobject__1;

class PASCALIMPLEMENTATION TLMDSysWindowsObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::UnicodeString FCSDVersion;
	System::UnicodeString FProductID;
	System::UnicodeString FWinDir;
	System::UnicodeString FWinSysDir;
	System::UnicodeString FProductName;
	System::UnicodeString FVersion;
	System::UnicodeString FRegisteredCompany;
	System::UnicodeString FRegisteredOwner;
	unsigned FBuildNumber;
	unsigned FPlatformID;
	unsigned FMajorVersion;
	unsigned FMinorVersion;
	unsigned FServiceMajor;
	unsigned FServiceMinor;
	System::TDateTime FInstallDate;
	System::TDateTime FLastBoot;
	System::Classes::TStringList* FSystemFolders;
	System::Classes::TStringList* FEnvironment;
	Lmdsysbase::TLMDSysProductType FProductTypeID;
	Lmdsysbase::TLMDSysProductSuites FProductSuite;
	System::UnicodeString FProductExtName;
	TLMDSysWindowsDisplayInfos FDisplayInfo;
	void __fastcall DummyStrings(System::Classes::TStrings* AList);
	void __fastcall SetDummyString(System::UnicodeString aValue);
	void __fastcall SetDummyCardinal(unsigned aValue);
	void __fastcall SetDummyDateTime(const System::TDateTime Value);
	void __fastcall SetDummyType(const Lmdsysbase::TLMDSysProductSuites Value);
	void __fastcall SetDisplayInfo(const TLMDSysWindowsDisplayInfos Value);
	System::UnicodeString __fastcall GetProductType(void);
	System::Classes::TStrings* __fastcall GetEnvironment(void);
	System::Classes::TStrings* __fastcall GetSystemFolders(void);
	double __fastcall GetUpTime(void);
	System::UnicodeString __fastcall GetTempDir(void);
	System::UnicodeString __fastcall GetUptimeString(void);
	System::UnicodeString __fastcall GetSuiteString(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysWindowsObject(void);
	__fastcall virtual ~TLMDSysWindowsObject(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property double UpTime = {read=GetUpTime};
	__property Lmdsysbase::TLMDSysProductType ProductTypeID = {read=FProductTypeID, nodefault};
	
__published:
	__property System::UnicodeString RegisteredOwner = {read=FRegisteredOwner, write=SetDummyString, stored=false};
	__property System::UnicodeString RegisteredCompany = {read=FRegisteredCompany, write=SetDummyString, stored=false};
	__property System::UnicodeString ProductName = {read=FProductName, write=SetDummyString, stored=false};
	__property System::UnicodeString ProductID = {read=FProductID, write=SetDummyString, stored=false};
	__property System::UnicodeString CSDVersion = {read=FCSDVersion, write=SetDummyString, stored=false};
	__property unsigned PlatformID = {read=FPlatformID, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned BuildNumber = {read=FBuildNumber, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned MajorVersion = {read=FMajorVersion, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned MinorVersion = {read=FMinorVersion, write=SetDummyCardinal, stored=false, nodefault};
	__property Lmdsysbase::TLMDSysProductSuites ProductSuite = {read=FProductSuite, write=SetDummyType, stored=false, nodefault};
	__property System::Classes::TStrings* Environment = {read=GetEnvironment, write=DummyStrings, stored=false};
	__property System::Classes::TStrings* SystemFolders = {read=GetSystemFolders, write=DummyStrings, stored=false};
	__property System::TDateTime LastBoot = {read=FLastBoot, write=SetDummyDateTime, stored=false};
	__property System::TDateTime InstallDate = {read=FInstallDate, write=SetDummyDateTime, stored=false};
	__property System::UnicodeString WindowsDir = {read=FWinDir, write=SetDummyString, stored=false};
	__property System::UnicodeString SystemDir = {read=FWinSysDir, write=SetDummyString, stored=false};
	__property unsigned ServicePackMajor = {read=FServiceMajor, write=SetDummyCardinal, stored=false, nodefault};
	__property unsigned ServicePackMinor = {read=FServiceMinor, write=SetDummyCardinal, stored=false, nodefault};
	__property System::UnicodeString VersionName = {read=FVersion, write=SetDummyString, stored=false};
	__property System::UnicodeString ProductType = {read=GetProductType, write=SetDummyString, stored=false};
	__property System::UnicodeString ProductFullName = {read=FProductExtName, write=SetDummyString, stored=false};
	__property System::UnicodeString TempDir = {read=GetTempDir, write=SetDummyString, stored=false};
	__property System::UnicodeString UpTimeString = {read=GetUptimeString, write=SetDummyString, stored=false};
	__property TLMDSysWindowsDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=8388607};
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysWindowsDisplayInfos (System::Set<TLMDSysWindowsDisplayInfo, TLMDSysWindowsDisplayInfo::wdiRegisteredOwner, TLMDSysWindowsDisplayInfo::wdiWinDir>() << TLMDSysWindowsDisplayInfo::wdiRegisteredOwner << TLMDSysWindowsDisplayInfo::wdiRegisteredCompany << TLMDSysWindowsDisplayInfo::wdiProductID << TLMDSysWindowsDisplayInfo::wdiProductName << TLMDSysWindowsDisplayInfo::wdiProductFullName << TLMDSysWindowsDisplayInfo::wdiPProductType << TLMDSysWindowsDisplayInfo::wdiPlatformID << TLMDSysWindowsDisplayInfo::wdiProductSuite << TLMDSysWindowsDisplayInfo::wdiMajorVersion << TLMDSysWindowsDisplayInfo::wdiMinorVersion << TLMDSysWindowsDisplayInfo::wdiBuildNumber << TLMDSysWindowsDisplayInfo::wdiVersionName << TLMDSysWindowsDisplayInfo::wdiCSDVersion \
	<< TLMDSysWindowsDisplayInfo::wdiServicePackMajor << TLMDSysWindowsDisplayInfo::wdiServicePackMinor << TLMDSysWindowsDisplayInfo::wdiInstallDate << TLMDSysWindowsDisplayInfo::wdiLastBoot << TLMDSysWindowsDisplayInfo::wdiUpTimeString << TLMDSysWindowsDisplayInfo::wdiSystemFolders << TLMDSysWindowsDisplayInfo::wdiEnvironment << TLMDSysWindowsDisplayInfo::wdiTempDir << TLMDSysWindowsDisplayInfo::wdiSysDir << TLMDSysWindowsDisplayInfo::wdiWinDir )
extern DELPHI_PACKAGE Lmdsyswindowsobject__1 LMDSysWindowsProps;
}	/* namespace Lmdsyswindowsobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSWINDOWSOBJECT)
using namespace Lmdsyswindowsobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyswindowsobjectHPP
