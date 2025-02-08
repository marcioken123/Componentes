// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysBase.pas' rev: 31.00 (Windows)

#ifndef LmdsysbaseHPP
#define LmdsysbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDSysConst.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysbase
{
//-- forward type declarations -----------------------------------------------
struct TLMDSysProperty;
class DELPHICLASS TLMDSysComponent;
__interface ILMDSysContainer;
typedef System::DelphiInterface<ILMDSysContainer> _di_ILMDSysContainer;
__interface ILMDSysDescriptor;
typedef System::DelphiInterface<ILMDSysDescriptor> _di_ILMDSysDescriptor;
__interface ILMDSysPublisher;
typedef System::DelphiInterface<ILMDSysPublisher> _di_ILMDSysPublisher;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysProductType : unsigned char { sptUnknown, sptWorkStation, sptServer, sptDomainController };

enum DECLSPEC_DENUM TLMDSysProductSuite : unsigned char { spsSmallBusiness, spsEnterprise, spsBackOffice, spsCommunications, spsTerminal, spsSmallBusinessRestricted, spsEmbeddedNT, spsDataCenter, spsSingleUserTS, spsPersonal, spsWebEdition, spsEmbeddedRestricted };

typedef System::Set<TLMDSysProductSuite, TLMDSysProductSuite::spsSmallBusiness, TLMDSysProductSuite::spsEmbeddedRestricted> TLMDSysProductSuites;

struct DECLSPEC_DRECORD TLMDSysProperty
{
public:
	System::UnicodeString Name;
	System::UnicodeString Description;
};


typedef System::StaticArray<System::UnicodeString, 4> Lmdsysbase__1;

enum DECLSPEC_DENUM TLMDSysDirection : unsigned char { sdAscending, sdDescending };

class PASCALIMPLEMENTATION TLMDSysComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDSysComponent(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDSysComponent(void) { }
	
};


__interface  INTERFACE_UUID("{D8DECF0C-3DE0-4E44-AD38-F022380E2970}") ILMDSysContainer  : public System::IInterface 
{
	virtual int __fastcall GetElementCount(void) = 0 ;
	virtual System::TObject* __fastcall GetElement(int index) = 0 ;
};

enum DECLSPEC_DENUM TLMDSysInfoType : unsigned char { itUnknown, itSystemInfoGroup, itDisplayGroup, itDisplayMode, itDisplayModes, itDisplayPlus, itDisplayWallpaper, itDisplayScreenSaver, itMouse, itDriveGroup, itFloppyDrive, itFixedDrive, itCDROMDrive, itPrinterGroup, itPrinter, itWindows, itKeyboard, itMemory, itProcessor, itPowerStatus, itTimeZone, itLocale, itUninstallGroup, itUninstallItem, itFontGroup, itFont, itMultimediaGroup, itJoystickGroup, itJoystick, itMidiOutAudioGroup, itMIDIiOutAudio, itMidiInAudioGroup, itMIDIiInAudio, itwaveOutAudioGroup, itwaveOutAudio, itwaveInAudioGroup, itwaveInAudio, itDauxAudioGroup, itDauxAudio, itMixerGroup, itMixer, itFileActionGroup, itFileAction, itFileAssocGroup, itFileAssoc, itInetAdvPropGroup, itInetAdvProp, 
	itInetZoneGroup, itInetZone, itTempInternetFiles, itInternet, itModemGroup, itModem, itTCPIP, itIPX, itNetBEUI, itNetwork, itNetworkCard, itNetworkCardGroup, itDriver, itService, itServiceGroup };

__interface  INTERFACE_UUID("{059155C7-51D6-4EAF-8795-76F40E6AABD3}") ILMDSysDescriptor  : public System::IInterface 
{
	virtual TLMDSysInfoType __fastcall GetElementType(void) = 0 ;
	virtual System::UnicodeString __fastcall GetElementTitle(void) = 0 ;
	virtual System::UnicodeString __fastcall GetElementDescription(void) = 0 ;
};

enum DECLSPEC_DENUM TLMDSysPropertyType : unsigned char { ptUnknown };

__interface  INTERFACE_UUID("{0E5B3D50-3B18-450A-BF9B-8595BE330FC8}") ILMDSysPublisher  : public System::IInterface 
{
	virtual int __fastcall GetPropertiesCount(void) = 0 ;
	virtual bool __fastcall GetPropAvailability(int index) = 0 ;
	virtual TLMDSysPropertyType __fastcall GetPropType(int index) = 0 ;
	virtual System::Variant __fastcall GetPropValue(int index) = 0 ;
	virtual System::UnicodeString __fastcall GetPropText(int index) = 0 ;
	virtual System::UnicodeString __fastcall GetPropTitle(int index) = 0 ;
	virtual System::UnicodeString __fastcall GetPropDescription(int index) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
static const System::Word LMDMinutesPerDay = System::Word(0x5a0);
extern DELPHI_PACKAGE Lmdsysbase__1 sLMDSysProductType;
extern DELPHI_PACKAGE GUID IID_ILMDSysContainer;
extern DELPHI_PACKAGE GUID IID_ILMDSysDescriptor;
extern DELPHI_PACKAGE GUID IID_ILMDSysPublisher;
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDSysUnixTimeToDateTime(unsigned aTime);
}	/* namespace Lmdsysbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSBASE)
using namespace Lmdsysbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysbaseHPP
