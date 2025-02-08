// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysDisplay.pas' rev: 31.00 (Windows)

#ifndef LmdsysdisplayHPP
#define LmdsysdisplayHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysDisplayObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysdisplay
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysDisplay;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysDisplay : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysdisplayobject::TLMDSysDisplayObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysdisplayobject::TLMDSysDisplayObject* aValue);
	
public:
	__fastcall virtual TLMDSysDisplay(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysdisplayobject::TLMDSysDisplayObject* Display = {read=GetObj, write=SetObj};
	__property SysLog;
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysDisplay(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysdisplay */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSDISPLAY)
using namespace Lmdsysdisplay;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysdisplayHPP
