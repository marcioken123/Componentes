// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDProgress.pas' rev: 31.00 (Windows)

#ifndef LmdprogressHPP
#define LmdprogressHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomProgress.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprogress
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDProgress;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDProgress : public Lmdcustomprogress::TLMDCustomProgress
{
	typedef Lmdcustomprogress::TLMDCustomProgress inherited;
	
__published:
	__property Step = {default=10};
	__property Position = {default=0};
	__property UserValue = {default=0};
public:
	/* TLMDCustomProgress.Create */ inline __fastcall virtual TLMDProgress(System::Classes::TComponent* AOwner) : Lmdcustomprogress::TLMDCustomProgress(AOwner) { }
	/* TLMDCustomProgress.Destroy */ inline __fastcall virtual ~TLMDProgress(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdprogress */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPROGRESS)
using namespace Lmdprogress;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprogressHPP
