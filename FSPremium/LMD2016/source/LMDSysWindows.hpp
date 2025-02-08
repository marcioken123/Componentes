// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysWindows.pas' rev: 31.00 (Windows)

#ifndef LmdsyswindowsHPP
#define LmdsyswindowsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysWindowsObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyswindows
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysWindows;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysWindows : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsyswindowsobject::TLMDSysWindowsObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsyswindowsobject::TLMDSysWindowsObject* aValue);
	
public:
	__fastcall virtual TLMDSysWindows(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsyswindowsobject::TLMDSysWindowsObject* Windows = {read=GetObj, write=SetObj};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysWindows(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyswindows */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSWINDOWS)
using namespace Lmdsyswindows;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyswindowsHPP
