// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWildcardUnit.pas' rev: 31.00 (Windows)

#ifndef LmdwildcardunitHPP
#define LmdwildcardunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDStrSupp.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwildcardunit
{
//-- forward type declarations -----------------------------------------------
struct TLMDWCTemplateToken;
class DELPHICLASS TLMDWildcardProcessor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDWCTokenType : unsigned char { ttConst, ttAnySymbols, ttAnySymbol };

typedef TLMDWCTemplateToken *PLMDWCTemplateToken;

struct DECLSPEC_DRECORD TLMDWCTemplateToken
{
public:
	System::UnicodeString szToken;
	TLMDWCTokenType TokenType;
};


typedef System::DynamicArray<TLMDWCTemplateToken> TLMDWCTemplateTokens;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWildcardProcessor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FMatchCase;
	int __fastcall InternalFindWildcard(System::Classes::TStream* Stream, TLMDWCTemplateTokens aTemplate, int iTokenIndex, int &EndPos, bool bSearch, bool bAllowSpace = true);
	void __fastcall SetMatchCase(const bool Value);
	
public:
	int __fastcall FindWildcard(System::UnicodeString szTemplate, System::Classes::TStream* Stream, System::UnicodeString &Founded, bool WholeWordsOnly, System::WideChar AnySingleCharacter = (System::WideChar)(0x3f), System::WideChar AnySequenceCharacter = (System::WideChar)(0x2a));
	__property bool MatchCase = {read=FMatchCase, write=SetMatchCase, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDWildcardProcessor(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWildcardProcessor(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::ResourceString _MSG_MAX_PROCESS_CONST;
#define Lmdwildcardunit_MSG_MAX_PROCESS_CONST System::LoadResourceString(&Lmdwildcardunit::_MSG_MAX_PROCESS_CONST)
static const System::Word MAX_PROCESS_CONST = System::Word(0x2710);
}	/* namespace Lmdwildcardunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWILDCARDUNIT)
using namespace Lmdwildcardunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwildcardunitHPP
