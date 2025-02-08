// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLex.pas' rev: 31.00 (Windows)

#ifndef LmdlexHPP
#define LmdlexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDToken;
class DELPHICLASS TLMDEofToken;
class DELPHICLASS TLMDBADToken;
class DELPHICLASS TLMDTextToken;
class DELPHICLASS TLMDTagToken;
class DELPHICLASS TLMDLex;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTokenType : unsigned char { ttEOF, ttBAD, ttTEXT, ttTAG, ttTERM };

typedef System::Set<char, _DELPHI_SET_CHAR(0), _DELPHI_SET_CHAR(255)> TCharSet;

typedef System::TMetaClass* TLMDTokenClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDToken : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TLMDTokenType FTokenType;
	
public:
	__fastcall virtual TLMDToken(void);
	virtual TLMDToken* __fastcall Clone(void);
	__property TLMDTokenType TokenType = {read=FTokenType, write=FTokenType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEofToken : public TLMDToken
{
	typedef TLMDToken inherited;
	
public:
	__fastcall virtual TLMDEofToken(void);
	virtual TLMDToken* __fastcall Clone(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEofToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBADToken : public TLMDToken
{
	typedef TLMDToken inherited;
	
public:
	__fastcall virtual TLMDBADToken(void);
	virtual TLMDToken* __fastcall Clone(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBADToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextToken : public TLMDToken
{
	typedef TLMDToken inherited;
	
private:
	System::UnicodeString FTokenText;
	
public:
	__fastcall virtual TLMDTextToken(const System::UnicodeString aTokenText)/* overload */;
	__fastcall virtual TLMDTextToken(void)/* overload */;
	virtual TLMDToken* __fastcall Clone(void);
	__property System::UnicodeString TokenText = {read=FTokenText, write=FTokenText};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTextToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTagToken : public TLMDTextToken
{
	typedef TLMDTextToken inherited;
	
private:
	System::Classes::TStringList* FAttributes;
	
protected:
	int __fastcall GetPosition(const System::UnicodeString aAttrName);
	void __fastcall SetPosition(const System::UnicodeString aAttrName, int aValue);
	
public:
	__fastcall virtual TLMDTagToken(const System::UnicodeString aTokenText)/* overload */;
	__fastcall virtual TLMDTagToken(void)/* overload */;
	__fastcall virtual ~TLMDTagToken(void);
	virtual TLMDToken* __fastcall Clone(void);
	bool __fastcall GetAttr(const System::UnicodeString aName, System::UnicodeString &aRes);
	__property System::Classes::TStringList* Attributes = {read=FAttributes};
	__property int Position[const System::UnicodeString aAttrName] = {read=GetPosition, write=SetPosition};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLex : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual TCharSet __fastcall GetDelimChars(void);
	virtual TCharSet __fastcall GetQuoteChars(void);
	virtual TCharSet __fastcall GetSpaceChars(void);
	bool __fastcall IsEof(System::Classes::TStream* aStream);
	void __fastcall BackChar(System::Classes::TStream* aStream);
	System::WideChar __fastcall GetNextChar(System::Classes::TStream* aStream);
	System::UnicodeString __fastcall GetWord(System::Classes::TStream* aStream, const TCharSet &aDelims);
	System::UnicodeString __fastcall GetString(System::Classes::TStream* aStream, const TCharSet &aDelims);
	
public:
	__fastcall virtual TLMDLex(void);
	virtual TLMDToken* __fastcall GetToken(System::Classes::TStream* aStream) = 0 ;
	void __fastcall SkipSpaces(System::Classes::TStream* aStream);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLex(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDLexClass;

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLEX)
using namespace Lmdlex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlexHPP
