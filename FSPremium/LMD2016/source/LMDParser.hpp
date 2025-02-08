// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDParser.pas' rev: 31.00 (Windows)

#ifndef LmdparserHPP
#define LmdparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDText.hpp>
#include <LMDLex.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDParser;
struct TLMDParserRec;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParser : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdlex::TLMDLex* FLex;
	
protected:
	virtual Lmdlex::TLMDLexClass __fastcall GetLexClass(void) = 0 ;
	
public:
	__fastcall virtual TLMDParser(void);
	__fastcall virtual ~TLMDParser(void);
	__property Lmdlex::TLMDLex* Lex = {read=FLex};
	virtual Lmdtext::TLMDParsedTextList* __fastcall Parse(System::Classes::TStream* aStream, Lmdtext::TLMDGraphicErrorEvent aGraphicErrorEvent, Lmdtext::TLMDGetVariableEvent aGetVariable, Lmdtext::TLMDEmbdControlEvent aEmbdControlCreated, Lmdtext::TLMDRepeatEvent aRepeatEvent) = 0 ;
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDParserClass;

typedef TLMDParserRec *PLMDParserRec;

struct DECLSPEC_DRECORD TLMDParserRec
{
public:
	bool Default;
	TLMDParserClass ParserClass;
	char *Extentions;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall RegisterParser(TLMDParserClass aParserClass, const System::AnsiString *aExtentions, const int aExtentions_High, bool aDefault);
extern DELPHI_PACKAGE void __fastcall UnregisterParser(TLMDParserClass aParserClass);
extern DELPHI_PACKAGE System::Classes::TList* __fastcall Parsers(void);
extern DELPHI_PACKAGE TLMDParserClass __fastcall DefaultParserClass(void);
extern DELPHI_PACKAGE TLMDParserClass __fastcall GetParser(const System::AnsiString Fileext);
}	/* namespace Lmdparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPARSER)
using namespace Lmdparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdparserHPP
