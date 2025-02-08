// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysService.pas' rev: 31.00 (Windows)

#ifndef LmdsysserviceHPP
#define LmdsysserviceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysServiceObject.hpp>
#include <LMDSysServiceInfo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysservice
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysService;
class DELPHICLASS TLMDSysServices;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysService : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysserviceobject::TLMDSysServiceObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysserviceobject::TLMDSysServiceObject* aValue);
	
public:
	__fastcall virtual TLMDSysService(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysserviceobject::TLMDSysServiceObject* Service = {read=GetObj, write=SetObj, stored=false};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysService(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSysServices : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysserviceinfo::TLMDSysServicesInfo* FServices;
	void __fastcall SetServices(Lmdsysserviceinfo::TLMDSysServicesInfo* const Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysServices(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysServices(void);
	virtual int __fastcall GetElementCount(void);
	virtual System::TObject* __fastcall GetElement(int index);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property Lmdsysserviceinfo::TLMDSysServicesInfo* Services = {read=FServices, write=SetServices, stored=false};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysservice */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSSERVICE)
using namespace Lmdsysservice;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysserviceHPP
