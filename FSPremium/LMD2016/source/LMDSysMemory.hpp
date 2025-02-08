// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysMemory.pas' rev: 31.00 (Windows)

#ifndef LmdsysmemoryHPP
#define LmdsysmemoryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysMemoryObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmemory
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysMemory;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysMemory : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysmemoryobject::TLMDSysMemoryObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysmemoryobject::TLMDSysMemoryObject* aValue);
	
public:
	__fastcall virtual TLMDSysMemory(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysmemoryobject::TLMDSysMemoryObject* Memory = {read=GetObj, write=SetObj};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysMemory(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysmemory */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMEMORY)
using namespace Lmdsysmemory;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmemoryHPP
