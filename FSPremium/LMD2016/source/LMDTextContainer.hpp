// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextContainer.pas' rev: 31.00 (Windows)

#ifndef LmdtextcontainerHPP
#define LmdtextcontainerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTextObject.hpp>
#include <LMDText.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextcontainer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextChangeLink;
class DELPHICLASS TLMDTextListItem;
class DELPHICLASS TLMDTextListItems;
class DELPHICLASS TLMDTextContainer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDTextContainer* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TLMDTextChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDTextContainer* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TLMDTextChangeLink(void) : System::TObject() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextListItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtextobject::TLMDStrings* FLines;
	System::UnicodeString FName;
	void __fastcall SetName(System::UnicodeString aValue);
	void __fastcall SetLines(Lmdtextobject::TLMDStrings* aValue);
	void __fastcall LinesChange(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TLMDTextListItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDTextListItem(void);
	
__published:
	__property Index;
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property Lmdtextobject::TLMDStrings* Lines = {read=FLines, write=SetLines};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTextListItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDTextListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDTextContainer* FOwner;
	HIDESBASE TLMDTextListItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDTextListItem* const Value);
	int __fastcall GetItemByName(System::UnicodeString index);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall SetItemName(System::Classes::TCollectionItem* Item);
	virtual System::Classes::TCollectionItemClass __fastcall GetItemClass(void);
	System::UnicodeString __fastcall UniqueName(void);
	
public:
	__fastcall TLMDTextListItems(System::Classes::TComponent* aOwner);
	HIDESBASE TLMDTextListItem* __fastcall Add(void);
	__property TLMDTextListItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int ItemByName[System::UnicodeString index] = {read=GetItemByName};
	__property TLMDTextContainer* TextContainer = {read=FOwner};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDTextListItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDTextContainer : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::Classes::TList* FClients;
	TLMDTextListItems* FItems;
	TLMDTextListItems* __fastcall GetItems(void);
	int __fastcall GetCount(void);
	
public:
	__fastcall virtual TLMDTextContainer(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextContainer(void);
	DYNAMIC void __fastcall Change(void);
	void __fastcall RegisterChanges(TLMDTextChangeLink* aValue);
	void __fastcall UnRegisterChanges(TLMDTextChangeLink* aValue);
	int __fastcall GetNamedIndex(const System::UnicodeString aValue);
	__property int Count = {read=GetCount, nodefault};
	
__published:
	__property About = {default=0};
	__property TLMDTextListItems* Items = {read=GetItems, write=FItems};
	__property OnChange;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextcontainer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTCONTAINER)
using namespace Lmdtextcontainer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextcontainerHPP
