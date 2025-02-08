// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLLex.pas' rev: 31.00 (Windows)

#ifndef LmdhtmllexHPP
#define LmdhtmllexHPP

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

namespace Lmdhtmllex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLLex;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLLex : public Lmdlex::TLMDLex
{
	typedef Lmdlex::TLMDLex inherited;
	
protected:
	virtual Lmdlex::TCharSet __fastcall GetDelimChars(void);
	
public:
	virtual Lmdlex::TLMDToken* __fastcall GetToken(System::Classes::TStream* aStream);
public:
	/* TLMDLex.Create */ inline __fastcall virtual TLMDHTMLLex(void) : Lmdlex::TLMDLex() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDHTMLLex(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmllex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLLEX)
using namespace Lmdhtmllex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmllexHPP
