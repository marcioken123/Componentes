// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebXMLParserLite.pas' rev: 31.00 (Windows)

#ifndef LmdwebxmlparserliteHPP
#define LmdwebxmlparserliteHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDWebXML.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebxmlparserlite
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDXMLParserLite;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDXMLParserLite : public System::TObject
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
	__fastcall TLMDXMLParserLite(void);
	__fastcall virtual ~TLMDXMLParserLite(void);
	void __fastcall Parse(const System::UnicodeString XML);
	
__published:
	__property Lmdwebxml::TLMDXMLTags* XMLTags = {read=FXMLTags, write=SetXMLTags};
	__property System::UnicodeString Encoding = {read=FEncoding, write=SetEncoding};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebxmlparserlite */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBXMLPARSERLITE)
using namespace Lmdwebxmlparserlite;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebxmlparserliteHPP
