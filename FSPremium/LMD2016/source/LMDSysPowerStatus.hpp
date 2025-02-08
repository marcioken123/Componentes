// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysPowerStatus.pas' rev: 31.00 (Windows)

#ifndef LmdsyspowerstatusHPP
#define LmdsyspowerstatusHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysPowerStatusObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyspowerstatus
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysPowerStatus;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysPowerStatus : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsyspowerstatusobject::TLMDSysPowerStatusObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsyspowerstatusobject::TLMDSysPowerStatusObject* aValue);
	
public:
	__fastcall virtual TLMDSysPowerStatus(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsyspowerstatusobject::TLMDSysPowerStatusObject* PowerStatus = {read=GetObj, write=SetObj};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysPowerStatus(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyspowerstatus */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPOWERSTATUS)
using namespace Lmdsyspowerstatus;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyspowerstatusHPP
