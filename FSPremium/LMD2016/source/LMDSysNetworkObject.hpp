// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysNetworkObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysnetworkobjectHPP
#define LmdsysnetworkobjectHPP

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
#include <LMDSysPropertyDesc.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysnetworkobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDProtocol;
class DELPHICLASS TLMDTCPIP;
class DELPHICLASS TLMDIPX;
class DELPHICLASS TLMDNetBEUI;
class DELPHICLASS TLMDNetworkCard;
class DELPHICLASS TLMDNetworkCards;
class DELPHICLASS TLMDSysNetworkObject;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProtocol : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FInstalled;
	TLMDNetworkCard* FNetworkCard;
	void __fastcall SetDummyBoolean(const bool Value);
	
protected:
	int FRefCount;
	Lmdsyspropertydesc::TLMDSysPropertiesDesc* FPropertiesDesc;
	HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef(void);
	int __stdcall _Release(void);
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall TLMDProtocol(TLMDNetworkCard* aNetworkCard);
	__fastcall virtual ~TLMDProtocol(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall BeforeDestruction(void);
	__classmethod virtual System::TObject* __fastcall NewInstance();
	__property int RefCount = {read=FRefCount, nodefault};
	virtual void __fastcall Refresh(void);
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
	__property TLMDNetworkCard* NetworkCard = {read=FNetworkCard};
	
__published:
	__property bool Installed = {read=FInstalled, write=SetDummyBoolean, stored=false, nodefault};
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

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTCPIP : public TLMDProtocol
{
	typedef TLMDProtocol inherited;
	
private:
	System::UnicodeString FIPSubnetMask;
	System::UnicodeString FIPAddress;
	System::UnicodeString FDefaultGateway;
	bool FDHCPEnabled;
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetDummyBool(const bool Value);
	System::UnicodeString __fastcall GetCSIPAddress(void);
	System::UnicodeString __fastcall GetCSIPSubnetMask(void);
	System::UnicodeString __fastcall GetCSDefaultGateWay(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	virtual void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property bool DHCPEnabled = {read=FDHCPEnabled, write=SetDummyBool, stored=false, nodefault};
	__property System::UnicodeString IPAddress = {read=FIPAddress, write=SetDummyString, stored=false};
	__property System::UnicodeString IPSubnetMask = {read=FIPSubnetMask, write=SetDummyString, stored=false};
	__property System::UnicodeString DefaultGateway = {read=FDefaultGateway, write=SetDummyString, stored=false};
	__property System::UnicodeString CSIPAddress = {read=GetCSIPAddress, stored=false};
	__property System::UnicodeString CSIPSubnetMask = {read=GetCSIPSubnetMask, stored=false};
	__property System::UnicodeString CSDefaultGateWay = {read=GetCSDefaultGateWay, stored=false};
public:
	/* TLMDProtocol.Create */ inline __fastcall TLMDTCPIP(TLMDNetworkCard* aNetworkCard) : TLMDProtocol(aNetworkCard) { }
	/* TLMDProtocol.Destroy */ inline __fastcall virtual ~TLMDTCPIP(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIPX : public TLMDProtocol
{
	typedef TLMDProtocol inherited;
	
private:
	System::UnicodeString FNetworkNumber;
	void __fastcall SetDummyString(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	virtual void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString NetworkNumber = {read=FNetworkNumber, write=SetDummyString};
public:
	/* TLMDProtocol.Create */ inline __fastcall TLMDIPX(TLMDNetworkCard* aNetworkCard) : TLMDProtocol(aNetworkCard) { }
	/* TLMDProtocol.Destroy */ inline __fastcall virtual ~TLMDIPX(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNetBEUI : public TLMDProtocol
{
	typedef TLMDProtocol inherited;
	
public:
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
public:
	/* TLMDProtocol.Create */ inline __fastcall TLMDNetBEUI(TLMDNetworkCard* aNetworkCard) : TLMDProtocol(aNetworkCard) { }
	/* TLMDProtocol.Destroy */ inline __fastcall virtual ~TLMDNetBEUI(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNetworkCard : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::UnicodeString FDescription;
	System::UnicodeString FServiceName;
	TLMDTCPIP* FTCPIP;
	TLMDNetBEUI* FNetBEUI;
	TLMDIPX* FIPX;
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetDummyTCPIP(TLMDTCPIP* const Value);
	void __fastcall SetDummyIPX(TLMDIPX* const Value);
	void __fastcall SetDummyNetBEUI(TLMDNetBEUI* const Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	void __fastcall Refresh(void);
	__fastcall virtual TLMDNetworkCard(System::Classes::TCollection* ACollection);
	__fastcall virtual ~TLMDNetworkCard(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	int __fastcall GetElementCount(void);
	System::TObject* __fastcall GetElement(int index);
	
__published:
	__property System::UnicodeString Description = {read=FDescription, write=SetDummyString, stored=false};
	__property TLMDTCPIP* TCPIP = {read=FTCPIP, write=SetDummyTCPIP, stored=false};
	__property TLMDNetBEUI* NetBEUI = {read=FNetBEUI, write=SetDummyNetBEUI, stored=false};
	__property TLMDIPX* IPX = {read=FIPX, write=SetDummyIPX, stored=false};
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

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDNetworkCards : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDNetworkCard* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDNetworkCard* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDNetworkCard* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDNetworkCard* __fastcall Add(void);
	__fastcall TLMDNetworkCards(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDNetworkCards(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDNetworkCard* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


class PASCALIMPLEMENTATION TLMDSysNetworkObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::UnicodeString FUserName;
	System::UnicodeString FComputerName;
	TLMDNetworkCards* FNetworkCards;
	System::Classes::TStringList* FIPList;
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetDummyCards(TLMDNetworkCards* const Value);
	System::Classes::TStringList* __fastcall GetList(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysNetworkObject(void);
	__fastcall virtual ~TLMDSysNetworkObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual void __fastcall Init(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	int __fastcall GetElementCount(void);
	System::TObject* __fastcall GetElement(int index);
	__property System::Classes::TStringList* IPList = {read=GetList};
	
__published:
	__property System::UnicodeString UserName = {read=FUserName, write=SetDummyString, stored=false};
	__property System::UnicodeString ComputerName = {read=FComputerName, write=SetDummyString, stored=false};
	__property TLMDNetworkCards* NetworkCards = {read=FNetworkCards, write=SetDummyCards, stored=false};
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
extern DELPHI_PACKAGE void __fastcall LMDSysGetLocalIPs(System::Classes::TStringList* TCPIPList);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDSysGetLocalIP(void);
}	/* namespace Lmdsysnetworkobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSNETWORKOBJECT)
using namespace Lmdsysnetworkobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysnetworkobjectHPP
