// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCSVParser.pas' rev: 31.00 (Windows)

#ifndef LmdcsvparserHPP
#define LmdcsvparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDText.hpp>
#include <LMDTable.hpp>
#include <LMDCSVLex.hpp>
#include <LMDParser.hpp>
#include <LMDLex.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcsvparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCSVParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCSVParser : public Lmdparser::TLMDParser
{
	typedef Lmdparser::TLMDParser inherited;
	
protected:
	virtual Lmdlex::TLMDLexClass __fastcall GetLexClass(void);
	
public:
	virtual Lmdtext::TLMDParsedTextList* __fastcall Parse(System::Classes::TStream* aStream, Lmdtext::TLMDGraphicErrorEvent aGraphicErrorEvent, Lmdtext::TLMDGetVariableEvent aGetVariable, Lmdtext::TLMDEmbdControlEvent aEmbdControlCreated, Lmdtext::TLMDRepeatEvent aRepeatEvent);
public:
	/* TLMDParser.Create */ inline __fastcall virtual TLMDCSVParser(void) : Lmdparser::TLMDParser() { }
	/* TLMDParser.Destroy */ inline __fastcall virtual ~TLMDCSVParser(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcsvparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCSVPARSER)
using namespace Lmdcsvparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcsvparserHPP
