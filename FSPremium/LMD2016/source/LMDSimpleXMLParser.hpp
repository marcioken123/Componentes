// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimpleXMLParser.pas' rev: 31.00 (Windows)

#ifndef LmdsimplexmlparserHPP
#define LmdsimplexmlparserHPP

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
#include <LMDSimpleXMLLex.hpp>
#include <LMDParser.hpp>
#include <LMDLex.hpp>
#include <LMDTree.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsimplexmlparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleXMLParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSimpleXMLParser : public Lmdparser::TLMDParser
{
	typedef Lmdparser::TLMDParser inherited;
	
private:
	Lmdtext::TLMDBaseText* __fastcall ProcessText(Lmdtext::TLMDParsedTextList* aRoot, System::UnicodeString aText);
	void __fastcall ParseBranch(Lmdtree::TLMDTree* aRoot, System::Classes::TStream* aStream, System::UnicodeString aOpenText);
	
protected:
	virtual Lmdlex::TLMDLexClass __fastcall GetLexClass(void);
	
public:
	virtual Lmdtext::TLMDParsedTextList* __fastcall Parse(System::Classes::TStream* aStream, Lmdtext::TLMDGraphicErrorEvent aGraphicErrorEvent, Lmdtext::TLMDGetVariableEvent aGetVariable, Lmdtext::TLMDEmbdControlEvent aEmbdControlCreated, Lmdtext::TLMDRepeatEvent aRepeatEvent);
public:
	/* TLMDParser.Create */ inline __fastcall virtual TLMDSimpleXMLParser(void) : Lmdparser::TLMDParser() { }
	/* TLMDParser.Destroy */ inline __fastcall virtual ~TLMDSimpleXMLParser(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsimplexmlparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLEXMLPARSER)
using namespace Lmdsimplexmlparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimplexmlparserHPP
