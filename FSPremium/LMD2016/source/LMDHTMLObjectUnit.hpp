// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLObjectUnit.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlobjectunitHPP
#define LmdhtmlobjectunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDWebHTMLLex.hpp>
#include <LMDWebLex.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlobjectunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLLink;
class DELPHICLASS TLMDHTMLLinks;
class DELPHICLASS TLMDHTMLItem;
class DELPHICLASS TLMDHTMLItems;
class DELPHICLASS TLMDHTMLObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDHTMLLinkType : unsigned char { LT_NONE, LT_HREF, LT_IMAGE, LT_BODY, LT_FRAME, LT_CLASS, LT_LINK, LT_SCRIPT };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLLink : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FClassCode;
	System::UnicodeString FCodeBase;
	System::UnicodeString FURL;
	int FSourcePos;
	TLMDHTMLLinkType FLinkType;
	bool FLocal;
	System::UnicodeString FLocalFile;
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall SeTLMDHTMLLinkType(const TLMDHTMLLinkType Value);
	System::UnicodeString __fastcall GetURL(void);
	System::UnicodeString __fastcall GetWebURL(void);
	void __fastcall SetClassCode(const System::UnicodeString Value);
	void __fastcall SetCodeBase(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetWebURLOnly(void);
	
public:
	void __fastcall Read(System::Classes::TReader* Reader);
	void __fastcall Write(System::Classes::TWriter* Writer);
	__fastcall virtual TLMDHTMLLink(System::Classes::TCollection* Collection);
	__property System::UnicodeString WebURL = {read=GetWebURL};
	__property System::UnicodeString WebURLOnly = {read=GetWebURLOnly};
	
__published:
	__property TLMDHTMLLinkType LinkType = {read=FLinkType, write=SeTLMDHTMLLinkType, nodefault};
	__property System::UnicodeString URL = {read=GetURL, write=SetURL};
	__property int SourcePos = {read=FSourcePos, write=FSourcePos, nodefault};
	__property bool Local = {read=FLocal, write=FLocal, nodefault};
	__property System::UnicodeString LocalFile = {read=FLocalFile, write=FLocalFile};
	__property System::UnicodeString ClassCode = {read=FClassCode, write=SetClassCode};
	__property System::UnicodeString CodeBase = {read=FCodeBase, write=SetCodeBase};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDHTMLLink(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLLinks : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDHTMLLink* operator[](int Index) { return this->Link[Index]; }
	
private:
	TLMDHTMLObject* FHTMLObject;
	TLMDHTMLLink* __fastcall GetLink(int Index);
	int __fastcall GetIndexOf(System::UnicodeString URL);
	int __fastcall GetIndexOfWeb(System::UnicodeString URL);
	
public:
	void __fastcall Read(System::Classes::TReader* Reader);
	void __fastcall Write(System::Classes::TWriter* Writer);
	__fastcall TLMDHTMLLinks(TLMDHTMLObject* HTMLObject);
	HIDESBASE TLMDHTMLLink* __fastcall Add(void);
	__property int IndexOf[System::UnicodeString URL] = {read=GetIndexOf};
	__property int IndexOfWeb[System::UnicodeString URL] = {read=GetIndexOfWeb};
	__property TLMDHTMLLink* Link[int Index] = {read=GetLink/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDHTMLLinks(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FiType;
	System::UnicodeString FValue;
	System::UnicodeString FName;
	void __fastcall SetiType(const int Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetValue(const System::UnicodeString Value);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property int iType = {read=FiType, write=SetiType, nodefault};
	__property System::UnicodeString Value = {read=FValue, write=SetValue};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDHTMLItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDHTMLItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDHTMLItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDHTMLItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TLMDHTMLItems(void);
	HIDESBASE TLMDHTMLItem* __fastcall Add(void);
	TLMDHTMLItem* __fastcall FindByName(System::UnicodeString Name);
	__property TLMDHTMLItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDHTMLItems(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDLinkConversion : unsigned char { lcNone, lcOnline, lcOffline };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLObject : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FHTML;
	TLMDHTMLLinks* FLinks;
	System::UnicodeString FBaseURL;
	System::UnicodeString FLocalURL;
	System::UnicodeString FTitle;
	TLMDLinkConversion FLinkConversion;
	TLMDHTMLItems* FItems;
	void __fastcall SetLinks(TLMDHTMLLinks* const Value);
	void __fastcall SetHTML(const System::UnicodeString Value);
	System::UnicodeString __fastcall GetHTML(void);
	void __fastcall SetTitle(const System::UnicodeString Value);
	void __fastcall SeTLMDLinkConversion(const TLMDLinkConversion Value);
	void __fastcall SetItems(TLMDHTMLItems* const Value);
	
public:
	__fastcall TLMDHTMLObject(void);
	__fastcall virtual ~TLMDHTMLObject(void);
	void __fastcall Clear(void);
	void __fastcall Read(System::Classes::TReader* Reader);
	void __fastcall Write(System::Classes::TWriter* Writer);
	__property System::UnicodeString HTML = {read=GetHTML, write=SetHTML};
	__property System::UnicodeString BaseURL = {read=FBaseURL, write=FBaseURL};
	__property System::UnicodeString LocalURL = {read=FLocalURL, write=FLocalURL};
	
__published:
	__property System::UnicodeString Title = {read=FTitle, write=SetTitle};
	__property System::UnicodeString HTMLPrototype = {read=FHTML, write=FHTML};
	__property TLMDHTMLLinks* Links = {read=FLinks, write=SetLinks};
	__property TLMDHTMLItems* Items = {read=FItems, write=SetItems};
	__property TLMDLinkConversion LinkConversion = {read=FLinkConversion, write=SeTLMDLinkConversion, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmlobjectunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLOBJECTUNIT)
using namespace Lmdhtmlobjectunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlobjectunitHPP
