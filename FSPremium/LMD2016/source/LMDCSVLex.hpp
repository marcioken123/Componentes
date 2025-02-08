// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCSVLex.pas' rev: 31.00 (Windows)

#ifndef LmdcsvlexHPP
#define LmdcsvlexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDLex.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcsvlex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCSVLex;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCSVLex : public Lmdlex::TLMDLex
{
	typedef Lmdlex::TLMDLex inherited;
	
public:
	virtual Lmdlex::TLMDToken* __fastcall GetToken(System::Classes::TStream* aStream);
public:
	/* TLMDLex.Create */ inline __fastcall virtual TLMDCSVLex(void) : Lmdlex::TLMDLex() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCSVLex(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcsvlex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCSVLEX)
using namespace Lmdcsvlex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcsvlexHPP
