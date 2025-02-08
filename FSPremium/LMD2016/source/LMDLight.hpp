// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLight.pas' rev: 31.00 (Windows)

#ifndef LmdlightHPP
#define LmdlightHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomLight.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlight
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLight;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLight : public Lmdcustomlight::TLMDCustomLight
{
	typedef Lmdcustomlight::TLMDCustomLight inherited;
	
__published:
	__property Active = {default=0};
public:
	/* TLMDCustomLight.Create */ inline __fastcall virtual TLMDLight(System::Classes::TComponent* AOwner) : Lmdcustomlight::TLMDCustomLight(AOwner) { }
	/* TLMDCustomLight.Destroy */ inline __fastcall virtual ~TLMDLight(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlight */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLIGHT)
using namespace Lmdlight;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlightHPP
