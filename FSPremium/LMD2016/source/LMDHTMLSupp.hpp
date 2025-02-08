// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLSupp.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlsuppHPP
#define LmdhtmlsuppHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlsupp
{
//-- forward type declarations -----------------------------------------------
struct TLMDTemplateToken;
class DELPHICLASS TLMDHTMLProcessor;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TTokenType : unsigned char { ttConst, ttAnySpace, ttAnySymbols, ttParam, ttAnySymbol };

typedef System::DynamicArray<System::UnicodeString> TWordsArray;

typedef TLMDTemplateToken *PLMDTemplateToken;

struct DECLSPEC_DRECORD TLMDTemplateToken
{
public:
	System::UnicodeString szToken;
	TTokenType TokenType;
	int iTag;
	TWordsArray nearWords;
};


typedef System::DynamicArray<System::WideString> TTemplateResult;

typedef System::DynamicArray<TLMDTemplateToken> TLMDTemplateTokens;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLProcessor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FIndex;
	System::UnicodeString FHTML;
	System::UnicodeString FSearchHTML;
	void __fastcall SetHTML(const System::UnicodeString Value);
	bool __fastcall InternalFindTemplate(TLMDTemplateTokens aTemplate, int iTokenIndex, int &iStartIndex, int &iEndIndex, TTemplateResult &TemplateResult, bool bSearch);
	
public:
	__fastcall TLMDHTMLProcessor(void);
	__fastcall virtual ~TLMDHTMLProcessor(void);
	System::Variant __fastcall FindTemplate(const System::UnicodeString szTemplate);
	__property System::UnicodeString HTML = {read=FHTML, write=SetHTML};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word MAX_HTML_PROCESS_CONST = System::Word(0x258);
extern DELPHI_PACKAGE System::UnicodeString __fastcall HTMLDecode(const System::UnicodeString AStr);
extern DELPHI_PACKAGE int __fastcall GetTag(const System::UnicodeString szTmp, int &Index, System::UnicodeString &szTag);
extern DELPHI_PACKAGE System::UnicodeString __fastcall RemoveTags(const System::UnicodeString Str);
}	/* namespace Lmdhtmlsupp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLSUPP)
using namespace Lmdhtmlsupp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlsuppHPP
