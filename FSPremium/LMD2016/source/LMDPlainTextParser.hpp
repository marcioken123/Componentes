// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPlainTextParser.pas' rev: 31.00 (Windows)

#ifndef LmdplaintextparserHPP
#define LmdplaintextparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <LMDParser.hpp>
#include <LMDPlainTextLex.hpp>
#include <LMDLex.hpp>
#include <LMDText.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdplaintextparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPlainTextParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPlainTextParser : public Lmdparser::TLMDParser
{
	typedef Lmdparser::TLMDParser inherited;
	
protected:
	virtual Lmdlex::TLMDLexClass __fastcall GetLexClass(void);
	
public:
	virtual Lmdtext::TLMDParsedTextList* __fastcall Parse(System::Classes::TStream* aStream, Lmdtext::TLMDGraphicErrorEvent aGraphicErrorEvent, Lmdtext::TLMDGetVariableEvent aGetVariable, Lmdtext::TLMDEmbdControlEvent aEmbdControlCreated, Lmdtext::TLMDRepeatEvent aRepeatEvent);
public:
	/* TLMDParser.Create */ inline __fastcall virtual TLMDPlainTextParser(void) : Lmdparser::TLMDParser() { }
	/* TLMDParser.Destroy */ inline __fastcall virtual ~TLMDPlainTextParser(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdplaintextparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPLAINTEXTPARSER)
using namespace Lmdplaintextparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdplaintextparserHPP
