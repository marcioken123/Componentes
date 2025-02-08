// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebXML.pas' rev: 31.00 (Windows)

#ifndef LmdwebxmlHPP
#define LmdwebxmlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebxml
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDXMLTag;
class DELPHICLASS TLMDXMLTags;
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString UTF8String;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDXMLTag : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	TLMDXMLTags* FSubTags;
	System::Classes::TStringList* FAttributes;
	System::UnicodeString FText;
	System::Classes::TStringList* FExAttributes;
	void __fastcall SetAttributes(System::Classes::TStringList* const Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetSubTags(TLMDXMLTags* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetExAttributes(System::Classes::TStringList* const Value);
	
public:
	__fastcall virtual TLMDXMLTag(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDXMLTag(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property System::Classes::TStringList* ExAttributes = {read=FExAttributes, write=SetExAttributes};
	__property System::Classes::TStringList* Attributes = {read=FAttributes, write=SetAttributes};
	__property TLMDXMLTags* SubTags = {read=FSubTags, write=SetSubTags};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDXMLTags : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDXMLTag* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDXMLTag* __fastcall GetItems(int Index);
	
public:
	__fastcall TLMDXMLTags(void);
	HIDESBASE TLMDXMLTag* __fastcall Add(void);
	TLMDXMLTag* __fastcall FindByName(const System::UnicodeString szName, bool bMatchCase = false, bool bFindInSubTree = false);
	__property TLMDXMLTag* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDXMLTags(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebxml */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBXML)
using namespace Lmdwebxml;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebxmlHPP
