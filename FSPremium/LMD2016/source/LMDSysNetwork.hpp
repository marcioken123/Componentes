// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysNetwork.pas' rev: 31.00 (Windows)

#ifndef LmdsysnetworkHPP
#define LmdsysnetworkHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysNetworkObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysnetwork
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysNetwork;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysNetwork : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysnetworkobject::TLMDSysNetworkObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysnetworkobject::TLMDSysNetworkObject* aValue);
	
public:
	__fastcall virtual TLMDSysNetwork(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysnetworkobject::TLMDSysNetworkObject* Network = {read=GetObj, write=SetObj, stored=false};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysNetwork(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysnetwork */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSNETWORK)
using namespace Lmdsysnetwork;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysnetworkHPP
