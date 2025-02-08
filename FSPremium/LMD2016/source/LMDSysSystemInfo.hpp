// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysSystemInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsyssysteminfoHPP
#define LmdsyssysteminfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysPowerStatusObject.hpp>
#include <LMDSysLocaleObject.hpp>
#include <LMDSysTimeZoneObject.hpp>
#include <LMDSysMemoryObject.hpp>
#include <LMDSysMouseObject.hpp>
#include <LMDSysKeyboardObject.hpp>
#include <LMDSysWindowsObject.hpp>
#include <LMDSysDisplayObject.hpp>
#include <LMDSysProcessorObject.hpp>
#include <LMDSysPrinterInfo.hpp>
#include <LMDSysUninstallInfo.hpp>
#include <LMDSysFontInfo.hpp>
#include <LMDSysMultimediaObject.hpp>
#include <LMDSysInternetObject.hpp>
#include <LMDSysFileAssocInfo.hpp>
#include <LMDSysModemInfo.hpp>
#include <LMDSysDriveObject.hpp>
#include <LMDSysNetworkObject.hpp>
#include <LMDSysDriveInfo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyssysteminfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysSystemInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysSystemInfoDisplayInfo : unsigned char { doDisplay, doMouse, doDrives, doPrinters, doWindows, doKeyboard, doMemoryInfo, doProcessor, doSystemPowerStatus, doTimeZone, doLocale, doUninstallInfo, doFontsInfo, doMultimedia, doFileAssoc, doInternet, doModems, doNetwork };

typedef System::Set<TLMDSysSystemInfoDisplayInfo, TLMDSysSystemInfoDisplayInfo::doDisplay, TLMDSysSystemInfoDisplayInfo::doNetwork> TLMDSysSystemInfoDisplayInfos;

class PASCALIMPLEMENTATION TLMDSysSystemInfo : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsyspowerstatusobject::TLMDSysPowerStatusObject* FSystemPowerStatus;
	Lmdsystimezoneobject::TLMDSysTimeZoneObject* FTimeZone;
	Lmdsyslocaleobject::TLMDSysLocaleObject* FLocale;
	Lmdsysmemoryobject::TLMDSysMemoryObject* FMemoryInfo;
	Lmdsyskeyboardobject::TLMDSysKeyboardObject* FKeyboard;
	Lmdsysmouseobject::TLMDSysMouseObject* FMouse;
	Lmdsysdisplayobject::TLMDSysDisplayObject* FDisplay;
	Lmdsysprinterinfo::TLMDPrintersInfo* FPrinters;
	Lmdsyswindowsobject::TLMDSysWindowsObject* FWindows;
	Lmdsysdriveinfo::TLMDSysDrivesInfo* FDrives;
	Lmdsysprocessorobject::TLMDSysProcessorObject* FProcessor;
	Lmdsysuninstallinfo::TLMDUninstallInfo* FUninstallInfo;
	Lmdsysfontinfo::TLMDFontsInfo* FFontsInfo;
	Lmdsysmultimediaobject::TLMDSysMultimediaObject* FMultimedia;
	Lmdsysfileassocinfo::TLMDFileAssocsInfo* FFileAssoc;
	Lmdsysinternetobject::TLMDSysInternetObject* FInternet;
	Lmdsysmodeminfo::TLMDModemInfo* FModems;
	Lmdsysnetworkobject::TLMDSysNetworkObject* FNetwork;
	TLMDSysSystemInfoDisplayInfos FDisplayOptions;
	Lmdsysprinterinfo::TLMDSysPrinterDisplayInfos FDisplayInfo;
	Lmdsysmodeminfo::TLMDSysModemDisplayInfos FModemDisplayInfo;
	void __fastcall SetDisplayOptions(const TLMDSysSystemInfoDisplayInfos value);
	void __fastcall SetDummySPS(Lmdsyspowerstatusobject::TLMDSysPowerStatusObject* aValue);
	void __fastcall SetDummyTimeZone(Lmdsystimezoneobject::TLMDSysTimeZoneObject* aValue);
	void __fastcall SetDummyLocale(Lmdsyslocaleobject::TLMDSysLocaleObject* aValue);
	void __fastcall SetDummyMemInfo(Lmdsysmemoryobject::TLMDSysMemoryObject* aValue);
	void __fastcall SetDummyKeyboardInfo(Lmdsyskeyboardobject::TLMDSysKeyboardObject* aValue);
	void __fastcall SetDummyMouseInfo(Lmdsysmouseobject::TLMDSysMouseObject* aValue);
	void __fastcall SetDummyDisplayInfo(Lmdsysdisplayobject::TLMDSysDisplayObject* aValue);
	void __fastcall SetDummyPrintersInfo(Lmdsysprinterinfo::TLMDPrintersInfo* aValue);
	void __fastcall SetDummyWindowsInfo(Lmdsyswindowsobject::TLMDSysWindowsObject* aValue);
	void __fastcall SetDummyDrives(Lmdsysdriveinfo::TLMDSysDrivesInfo* aValue);
	void __fastcall SetDummyProcessor(Lmdsysprocessorobject::TLMDSysProcessorObject* const Value);
	void __fastcall SetDummyUninstallInfo(Lmdsysuninstallinfo::TLMDUninstallInfo* const Value);
	void __fastcall SetDummyFontsInfo(Lmdsysfontinfo::TLMDFontsInfo* const Value);
	void __fastcall SetDummyMultimedia(Lmdsysmultimediaobject::TLMDSysMultimediaObject* const Value);
	void __fastcall SetDummyFileAssoc(Lmdsysfileassocinfo::TLMDFileAssocsInfo* const Value);
	void __fastcall SetDummyInternet(Lmdsysinternetobject::TLMDSysInternetObject* const Value);
	void __fastcall SetDummyModems(Lmdsysmodeminfo::TLMDModemInfo* const Value);
	void __fastcall SetDummyNetwork(Lmdsysnetworkobject::TLMDSysNetworkObject* const Value);
	void __fastcall SetDisplayInfo(const Lmdsysprinterinfo::TLMDSysPrinterDisplayInfos Value);
	void __fastcall SetModemDisplayInfo(const Lmdsysmodeminfo::TLMDSysModemDisplayInfos Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysSystemInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysSystemInfo(void);
	virtual void __fastcall Loaded(void);
	virtual int __fastcall GetElementCount(void);
	virtual System::TObject* __fastcall GetElement(int index);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TLMDSysSystemInfoDisplayInfos DisplayInfo = {read=FDisplayOptions, write=SetDisplayOptions, default=262143};
	__property Lmdsyspowerstatusobject::TLMDSysPowerStatusObject* SystemPowerStatus = {read=FSystemPowerStatus, write=SetDummySPS};
	__property Lmdsystimezoneobject::TLMDSysTimeZoneObject* TimeZone = {read=FTimeZone, write=SetDummyTimeZone};
	__property Lmdsyslocaleobject::TLMDSysLocaleObject* LocaleSettings = {read=FLocale, write=SetDummyLocale};
	__property Lmdsysmemoryobject::TLMDSysMemoryObject* Memory = {read=FMemoryInfo, write=SetDummyMemInfo};
	__property Lmdsyskeyboardobject::TLMDSysKeyboardObject* Keyboard = {read=FKeyboard, write=SetDummyKeyboardInfo};
	__property Lmdsysmouseobject::TLMDSysMouseObject* Mouse = {read=FMouse, write=SetDummyMouseInfo};
	__property Lmdsysdisplayobject::TLMDSysDisplayObject* Display = {read=FDisplay, write=SetDummyDisplayInfo};
	__property Lmdsysprinterinfo::TLMDPrintersInfo* Printers = {read=FPrinters, write=SetDummyPrintersInfo, stored=false};
	__property Lmdsysprinterinfo::TLMDSysPrinterDisplayInfos PrintersDisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=536870911};
	__property Lmdsyswindowsobject::TLMDSysWindowsObject* Windows = {read=FWindows, write=SetDummyWindowsInfo};
	__property Lmdsysdriveinfo::TLMDSysDrivesInfo* Drives = {read=FDrives, write=SetDummyDrives, stored=false};
	__property Lmdsysprocessorobject::TLMDSysProcessorObject* Processor = {read=FProcessor, write=SetDummyProcessor};
	__property Lmdsysuninstallinfo::TLMDUninstallInfo* UninstallInfo = {read=FUninstallInfo, write=SetDummyUninstallInfo, stored=false};
	__property Lmdsysfontinfo::TLMDFontsInfo* FontsInfo = {read=FFontsInfo, write=SetDummyFontsInfo, stored=false};
	__property Lmdsysmultimediaobject::TLMDSysMultimediaObject* Multimedia = {read=FMultimedia, write=SetDummyMultimedia, stored=false};
	__property Lmdsysfileassocinfo::TLMDFileAssocsInfo* FileAssoc = {read=FFileAssoc, write=SetDummyFileAssoc, stored=false};
	__property Lmdsysinternetobject::TLMDSysInternetObject* Internet = {read=FInternet, write=SetDummyInternet};
	__property Lmdsysmodeminfo::TLMDModemInfo* Modems = {read=FModems, write=SetDummyModems, stored=false};
	__property Lmdsysmodeminfo::TLMDSysModemDisplayInfos ModemsDisplayInfo = {read=FModemDisplayInfo, write=SetModemDisplayInfo, default=15};
	__property Lmdsysnetworkobject::TLMDSysNetworkObject* Network = {read=FNetwork, write=SetDummyNetwork};
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysSystemInfoDisplayInfos (System::Set<TLMDSysSystemInfoDisplayInfo, TLMDSysSystemInfoDisplayInfo::doDisplay, TLMDSysSystemInfoDisplayInfo::doNetwork>() << TLMDSysSystemInfoDisplayInfo::doDisplay << TLMDSysSystemInfoDisplayInfo::doMouse << TLMDSysSystemInfoDisplayInfo::doDrives << TLMDSysSystemInfoDisplayInfo::doPrinters << TLMDSysSystemInfoDisplayInfo::doWindows << TLMDSysSystemInfoDisplayInfo::doKeyboard << TLMDSysSystemInfoDisplayInfo::doMemoryInfo << TLMDSysSystemInfoDisplayInfo::doProcessor << TLMDSysSystemInfoDisplayInfo::doSystemPowerStatus << TLMDSysSystemInfoDisplayInfo::doTimeZone << TLMDSysSystemInfoDisplayInfo::doLocale << TLMDSysSystemInfoDisplayInfo::doUninstallInfo << TLMDSysSystemInfoDisplayInfo::doFontsInfo << TLMDSysSystemInfoDisplayInfo::doMultimedia \
	<< TLMDSysSystemInfoDisplayInfo::doFileAssoc << TLMDSysSystemInfoDisplayInfo::doInternet << TLMDSysSystemInfoDisplayInfo::doModems << TLMDSysSystemInfoDisplayInfo::doNetwork )
}	/* namespace Lmdsyssysteminfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSSYSTEMINFO)
using namespace Lmdsyssysteminfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyssysteminfoHPP
