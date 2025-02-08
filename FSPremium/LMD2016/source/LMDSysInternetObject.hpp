// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysInternetObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysinternetobjectHPP
#define LmdsysinternetobjectHPP

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

namespace Lmdsysinternetobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysInetAdvProp;
class DELPHICLASS TLMDSysInetAdvProps;
class DELPHICLASS TLMDSysInetZone;
class DELPHICLASS TLMDSysInetZones;
class DELPHICLASS TLMDSysInternetObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysInternetDisplayInfo : unsigned char { ipidInetBrowser, ipidInetHomePage, ipidInetHTMLEditor, ipidInetEMailClient, ipidInetNewsClient, ipidInetCalendar, ipidInetInetCall, ipidInetContacts, ipidInetTempPath, ipidInetTempMaxSize, ipidInetZones, ipidInetAdvancedProperties };

typedef System::Set<TLMDSysInternetDisplayInfo, TLMDSysInternetDisplayInfo::ipidInetBrowser, TLMDSysInternetDisplayInfo::ipidInetAdvancedProperties> TLMDSysInternetDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 12> Lmdsysinternetobject__1;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysInetAdvProp : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	bool FValue;
	System::UnicodeString FName;
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetDummyBool(const bool Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetDummyString, stored=false};
	__property bool Value = {read=FValue, write=SetDummyBool, stored=false, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDSysInetAdvProp(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDSysInetAdvProp(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSysInetAdvProps : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
private:
	HIDESBASE TLMDSysInetAdvProp* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSysInetAdvProp* const Value);
	
public:
	__fastcall TLMDSysInetAdvProps(void);
	HIDESBASE TLMDSysInetAdvProp* __fastcall Add(void);
	HIDESBASE TLMDSysInetAdvProp* __fastcall Insert(int Index);
	__property TLMDSysInetAdvProp* Items[int Index] = {read=GetItem, write=SetItem};
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDSysInetAdvProps(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysInetZone : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::UnicodeString FZoneName;
	System::UnicodeString FZoneDescription;
	System::Classes::TStrings* FZoneSites;
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetDummyStrings(System::Classes::TStrings* const Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysInetZone(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSysInetZone(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString ZoneName = {read=FZoneName, write=SetDummyString, stored=false};
	__property System::UnicodeString ZoneDescription = {read=FZoneDescription, write=SetDummyString, stored=false};
	__property System::Classes::TStrings* ZoneSites = {read=FZoneSites, write=SetDummyStrings, stored=false};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSysInetZones : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDSysInetZone* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDSysInetZone* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSysInetZone* const Value);
	
public:
	__fastcall TLMDSysInetZones(void);
	HIDESBASE TLMDSysInetZone* __fastcall Add(void);
	HIDESBASE TLMDSysInetZone* __fastcall Insert(int Index);
	__property TLMDSysInetZone* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDSysInetZones(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSysInternetObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::UnicodeString FHomePage;
	TLMDSysInetZones* FZones;
	TLMDSysInetAdvProps* FAdvancedOptions;
	System::UnicodeString FBrowser;
	System::UnicodeString FInetCall;
	System::UnicodeString FCalendar;
	System::UnicodeString FHTMLEditor;
	System::UnicodeString FEMailClient;
	System::UnicodeString FNewsClient;
	System::UnicodeString FContacts;
	TLMDSysInternetDisplayInfos FDisplayInfo;
	System::UnicodeString FPath;
	int FMaxSize;
	void __fastcall SetDummyZones(TLMDSysInetZones* const Value);
	void __fastcall SetDummayAdvOpt(TLMDSysInetAdvProps* const Value);
	void __fastcall SetDisplayInfo(const TLMDSysInternetDisplayInfos Value);
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetDummyInt(const int Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	__fastcall virtual TLMDSysInternetObject(void);
	__fastcall virtual ~TLMDSysInternetObject(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	int __fastcall GetElementCount(void);
	System::TObject* __fastcall GetElement(int index);
	__property TLMDSysInetAdvProps* AdvancedOptions = {read=FAdvancedOptions, write=SetDummayAdvOpt, stored=false};
	__property TLMDSysInetZones* Zones = {read=FZones, write=SetDummyZones, stored=false};
	
__published:
	__property System::UnicodeString Browser = {read=FBrowser, write=SetDummyString, stored=false};
	__property TLMDSysInternetDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=4095};
	__property System::UnicodeString HomePage = {read=FHomePage, write=SetDummyString, stored=false};
	__property System::UnicodeString HTMLEditor = {read=FHTMLEditor, write=SetDummyString, stored=false};
	__property System::UnicodeString EMailClient = {read=FEMailClient, write=SetDummyString, stored=false};
	__property System::UnicodeString NewsClient = {read=FNewsClient, write=SetDummyString, stored=false};
	__property System::UnicodeString Calendar = {read=FCalendar, write=SetDummyString, stored=false};
	__property System::UnicodeString InetCall = {read=FInetCall, write=SetDummyString, stored=false};
	__property System::UnicodeString Contacts = {read=FContacts, write=SetDummyString, stored=false};
	__property System::UnicodeString InetTempPath = {read=FPath, write=SetDummyString, stored=false};
	__property int InetTempMaxSize = {read=FMaxSize, write=SetDummyInt, stored=false, nodefault};
private:
	void *__ILMDSysContainer;	// Lmdsysbase::ILMDSysContainer 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D8DECF0C-3DE0-4E44-AD38-F022380E2970}
	operator Lmdsysbase::_di_ILMDSysContainer()
	{
		Lmdsysbase::_di_ILMDSysContainer intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysContainer*(void) { return (Lmdsysbase::ILMDSysContainer*)&__ILMDSysContainer; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysInternetDisplayInfos (System::Set<TLMDSysInternetDisplayInfo, TLMDSysInternetDisplayInfo::ipidInetBrowser, TLMDSysInternetDisplayInfo::ipidInetAdvancedProperties>() << TLMDSysInternetDisplayInfo::ipidInetBrowser << TLMDSysInternetDisplayInfo::ipidInetHomePage << TLMDSysInternetDisplayInfo::ipidInetHTMLEditor << TLMDSysInternetDisplayInfo::ipidInetEMailClient << TLMDSysInternetDisplayInfo::ipidInetNewsClient << TLMDSysInternetDisplayInfo::ipidInetCalendar << TLMDSysInternetDisplayInfo::ipidInetInetCall << TLMDSysInternetDisplayInfo::ipidInetContacts << TLMDSysInternetDisplayInfo::ipidInetTempPath << TLMDSysInternetDisplayInfo::ipidInetTempMaxSize << TLMDSysInternetDisplayInfo::ipidInetZones << TLMDSysInternetDisplayInfo::ipidInetAdvancedProperties )
extern DELPHI_PACKAGE Lmdsysinternetobject__1 LMDSysInternetProps;
}	/* namespace Lmdsysinternetobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSINTERNETOBJECT)
using namespace Lmdsysinternetobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysinternetobjectHPP
