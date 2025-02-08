// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDProgressFill.pas' rev: 31.00 (Windows)

#ifndef LmdprogressfillHPP
#define LmdprogressfillHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomProgressFill.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprogressfill
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDProgressFill;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDProgressFill : public Lmdcustomprogressfill::TLMDCustomProgressFill
{
	typedef Lmdcustomprogressfill::TLMDCustomProgressFill inherited;
	
__published:
	__property Step = {default=10};
	__property Position = {default=0};
	__property UserValue = {default=0};
public:
	/* TLMDCustomProgressFill.Create */ inline __fastcall virtual TLMDProgressFill(System::Classes::TComponent* AOwner) : Lmdcustomprogressfill::TLMDCustomProgressFill(AOwner) { }
	/* TLMDCustomProgressFill.Destroy */ inline __fastcall virtual ~TLMDProgressFill(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdprogressfill */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPROGRESSFILL)
using namespace Lmdprogressfill;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprogressfillHPP
