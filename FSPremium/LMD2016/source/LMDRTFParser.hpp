// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFParser.pas' rev: 31.00 (Windows)

#ifndef LmdrtfparserHPP
#define LmdrtfparserHPP

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
#include <Vcl.Dialogs.hpp>
#include <LMDSimpleRTFParser.hpp>
#include <LMDText.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFParser : public Lmdsimplertfparser::TLMDSimpleRTFParser
{
	typedef Lmdsimplertfparser::TLMDSimpleRTFParser inherited;
	
public:
	virtual Lmdtext::TLMDParsedTextList* __fastcall Parse(System::Classes::TStream* aStream, Lmdtext::TLMDGraphicErrorEvent aGraphicErrorEvent, Lmdtext::TLMDGetVariableEvent aGetVariable, Lmdtext::TLMDEmbdControlEvent aEmbdControlCreated, Lmdtext::TLMDRepeatEvent aRepeatEvent);
public:
	/* TLMDSimpleRTFParser.Create */ inline __fastcall virtual TLMDRTFParser(void) : Lmdsimplertfparser::TLMDSimpleRTFParser() { }
	/* TLMDSimpleRTFParser.Destroy */ inline __fastcall virtual ~TLMDRTFParser(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFPARSER)
using namespace Lmdrtfparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfparserHPP
