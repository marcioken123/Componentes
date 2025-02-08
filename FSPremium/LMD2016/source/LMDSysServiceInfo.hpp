// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysServiceInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysserviceinfoHPP
#define LmdsysserviceinfoHPP

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
#include <LMDSysBase.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysServiceObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysserviceinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysServiceItem;
class DELPHICLASS TLMDSysServicesInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysServiceInfoType : unsigned char { sitServices, sitDrivers, sitAll };

enum DECLSPEC_DENUM TLMDSysServiceInfoStatus : unsigned char { sisActive, sisInactive, sisAll };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysServiceItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::UnicodeString FDisplayName;
	System::UnicodeString FServiceName;
	System::UnicodeString FBinaryPath;
	System::UnicodeString FLoadOrderGroup;
	System::UnicodeString FServiceStartName;
	unsigned FTagId;
	Lmdsysserviceobject::TLMDSysServiceTypes FServiceTypes;
	Lmdsysserviceobject::TLMDSysServiceCurrentState FCurrentState;
	Lmdsysserviceobject::TLMDSysServiceStartType FStartType;
	void __fastcall SetDummyDWord(unsigned aValue);
	void __fastcall SetDummyString(const System::UnicodeString aValue);
	void __fastcall SetDummyTypes(Lmdsysserviceobject::TLMDSysServiceTypes aValue);
	void __fastcall SetDummyState(Lmdsysserviceobject::TLMDSysServiceCurrentState aValue);
	void __fastcall SetDummyStartType(Lmdsysserviceobject::TLMDSysServiceStartType aValue);
	System::UnicodeString __fastcall ServiceTypesToString(void);
	System::UnicodeString __fastcall ServiceTypeToString(const Lmdsysserviceobject::TLMDSysServiceType AType);
	System::UnicodeString __fastcall CurrentStateToString(void);
	System::UnicodeString __fastcall StartTypeToString(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString DisplayName = {read=FDisplayName, write=SetDummyString};
	__property System::UnicodeString ServiceName = {read=FServiceName, write=SetDummyString};
	__property System::UnicodeString BinaryPath = {read=FBinaryPath, write=SetDummyString};
	__property System::UnicodeString LoadOrderGroup = {read=FLoadOrderGroup, write=SetDummyString};
	__property System::UnicodeString ServiceStartName = {read=FServiceStartName, write=SetDummyString};
	__property unsigned TagId = {read=FTagId, write=SetDummyDWord, nodefault};
	__property Lmdsysserviceobject::TLMDSysServiceTypes ServiceTypes = {read=FServiceTypes, write=SetDummyTypes, nodefault};
	__property Lmdsysserviceobject::TLMDSysServiceCurrentState CurrentState = {read=FCurrentState, write=SetDummyState, nodefault};
	__property Lmdsysserviceobject::TLMDSysServiceStartType StartType = {read=FStartType, write=SetDummyStartType, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDSysServiceItem(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDSysServiceItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSysServicesInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDSysServiceItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	TLMDSysServiceInfoStatus FStatus;
	TLMDSysServiceInfoType FType;
	HIDESBASE TLMDSysServiceItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSysServiceItem* Value);
	void __fastcall SetServiceStatus(const TLMDSysServiceInfoStatus Value);
	void __fastcall SetServiceType(const TLMDSysServiceInfoType Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDSysServiceItem* __fastcall Add(void);
	__fastcall TLMDSysServicesInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysServicesInfo(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDSysServiceItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	
__published:
	__property TLMDSysServiceInfoType ServiceType = {read=FType, write=SetServiceType, default=2};
	__property TLMDSysServiceInfoStatus ServiceStatus = {read=FStatus, write=SetServiceStatus, default=2};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysserviceinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSSERVICEINFO)
using namespace Lmdsysserviceinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysserviceinfoHPP
