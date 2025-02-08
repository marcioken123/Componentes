// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysobjectHPP
#define LmdsysobjectHPP

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
#include <System.Win.Registry.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysPropertyDesc.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysObject;
class DELPHICLASS TLMDSysBaseCollection;
class DELPHICLASS TLMDSysBaseCollectionItem;
class DELPHICLASS TLMDSysCollection;
class DELPHICLASS TLMDSysCollectionItem;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysAvailability : unsigned char { aUnDefined, aOther, aUnknown, aRunning, aWarning, aInTest, aNotApplicable, aPowerOff, aOffLine, aOffDuty, aDegraded, aNotInstalled, aInstallError, aPowerSaveUnknown, aPowerSaveLowPowerMode, aPowerSaveStandby, aPowerCycle, aPowerSaveWarning };

enum DECLSPEC_DENUM TLMDSysPowerManagementCapability : unsigned char { pmUnknown, pmNotSupported, pmDisabled, pmEnabled, pmPowerSavingModesEnteredAutomatically, pmPowerStateSettable, pmPowerCyclingSupported, pmTimedPowerOnSupported };

typedef System::Set<TLMDSysPowerManagementCapability, TLMDSysPowerManagementCapability::pmUnknown, TLMDSysPowerManagementCapability::pmTimedPowerOnSupported> TLMDSysPowerManagementCapabilities;

enum DECLSPEC_DENUM TLMDSysStatusInfo : unsigned char { siUndefined, siOther, siUnknown, siEnabled, siDisabled, siNotApplicable };

typedef void __fastcall (__closure *TLMDOnFilterPropName)(const System::UnicodeString Name, bool &Cancel);

class PASCALIMPLEMENTATION TLMDSysObject : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FApplyChangesAtOnce;
	System::Classes::TPersistent* FOwner;
	Lmdsyslog::TLMDSysLogChangeEvent FOnChangeLog;
	System::Win::Registry::TRegistry* FRegistry;
	System::UnicodeString FInfoFilename;
	System::Classes::TList* FChanges;
	void __fastcall SetRegistry(System::Win::Registry::TRegistry* aValue);
	
protected:
	bool FInit;
	bool FInstantUpdate;
	int FRefCount;
	Lmdsyspropertydesc::TLMDSysPropertiesDesc* FPropertiesDesc;
	HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef(void);
	int __stdcall _Release(void);
	void __fastcall SetChangeLog(const Lmdsyslog::TLMDSysLogChangeEvent Value);
	void __fastcall DoLog(System::TObject* Sender, System::UnicodeString propertyDescription, System::UnicodeString oldValue, System::UnicodeString newValue, System::TDateTime datetime);
	__property bool ApplyChangesAtOnce = {read=FApplyChangesAtOnce, write=FApplyChangesAtOnce, default=0};
	void __fastcall LogChange(const System::UnicodeString valueDescription, const System::UnicodeString oldValue, const System::UnicodeString newValue, System::TDateTime datetime);
	void __fastcall Log(const System::UnicodeString valueDescription, const System::UnicodeString oldValue, const System::UnicodeString newValue);
	__property bool InstantUpdate = {read=FInstantUpdate, write=FInstantUpdate, nodefault};
	virtual void __fastcall RegisterProperties(void);
	virtual void __fastcall DoFilterProperty(const System::UnicodeString Name, bool &Cancel);
	void __fastcall RememberChange(const System::UnicodeString valueDescription, const System::UnicodeString oldValue, const System::UnicodeString newValue);
	void __fastcall ClearChanges(void);
	bool __fastcall PropChanged(const System::UnicodeString valueDescription);
	void __fastcall WriteToLog(const System::UnicodeString valueDescription);
	void __fastcall DoProgress(System::UnicodeString aCaption, int aMax, int aPosition);
	
public:
	__property Lmdsyslog::TLMDSysLogChangeEvent OnChangeLog = {read=FOnChangeLog, write=SetChangeLog};
	void __fastcall SetOwner(System::Classes::TPersistent* aValue);
	__property System::Classes::TPersistent* Owner = {read=FOwner, write=SetOwner};
	virtual void __fastcall GetValues(System::Classes::TStrings* aText);
	virtual void __fastcall GetValuesEx(System::Classes::TStrings* aText);
	virtual void __fastcall Init(void);
	virtual void __fastcall Refresh(void) = 0 ;
	virtual void __fastcall Apply(void) = 0 ;
	__fastcall virtual TLMDSysObject(void);
	__fastcall virtual ~TLMDSysObject(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall BeforeDestruction(void);
	__classmethod virtual System::TObject* __fastcall NewInstance();
	__property int RefCount = {read=FRefCount, nodefault};
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	virtual int __fastcall GetPropertiesCount(void);
	virtual bool __fastcall GetPropAvailability(int index);
	virtual Lmdsysbase::TLMDSysPropertyType __fastcall GetPropType(int index);
	virtual System::Variant __fastcall GetPropValue(int index);
	virtual System::UnicodeString __fastcall GetPropText(int index);
	virtual System::UnicodeString __fastcall GetPropTitle(int index);
	virtual System::UnicodeString __fastcall GetPropDescription(int index);
	__property System::Win::Registry::TRegistry* Registry = {read=FRegistry, write=SetRegistry};
	void __fastcall OpenRegistry(bool aReadOnly);
	void __fastcall CloseRegistry(void);
	void __fastcall SetRegistryRootKey(HKEY aRootKey);
	bool __fastcall OpenRegistrySubKey(const System::UnicodeString aSubKey);
	void __fastcall CloseRegistrySubKey(void);
	virtual bool __fastcall isPropertyAvailable(const System::UnicodeString propName);
	virtual System::UnicodeString __fastcall getPropertyDescription(const System::UnicodeString propName);
	virtual System::UnicodeString __fastcall getPropertyHint(const System::UnicodeString propName);
private:
	void *__ILMDSysPublisher;	// Lmdsysbase::ILMDSysPublisher 
	void *__ILMDSysDescriptor;	// Lmdsysbase::ILMDSysDescriptor 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0E5B3D50-3B18-450A-BF9B-8595BE330FC8}
	operator Lmdsysbase::_di_ILMDSysPublisher()
	{
		Lmdsysbase::_di_ILMDSysPublisher intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysPublisher*(void) { return (Lmdsysbase::ILMDSysPublisher*)&__ILMDSysPublisher; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {059155C7-51D6-4EAF-8795-76F40E6AABD3}
	operator Lmdsysbase::_di_ILMDSysDescriptor()
	{
		Lmdsysbase::_di_ILMDSysDescriptor intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysDescriptor*(void) { return (Lmdsysbase::ILMDSysDescriptor*)&__ILMDSysDescriptor; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__ILMDSysPublisher; }
	#endif
	
};


typedef System::TMetaClass* TLMDSysObjectClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysBaseCollection : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
protected:
	int FRefCount;
	HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef(void);
	int __stdcall _Release(void);
	void __fastcall DoProgress(System::UnicodeString aCaption, int aMax, int aPosition);
	
public:
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall BeforeDestruction(void);
	__classmethod virtual System::TObject* __fastcall NewInstance();
	virtual int __fastcall GetElementCount(void);
	virtual System::TObject* __fastcall GetElement(int index);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property int RefCount = {read=FRefCount, nodefault};
public:
	/* TCollection.Create */ inline __fastcall TLMDSysBaseCollection(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDSysBaseCollection(void) { }
	
private:
	void *__ILMDSysDescriptor;	// Lmdsysbase::ILMDSysDescriptor 
	void *__ILMDSysContainer;	// Lmdsysbase::ILMDSysContainer 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {059155C7-51D6-4EAF-8795-76F40E6AABD3}
	operator Lmdsysbase::_di_ILMDSysDescriptor()
	{
		Lmdsysbase::_di_ILMDSysDescriptor intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysDescriptor*(void) { return (Lmdsysbase::ILMDSysDescriptor*)&__ILMDSysDescriptor; }
	#endif
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
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__ILMDSysDescriptor; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysBaseCollectionItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	int FRefCount;
	Lmdsyspropertydesc::TLMDSysPropertiesDesc* FPropertiesDesc;
	HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef(void);
	int __stdcall _Release(void);
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysBaseCollectionItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSysBaseCollectionItem(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall BeforeDestruction(void);
	__classmethod virtual System::TObject* __fastcall NewInstance();
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	virtual int __fastcall GetPropertiesCount(void);
	virtual bool __fastcall GetPropAvailability(int index);
	virtual Lmdsysbase::TLMDSysPropertyType __fastcall GetPropType(int index);
	virtual System::Variant __fastcall GetPropValue(int index);
	virtual System::UnicodeString __fastcall GetPropText(int index);
	virtual System::UnicodeString __fastcall GetPropTitle(int index);
	virtual System::UnicodeString __fastcall GetPropDescription(int index);
	__property int RefCount = {read=FRefCount, nodefault};
private:
	void *__ILMDSysPublisher;	// Lmdsysbase::ILMDSysPublisher 
	void *__ILMDSysDescriptor;	// Lmdsysbase::ILMDSysDescriptor 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0E5B3D50-3B18-450A-BF9B-8595BE330FC8}
	operator Lmdsysbase::_di_ILMDSysPublisher()
	{
		Lmdsysbase::_di_ILMDSysPublisher intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysPublisher*(void) { return (Lmdsysbase::ILMDSysPublisher*)&__ILMDSysPublisher; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {059155C7-51D6-4EAF-8795-76F40E6AABD3}
	operator Lmdsysbase::_di_ILMDSysDescriptor()
	{
		Lmdsysbase::_di_ILMDSysDescriptor intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysDescriptor*(void) { return (Lmdsysbase::ILMDSysDescriptor*)&__ILMDSysDescriptor; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__ILMDSysPublisher; }
	#endif
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSysCollection : public TLMDSysBaseCollection
{
	typedef TLMDSysBaseCollection inherited;
	
private:
	System::Classes::TList* FChanges;
	Lmdsyslog::TLMDSysLogChangeEvent FOnChangeLog;
	void __fastcall SetChangeLog(const Lmdsyslog::TLMDSysLogChangeEvent Value);
	
protected:
	void __fastcall LogChange(const System::UnicodeString valueDescription, const System::UnicodeString oldValue, const System::UnicodeString newValue, System::TDateTime datetime);
	void __fastcall Log(const System::UnicodeString valueDescription, const System::UnicodeString oldValue, const System::UnicodeString newValue);
	
public:
	__fastcall TLMDSysCollection(System::Classes::TCollectionItemClass ItemClass);
	__fastcall virtual ~TLMDSysCollection(void);
	void __fastcall RememberChange(const System::UnicodeString valueDescription, const System::UnicodeString oldValue, const System::UnicodeString newValue);
	bool __fastcall PropChanged(const System::UnicodeString valueDescription);
	void __fastcall WriteToLog(const System::UnicodeString valueDescription);
	virtual void __fastcall Apply(void);
	virtual void __fastcall GetValues(System::Classes::TStrings* aText);
	virtual void __fastcall GetValuesEx(System::Classes::TStrings* aText);
	__property Lmdsyslog::TLMDSysLogChangeEvent OnChangeLog = {read=FOnChangeLog, write=SetChangeLog};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysCollectionItem : public TLMDSysBaseCollectionItem
{
	typedef TLMDSysBaseCollectionItem inherited;
	
public:
	void __fastcall RememberChange(const System::UnicodeString valueDescription, const System::UnicodeString oldValue, const System::UnicodeString newValue);
	bool __fastcall PropChanged(const System::UnicodeString valueDescription);
	void __fastcall WriteToLog(const System::UnicodeString valueDescription);
	virtual void __fastcall Apply(void);
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDSysCollectionItem(System::Classes::TCollection* Collection) : TLMDSysBaseCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDSysCollectionItem(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall SysAvailabilityToStr(TLMDSysAvailability aSysAvailability);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SysPowerManagementCapabilitiesToStr(TLMDSysPowerManagementCapabilities PowerCaps);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SysStatusInfoToStr(TLMDSysStatusInfo SysStatusInfo);
extern DELPHI_PACKAGE System::UnicodeString __fastcall BoolToStr(bool aValue);
}	/* namespace Lmdsysobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSOBJECT)
using namespace Lmdsysobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysobjectHPP
