// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebXMLParser.pas' rev: 31.00 (Windows)

#ifndef LmdwebxmlparserHPP
#define LmdwebxmlparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDWebXML.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebxmlparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDXMLParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDXMLParser : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdwebxml::TLMDXMLTags* FXMLTags;
	System::UnicodeString FEncoding;
	void __fastcall SetXMLTags(Lmdwebxml::TLMDXMLTags* const Value);
	void __fastcall SetEncoding(const System::UnicodeString Value);
	
protected:
	virtual System::UnicodeString __fastcall Encode(const System::UnicodeString szString);
	
public:
	__fastcall TLMDXMLParser(void);
	__fastcall virtual ~TLMDXMLParser(void);
	void __fastcall Parse(const System::UnicodeString XML);
	
__published:
	__property Lmdwebxml::TLMDXMLTags* XMLTags = {read=FXMLTags, write=SetXMLTags};
	__property System::UnicodeString Encoding = {read=FEncoding, write=SetEncoding};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::WideString __fastcall Utf8Decode(const Lmdwebxml::UTF8String S);
extern DELPHI_PACKAGE System::UnicodeString __fastcall Utf8ToAnsi(const Lmdwebxml::UTF8String S);
}	/* namespace Lmdwebxmlparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBXMLPARSER)
using namespace Lmdwebxmlparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebxmlparserHPP
