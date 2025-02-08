// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysLocale.pas' rev: 31.00 (Windows)

#ifndef LmdsyslocaleHPP
#define LmdsyslocaleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysLocaleObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyslocale
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysLocale;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysLocale : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsyslocaleobject::TLMDSysLocaleObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsyslocaleobject::TLMDSysLocaleObject* aValue);
	
public:
	__fastcall virtual TLMDSysLocale(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsyslocaleobject::TLMDSysLocaleObject* Locale = {read=GetObj, write=SetObj};
	__property SysLog;
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysLocale(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyslocale */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSLOCALE)
using namespace Lmdsyslocale;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyslocaleHPP
