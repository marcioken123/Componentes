// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimpleXMLLex.pas' rev: 31.00 (Windows)

#ifndef LmdsimplexmllexHPP
#define LmdsimplexmllexHPP

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

namespace Lmdsimplexmllex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleXMLLex;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSimpleXMLLex : public Lmdlex::TLMDLex
{
	typedef Lmdlex::TLMDLex inherited;
	
protected:
	virtual Lmdlex::TCharSet __fastcall GetDelimChars(void);
	
public:
	virtual Lmdlex::TLMDToken* __fastcall GetToken(System::Classes::TStream* aStream);
public:
	/* TLMDLex.Create */ inline __fastcall virtual TLMDSimpleXMLLex(void) : Lmdlex::TLMDLex() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDSimpleXMLLex(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsimplexmllex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLEXMLLEX)
using namespace Lmdsimplexmllex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimplexmllexHPP
