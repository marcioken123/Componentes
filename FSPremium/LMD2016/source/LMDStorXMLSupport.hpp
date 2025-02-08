// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorXMLSupport.pas' rev: 31.00 (Windows)

#ifndef LmdstorxmlsupportHPP
#define LmdstorxmlsupportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDStorCommon.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorxmlsupport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorXMLTag;
class DELPHICLASS TLMDStorXMLTags;
class DELPHICLASS TLMDStorXML;
class DELPHICLASS TLMDStorToken;
class DELPHICLASS TLMDStorLex;
class DELPHICLASS TLMDStorEofToken;
class DELPHICLASS TLMDStorHTMLLex;
class DELPHICLASS TLMDStorTextToken;
class DELPHICLASS TLMDStorTagToken;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorXMLTag : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	TLMDStorXMLTags* FSubTags;
	System::Classes::TStringList* FAttributes;
	System::UnicodeString FText;
	System::Classes::TStringList* FExAttributes;
	void __fastcall SetAttributes(System::Classes::TStringList* const Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetSubTags(TLMDStorXMLTags* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetExAttributes(System::Classes::TStringList* const Value);
	System::UnicodeString __fastcall GetAttribute(System::UnicodeString Name);
	void __fastcall SetAttribute(System::UnicodeString Name, const System::UnicodeString Value);
	
public:
	__fastcall virtual TLMDStorXMLTag(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDStorXMLTag(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall SetQuotes(void);
	__property System::UnicodeString Attribute[System::UnicodeString Name] = {read=GetAttribute, write=SetAttribute};
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property System::Classes::TStringList* ExAttributes = {read=FExAttributes, write=SetExAttributes};
	__property System::Classes::TStringList* Attributes = {read=FAttributes, write=SetAttributes};
	__property TLMDStorXMLTags* SubTags = {read=FSubTags, write=SetSubTags};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorXMLTags : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDStorXMLTag* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDStorXMLTag* __fastcall GetItems(int Index);
	
public:
	__fastcall TLMDStorXMLTags(void);
	HIDESBASE TLMDStorXMLTag* __fastcall Add(void);
	TLMDStorXMLTag* __fastcall FindByName(System::UnicodeString szName, bool bMatchCase = false, bool bFindInSubTree = false);
	__property TLMDStorXMLTag* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDStorXMLTags(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorXML : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDStorXMLTags* FXMLTags;
	System::UnicodeString FEncoding;
	System::UnicodeString FHeader;
	System::UnicodeString FFooter;
	void __fastcall SetXMLStorTags(TLMDStorXMLTags* const Value);
	void __fastcall SetEncoding(const System::UnicodeString Value);
	void __fastcall SaveTag(TLMDStorXMLTag* Tag, System::Classes::TStrings* List, int Level);
	
protected:
	virtual System::UnicodeString __fastcall Encode(System::UnicodeString szString);
	
public:
	__fastcall TLMDStorXML(void);
	__fastcall virtual ~TLMDStorXML(void);
	void __fastcall Parse(System::UnicodeString XML);
	void __fastcall SaveToStrings(System::Classes::TStrings* TS);
	void __fastcall SaveToFile(System::UnicodeString FileName);
	void __fastcall Clear(void);
	__property TLMDStorXMLTags* XMLTags = {read=FXMLTags, write=SetXMLStorTags};
	__property System::UnicodeString Encoding = {read=FEncoding, write=SetEncoding};
	__property System::UnicodeString Header = {read=FHeader, write=FHeader};
	__property System::UnicodeString Footer = {read=FFooter, write=FFooter};
};

#pragma pack(pop)

typedef System::Set<char, _DELPHI_SET_CHAR(0), _DELPHI_SET_CHAR(255)> TLMDStorCharSet;

enum DECLSPEC_DENUM TLMDStorTokenType : unsigned char { ttEOF, ttBAD, ttTEXT, ttTAG, ttTERM };

typedef System::TMetaClass* TLMDStorTokenClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorToken : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TLMDStorTokenType FTokenType;
	
public:
	__fastcall virtual TLMDStorToken(void);
	virtual TLMDStorToken* __fastcall Clone(void);
	__property TLMDStorTokenType TokenType = {read=FTokenType, write=FTokenType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStorToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorLex : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual TLMDStorCharSet __fastcall GetDelimChars(void);
	virtual TLMDStorCharSet __fastcall GetQuoteChars(void);
	virtual TLMDStorCharSet __fastcall GetSpaceChars(void);
	bool __fastcall IsEof(System::Classes::TStream* aStream);
	void __fastcall BackChar(System::Classes::TStream* aStream);
	System::WideChar __fastcall GetNextChar(System::Classes::TStream* aStream);
	System::UnicodeString __fastcall GetWord(System::Classes::TStream* aStream, const TLMDStorCharSet &aDelims);
	System::UnicodeString __fastcall GetString(System::Classes::TStream* aStream, const TLMDStorCharSet &aDelims);
	
public:
	__fastcall virtual TLMDStorLex(void);
	virtual TLMDStorToken* __fastcall GetToken(System::Classes::TStream* aStream) = 0 ;
	void __fastcall SkipSpaces(System::Classes::TStream* aStream);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStorLex(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorEofToken : public TLMDStorToken
{
	typedef TLMDStorToken inherited;
	
public:
	__fastcall virtual TLMDStorEofToken(void);
	virtual TLMDStorToken* __fastcall Clone(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStorEofToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorHTMLLex : public TLMDStorLex
{
	typedef TLMDStorLex inherited;
	
protected:
	virtual TLMDStorCharSet __fastcall GetDelimChars(void);
	
public:
	virtual TLMDStorToken* __fastcall GetToken(System::Classes::TStream* aStream);
public:
	/* TLMDStorLex.Create */ inline __fastcall virtual TLMDStorHTMLLex(void) : TLMDStorLex() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStorHTMLLex(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorTextToken : public TLMDStorToken
{
	typedef TLMDStorToken inherited;
	
private:
	System::UnicodeString FTokenText;
	
public:
	__fastcall virtual TLMDStorTextToken(System::UnicodeString aTokenText)/* overload */;
	__fastcall virtual TLMDStorTextToken(void)/* overload */;
	virtual TLMDStorToken* __fastcall Clone(void);
	__property System::UnicodeString TokenText = {read=FTokenText, write=FTokenText};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStorTextToken(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorTagToken : public TLMDStorTextToken
{
	typedef TLMDStorTextToken inherited;
	
public:
	System::Classes::TStringList* FAttributes;
	
protected:
	int __fastcall GetPosition(System::UnicodeString aAttrName);
	void __fastcall SetPosition(System::UnicodeString aAttrName, int aValue);
	
public:
	__fastcall virtual TLMDStorTagToken(System::UnicodeString aTokenText)/* overload */;
	__fastcall virtual TLMDStorTagToken(void)/* overload */;
	__fastcall virtual ~TLMDStorTagToken(void);
	virtual TLMDStorToken* __fastcall Clone(void);
	__property System::Classes::TStringList* Attributes = {read=FAttributes};
	__property int Position[System::UnicodeString aAttrName] = {read=GetPosition, write=SetPosition};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorxmlsupport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORXMLSUPPORT)
using namespace Lmdstorxmlsupport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorxmlsupportHPP
