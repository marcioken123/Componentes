// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysMultimedia.pas' rev: 31.00 (Windows)

#ifndef LmdsysmultimediaHPP
#define LmdsysmultimediaHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysMultimediaObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmultimedia
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysMultimedia;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysMultimedia : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysmultimediaobject::TLMDSysMultimediaObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysmultimediaobject::TLMDSysMultimediaObject* aValue);
	
public:
	__fastcall virtual TLMDSysMultimedia(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysmultimediaobject::TLMDSysMultimediaObject* Multimedia = {read=GetObj, write=SetObj, stored=false};
	__property SysLog;
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysMultimedia(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysmultimedia */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMULTIMEDIA)
using namespace Lmdsysmultimedia;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmultimediaHPP
