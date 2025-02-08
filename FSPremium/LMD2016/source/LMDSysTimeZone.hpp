// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysTimeZone.pas' rev: 31.00 (Windows)

#ifndef LmdsystimezoneHPP
#define LmdsystimezoneHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysTimeZoneObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsystimezone
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysTimeZone;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysTimeZone : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsystimezoneobject::TLMDSysTimeZoneObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsystimezoneobject::TLMDSysTimeZoneObject* aValue);
	
public:
	__fastcall virtual TLMDSysTimeZone(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsystimezoneobject::TLMDSysTimeZoneObject* TimeZone = {read=GetObj, write=SetObj};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysTimeZone(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsystimezone */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSTIMEZONE)
using namespace Lmdsystimezone;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsystimezoneHPP
