// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDNewsAdapters.pas' rev: 31.00 (Windows)

#ifndef LmdnewsadaptersHPP
#define LmdnewsadaptersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDXML.hpp>
#include <LMDUnicodeEncodings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdnewsadapters
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDNewsEntry;
class DELPHICLASS TLMDNewsCollection;
class DELPHICLASS TLMDNewsReaderAdapter;
class DELPHICLASS TLMDNewsReaderAdapterATOM;
class DELPHICLASS TLMDNewsReaderAdapterRSS09;
class DELPHICLASS TLMDNewsReaderAdapterRSS10;
class DELPHICLASS TLMDNewsReaderAdapterRSS20;
class DELPHICLASS TLMDNewsReaderAdapterLMDNEWS;
class DELPHICLASS TLMDNewsAdapterFactory;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDNewsEntry : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideString FTitle;
	System::TDateTime FPubDate;
	System::WideString FLink;
	System::WideString FContent;
	System::WideString FContentType;
	System::WideString FAuthor;
	int FImage;
	
public:
	__property System::WideString Title = {read=FTitle, write=FTitle};
	__property System::TDateTime PubDate = {read=FPubDate, write=FPubDate};
	__property System::WideString Link = {read=FLink, write=FLink};
	__property System::WideString Content = {read=FContent, write=FContent};
	__property System::WideString ContentType = {read=FContentType, write=FContentType};
	__property System::WideString Author = {read=FAuthor, write=FAuthor};
	__property int Image = {read=FImage, write=FImage, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDNewsEntry(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsEntry(void) { }
	
};


class PASCALIMPLEMENTATION TLMDNewsCollection : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideString FTitle;
	System::WideString FLink;
	System::TDateTime FPubDate;
	System::WideString FDescription;
	System::Classes::TList* FItems;
	TLMDNewsEntry* __fastcall GetItem(int AIndex);
	void __fastcall SetItem(int AIndex, TLMDNewsEntry* const AEntry);
	
public:
	__fastcall TLMDNewsCollection(void);
	__fastcall virtual ~TLMDNewsCollection(void);
	TLMDNewsEntry* __fastcall Add(void);
	int __fastcall Count(void);
	__property System::WideString Title = {read=FTitle, write=FTitle};
	__property System::WideString Link = {read=FLink, write=FLink};
	__property System::TDateTime PubDate = {read=FPubDate, write=FPubDate};
	__property System::WideString Description = {read=FDescription, write=FDescription};
	__property TLMDNewsEntry* Items[int Index] = {read=GetItem, write=SetItem};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewsReaderAdapter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdxml::_di_ILMDXmlDocument FXMLDocument;
	Lmdunicodeencodings::TLMDEncoding* FEncoder;
	void __fastcall SetXMLDocument(Lmdxml::_di_ILMDXmlDocument ADocument);
	System::WideString __fastcall Decode(System::UTF8String AString);
	
public:
	virtual TLMDNewsCollection* __fastcall Parse(void) = 0 ;
	__property Lmdxml::_di_ILMDXmlDocument XMLDocument = {read=FXMLDocument, write=SetXMLDocument};
public:
	/* TObject.Create */ inline __fastcall TLMDNewsReaderAdapter(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsReaderAdapter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewsReaderAdapterATOM : public TLMDNewsReaderAdapter
{
	typedef TLMDNewsReaderAdapter inherited;
	
public:
	virtual TLMDNewsCollection* __fastcall Parse(void);
public:
	/* TObject.Create */ inline __fastcall TLMDNewsReaderAdapterATOM(void) : TLMDNewsReaderAdapter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsReaderAdapterATOM(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewsReaderAdapterRSS09 : public TLMDNewsReaderAdapter
{
	typedef TLMDNewsReaderAdapter inherited;
	
public:
	virtual TLMDNewsCollection* __fastcall Parse(void);
public:
	/* TObject.Create */ inline __fastcall TLMDNewsReaderAdapterRSS09(void) : TLMDNewsReaderAdapter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsReaderAdapterRSS09(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewsReaderAdapterRSS10 : public TLMDNewsReaderAdapter
{
	typedef TLMDNewsReaderAdapter inherited;
	
public:
	virtual TLMDNewsCollection* __fastcall Parse(void);
public:
	/* TObject.Create */ inline __fastcall TLMDNewsReaderAdapterRSS10(void) : TLMDNewsReaderAdapter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsReaderAdapterRSS10(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewsReaderAdapterRSS20 : public TLMDNewsReaderAdapter
{
	typedef TLMDNewsReaderAdapter inherited;
	
public:
	virtual TLMDNewsCollection* __fastcall Parse(void);
public:
	/* TObject.Create */ inline __fastcall TLMDNewsReaderAdapterRSS20(void) : TLMDNewsReaderAdapter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsReaderAdapterRSS20(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewsReaderAdapterLMDNEWS : public TLMDNewsReaderAdapter
{
	typedef TLMDNewsReaderAdapter inherited;
	
public:
	virtual TLMDNewsCollection* __fastcall Parse(void);
public:
	/* TObject.Create */ inline __fastcall TLMDNewsReaderAdapterLMDNEWS(void) : TLMDNewsReaderAdapter() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsReaderAdapterLMDNEWS(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNewsAdapterFactory : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod TLMDNewsReaderAdapter* __fastcall GetAdapter(const System::WideString AXMLDocument);
public:
	/* TObject.Create */ inline __fastcall TLMDNewsAdapterFactory(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNewsAdapterFactory(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdnewsadapters */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDNEWSADAPTERS)
using namespace Lmdnewsadapters;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdnewsadaptersHPP
