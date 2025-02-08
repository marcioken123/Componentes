// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysInternet.pas' rev: 31.00 (Windows)

#ifndef LmdsysinternetHPP
#define LmdsysinternetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysInternetObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysinternet
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysInternet;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysInternet : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysinternetobject::TLMDSysInternetObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysinternetobject::TLMDSysInternetObject* aValue);
	
public:
	__fastcall virtual TLMDSysInternet(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysinternetobject::TLMDSysInternetObject* Internet = {read=GetObj, write=SetObj};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysInternet(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysinternet */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSINTERNET)
using namespace Lmdsysinternet;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysinternetHPP
