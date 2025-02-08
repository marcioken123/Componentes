// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExtParser.pas' rev: 31.00 (Windows)

#ifndef LmdextparserHPP
#define LmdextparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDParser.hpp>
#include <LMDLex.hpp>
#include <LMDBand.hpp>
#include <LMDText.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdextparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExtParser;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDEntryStage : unsigned char { esOpenTag, esCloseTag, esData, esDataCancel, esDataSuccess, esElementSuccess, esElementFail, esRollBack };

typedef bool __fastcall (__closure *TLMDParseFunc)(void);

typedef void __fastcall (__closure *TLMDParseAction)(Lmdtext::TLMDParsedTextList* &aParsedText, TLMDEntryStage aStage);

class PASCALIMPLEMENTATION TLMDExtParser : public Lmdparser::TLMDParser
{
	typedef Lmdparser::TLMDParser inherited;
	
private:
	Lmdband::TLMDTokenBand* FBand;
	int __fastcall GetPos(void);
	void __fastcall SetPos(int value);
	void __fastcall TranslateRepeat(void);
	void __fastcall TranslateBaseFont(void);
	void __fastcall ApplyVariables(Lmdlex::TLMDToken* aToken);
	bool __fastcall TokenIs(Lmdlex::TLMDTokenType aValue);
	
protected:
	Lmdtext::TLMDGraphicErrorEvent FGraphicErrorEvent;
	Lmdtext::TLMDGetVariableEvent FGetVariable;
	Lmdtext::TLMDEmbdControlEvent FEmbdControlCreated;
	Lmdtext::TLMDRepeatEvent FRepeatEvent;
	void __fastcall Clear(void);
	void __fastcall LoadFromStream(System::Classes::TStream* aStream);
	
public:
	__fastcall virtual TLMDExtParser(void);
	__fastcall virtual ~TLMDExtParser(void);
	bool __fastcall Tag(const System::UnicodeString aName);
	System::UnicodeString __fastcall TokenText(void);
	bool __fastcall TokenIsText(void);
	bool __fastcall TokenIsTag(void);
	Lmdlex::TLMDTagToken* __fastcall TokenAsTag(void);
	bool __fastcall ValidToken(void);
	Lmdlex::TLMDToken* __fastcall Token(void);
	void __fastcall AddTag(const System::UnicodeString aName);
	void __fastcall RemoveTag(void);
	void __fastcall NextToken(void);
	void __fastcall PrevToken(void);
	__property int Position = {read=GetPos, write=SetPos, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdextparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXTPARSER)
using namespace Lmdextparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdextparserHPP
