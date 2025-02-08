// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysMouse.pas' rev: 31.00 (Windows)

#ifndef LmdsysmouseHPP
#define LmdsysmouseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysMouseObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmouse
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysMouse;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysMouse : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysmouseobject::TLMDSysMouseObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysmouseobject::TLMDSysMouseObject* aValue);
	
public:
	__fastcall virtual TLMDSysMouse(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysmouseobject::TLMDSysMouseObject* Mouse = {read=GetObj, write=SetObj};
	__property SysLog;
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysMouse(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysmouse */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMOUSE)
using namespace Lmdsysmouse;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmouseHPP
