// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElHTMLContainer.pas' rev: 31.00 (Windows)

#ifndef ElhtmlcontainerHPP
#define ElhtmlcontainerHPP

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
#include <ElComponent.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elhtmlcontainer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElHTMLChangeLink;
class DELPHICLASS TElHTMLListItem;
class DELPHICLASS TElHTMLListItems;
class DELPHICLASS TElHTMLContainer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElHTMLChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElHTMLContainer* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TElHTMLChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TElHTMLContainer* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TElHTMLChangeLink(void) : System::TObject() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElHTMLListItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FCaption;
	System::UnicodeString FName;
	void __fastcall SetName(const System::UnicodeString aValue);
	void __fastcall SetCaption(const Lmdtypes::TLMDString aValue);
	void __fastcall LinesChange(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TElHTMLListItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElHTMLListItem(void);
	
__published:
	__property Index;
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElHTMLListItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElHTMLListItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TElHTMLContainer* FOwner;
	HIDESBASE TElHTMLListItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TElHTMLListItem* const Value);
	int __fastcall GetItemByName(System::UnicodeString index);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	virtual void __fastcall SetItemName(System::Classes::TCollectionItem* Item);
	System::UnicodeString __fastcall UniqueName(void);
	virtual System::Classes::TCollectionItemClass __fastcall GetItemClass(void);
	
public:
	__fastcall TElHTMLListItems(System::Classes::TComponent* aOwner);
	HIDESBASE TElHTMLListItem* __fastcall Add(void);
	__property TElHTMLListItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int ItemByName[System::UnicodeString index] = {read=GetItemByName};
	__property TElHTMLContainer* TextContainer = {read=FOwner};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElHTMLListItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElHTMLContainer : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	System::Classes::TList* FClients;
	TElHTMLListItems* FItems;
	TElHTMLListItems* __fastcall GetItems(void);
	int __fastcall GetCount(void);
	
protected:
	int __fastcall GetNamedIndex(System::UnicodeString aValue);
	
public:
	__fastcall virtual TElHTMLContainer(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TElHTMLContainer(void);
	DYNAMIC void __fastcall Change(void);
	void __fastcall RegisterChanges(TElHTMLChangeLink* aValue);
	void __fastcall UnRegisterChanges(TElHTMLChangeLink* aValue);
	__property int Count = {read=GetCount, nodefault};
	__property int ItemByName[System::UnicodeString index] = {read=GetNamedIndex};
	
__published:
	__property About = {default=0};
	__property TElHTMLListItems* Items = {read=GetItems, write=FItems};
	__property OnChange;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elhtmlcontainer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELHTMLCONTAINER)
using namespace Elhtmlcontainer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElhtmlcontainerHPP
