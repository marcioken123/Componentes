// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimpleRTFParser.pas' rev: 31.00 (Windows)

#ifndef LmdsimplertfparserHPP
#define LmdsimplertfparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDParser.hpp>
#include <LMDRTFTape.hpp>
#include <LMDLex.hpp>
#include <LMDRTFScanner.hpp>
#include <LMDRTFDocument.hpp>
#include <LMDText.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsimplertfparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleRTFParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSimpleRTFParser : public Lmdparser::TLMDParser
{
	typedef Lmdparser::TLMDParser inherited;
	
private:
	System::Classes::TStream* FStream;
	Lmdrtftape::TLMDRTFTape* FTape;
	Lmdrtfscanner::TLMDRTFScanner* FScanner;
	Lmdrtfdocument::TLMDRTFDocument* FDocument;
	
protected:
	virtual Lmdlex::TLMDLexClass __fastcall GetLexClass(void);
	
public:
	__fastcall virtual TLMDSimpleRTFParser(void);
	__fastcall virtual ~TLMDSimpleRTFParser(void);
	virtual Lmdtext::TLMDParsedTextList* __fastcall Parse(System::Classes::TStream* aStream, Lmdtext::TLMDGraphicErrorEvent aGraphicErrorEvent, Lmdtext::TLMDGetVariableEvent aGetVariable, Lmdtext::TLMDEmbdControlEvent aEmbdControlCreated, Lmdtext::TLMDRepeatEvent aRepeatEvent);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsimplertfparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLERTFPARSER)
using namespace Lmdsimplertfparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimplertfparserHPP
