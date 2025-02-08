// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFHyperText.pas' rev: 31.00 (Windows)

#ifndef LmdrtfhypertextHPP
#define LmdrtfhypertextHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <LMDTypes.hpp>
#include <LMDRTFRichEdit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfhypertext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichHyperLink;
class DELPHICLASS TLMDRichHyperLinks;
class DELPHICLASS TLMDRichHyperText;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichHyperLink : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	bool FLinkType;
	System::UnicodeString FLinkAddress;
	
public:
	__property bool LinkType = {read=FLinkType, write=FLinkType, nodefault};
	__property System::UnicodeString LinkAddress = {read=FLinkAddress, write=FLinkAddress};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDRichHyperLink(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDRichHyperLink(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichHyperLinks : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDRichHyperLink* operator[](int Index) { return this->Items[Index]; }
	
protected:
	HIDESBASE TLMDRichHyperLink* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDRichHyperLink* const Value);
	
public:
	__fastcall TLMDRichHyperLinks(void);
	HIDESBASE TLMDRichHyperLink* __fastcall Add(void);
	__property TLMDRichHyperLink* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRichHyperLinks(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichHyperText : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdrtfrichedit::TLMDRichEdit* FEditor;
	bool __fastcall GetLinkedTextParams(int &SelStart, int &SelLength);
	
public:
	bool __fastcall ValidLinkSelection(void);
	bool __fastcall GetLinkParams(bool &aType, System::UnicodeString &aAddress)/* overload */;
	bool __fastcall GetLinkParams(int Pos, bool &aType, System::UnicodeString &aAddress)/* overload */;
	bool __fastcall DeleteLink(void);
	bool __fastcall ChangeLink(bool aType, const System::UnicodeString aAddress);
	void __fastcall ShowLinkDialog(void);
	void __fastcall GetBookMarks(System::Classes::TStrings* aBookMarks);
	void __fastcall InsertBookMark(const System::UnicodeString aBookMark);
	void __fastcall DeleteBookMark(const System::UnicodeString aBookMark);
	void __fastcall GoToBookMark(const System::UnicodeString aBookMark);
	void __fastcall ShowBookMarksDialog(void);
	void __fastcall MarkAllLink(bool aProtectLinks = true);
	void __fastcall MarkLinksForLabel(TLMDRichHyperLinks* FLinkStorage);
	bool __fastcall InsertLink(bool aType, const System::UnicodeString aAddress);
	void __fastcall InsertLinkedText(bool aType, const System::UnicodeString Text, const System::UnicodeString aAddress);
	System::Types::TPoint __fastcall GetBookMarkPos(const System::UnicodeString aBookMark);
	__property Lmdrtfrichedit::TLMDRichEdit* Editor = {read=FEditor, write=FEditor};
public:
	/* TObject.Create */ inline __fastcall TLMDRichHyperText(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRichHyperText(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall GetLinkParams(Lmdrtfrichedit::TLMDCustomRichEdit* FEditor, int Pos, bool &aType, System::UnicodeString &aAddress)/* overload */;
extern DELPHI_PACKAGE bool __fastcall GetLinkParams(Lmdrtfrichedit::TLMDCustomRichEdit* FEditor, bool &aType, System::UnicodeString &aAddress)/* overload */;
}	/* namespace Lmdrtfhypertext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFHYPERTEXT)
using namespace Lmdrtfhypertext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfhypertextHPP
