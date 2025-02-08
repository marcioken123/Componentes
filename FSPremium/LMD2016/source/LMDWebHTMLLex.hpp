// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebHTMLLex.pas' rev: 31.00 (Windows)

#ifndef LmdwebhtmllexHPP
#define LmdwebhtmllexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDWebLex.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebhtmllex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebHTMLLex;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebHTMLLex : public Lmdweblex::TLMDWebLex
{
	typedef Lmdweblex::TLMDWebLex inherited;
	
protected:
	System::Classes::TStringList* FTagsStack;
	virtual System::Sysutils::TSysCharSet __fastcall GetDelimChars(void);
	
public:
	__fastcall virtual TLMDWebHTMLLex(void);
	__fastcall virtual ~TLMDWebHTMLLex(void);
	virtual Lmdweblex::TLMDWebToken* __fastcall GetToken(System::Classes::TStream* aStream);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebhtmllex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBHTMLLEX)
using namespace Lmdwebhtmllex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebhtmllexHPP
