// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebLex.pas' rev: 31.00 (Windows)

#ifndef LmdweblexHPP
#define LmdweblexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdweblex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebToken;
class DELPHICLASS TLMDWebEofToken;
class DELPHICLASS TLMDWebBADToken;
class DELPHICLASS TLMDWebTextToken;
class DELPHICLASS TLMDWebTagToken;
class DELPHICLASS TLMDWebLex;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDWebTokenType : unsigned char { ttEOF, ttBAD, ttTEXT, ttTAG, ttTERM };

typedef System::Sysutils::TSysCharSet TCharSet;

typedef System::TMetaClass* TLMDWebTokenClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebToken : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TLMDWebTokenType FTokenType;
	
public:
	__fastcall virtual TLMDWebToken(void);
	virtual TLMDWebToken* __fastcall Clone(void);
	__property TLMDWebTokenType TokenType = {read=FTokenType, write=FTokenType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWebToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebEofToken : public TLMDWebToken
{
	typedef TLMDWebToken inherited;
	
public:
	__fastcall virtual TLMDWebEofToken(void);
	virtual TLMDWebToken* __fastcall Clone(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWebEofToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebBADToken : public TLMDWebToken
{
	typedef TLMDWebToken inherited;
	
public:
	__fastcall virtual TLMDWebBADToken(void);
	virtual TLMDWebToken* __fastcall Clone(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWebBADToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebTextToken : public TLMDWebToken
{
	typedef TLMDWebToken inherited;
	
private:
	System::UnicodeString FTokenText;
	
public:
	__fastcall virtual TLMDWebTextToken(System::UnicodeString aTokenText)/* overload */;
	__fastcall virtual TLMDWebTextToken(void)/* overload */;
	virtual TLMDWebToken* __fastcall Clone(void);
	__property System::UnicodeString TokenText = {read=FTokenText, write=FTokenText};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWebTextToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebTagToken : public TLMDWebTextToken
{
	typedef TLMDWebTextToken inherited;
	
public:
	System::Classes::TStringList* FAttributes;
	
protected:
	int __fastcall GetPosition(System::UnicodeString aAttrName);
	void __fastcall SetPosition(System::UnicodeString aAttrName, int aValue);
	
public:
	__fastcall virtual TLMDWebTagToken(System::UnicodeString aTokenText)/* overload */;
	__fastcall virtual TLMDWebTagToken(void)/* overload */;
	__fastcall virtual ~TLMDWebTagToken(void);
	virtual TLMDWebToken* __fastcall Clone(void);
	__property System::Classes::TStringList* Attributes = {read=FAttributes};
	__property int Position[System::UnicodeString aAttrName] = {read=GetPosition, write=SetPosition};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebLex : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual System::Sysutils::TSysCharSet __fastcall GetDelimChars(void);
	virtual System::Sysutils::TSysCharSet __fastcall GetQuoteChars(void);
	virtual System::Sysutils::TSysCharSet __fastcall GetSpaceChars(void);
	bool __fastcall IsEof(System::Classes::TStream* aStream);
	void __fastcall BackChar(System::Classes::TStream* aStream);
	System::WideChar __fastcall GetNextChar(System::Classes::TStream* aStream);
	System::UnicodeString __fastcall GetWord(System::Classes::TStream* aStream, const System::Sysutils::TSysCharSet &aDelims);
	System::UnicodeString __fastcall GetString(System::Classes::TStream* aStream, const System::Sysutils::TSysCharSet &aDelims);
	
public:
	__fastcall virtual TLMDWebLex(void);
	virtual TLMDWebToken* __fastcall GetToken(System::Classes::TStream* aStream) = 0 ;
	void __fastcall SkipSpaces(System::Classes::TStream* aStream);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWebLex(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDWebLexClass;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdweblex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBLEX)
using namespace Lmdweblex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdweblexHPP
