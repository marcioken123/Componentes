// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFStorage.pas' rev: 31.00 (Windows)

#ifndef LmdrtfstorageHPP
#define LmdrtfstorageHPP

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
#include <LMDRTFBase.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfstorage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFChangeLink;
class DELPHICLASS TLMDRichStorageItem;
class DELPHICLASS TLMDRichStorageItems;
class DELPHICLASS TLMDRichStorage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRTFChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDRichStorage* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TLMDRTFChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDRichStorage* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TLMDRTFChangeLink(void) : System::TObject() { }
	
};


class PASCALIMPLEMENTATION TLMDRichStorageItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Classes::TStrings* FLines;
	System::UnicodeString FName;
	Lmdrtfbase::TLMDRichURLClickEvent FOnURLClick;
	Lmdrtfbase::TLMDRichURLClickEvent FOnLinkClick;
	void __fastcall SetName(System::UnicodeString aValue);
	void __fastcall SetLines(System::Classes::TStrings* aValue);
	void __fastcall LinesChange(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall LoadTextProperty(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TLMDRichStorageItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRichStorageItem(void);
	DYNAMIC void __fastcall DoLinkClick(System::TObject* aSender, const System::UnicodeString aURLText, System::Uitypes::TMouseButton aButton);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Index;
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property Lmdrtfbase::TLMDRichURLClickEvent OnURLClick = {read=FOnURLClick, write=FOnURLClick};
	__property Lmdrtfbase::TLMDRichURLClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichStorageItems : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDRichStorageItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDRichStorage* __fastcall GetStorage(void);
	
protected:
	HIDESBASE TLMDRichStorageItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDRichStorageItem* const Value);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	__classmethod virtual System::Classes::TCollectionItemClass __fastcall GetItemClass();
	
public:
	HIDESBASE TLMDRichStorageItem* __fastcall Add(void);
	__property TLMDRichStorageItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TLMDRichStorage* Storage = {read=GetStorage};
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDRichStorageItems(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRichStorageItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDRichStorage : public Lmdrtfbase::TLMDRichComponent
{
	typedef Lmdrtfbase::TLMDRichComponent inherited;
	
private:
	System::Classes::TList* FClients;
	TLMDRichStorageItems* __fastcall GetItems(void);
	int __fastcall GetCount(void);
	
protected:
	TLMDRichStorageItems* FItems;
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDRichStorage(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRichStorage(void);
	void __fastcall RegisterChanges(TLMDRTFChangeLink* aValue);
	void __fastcall UnRegisterChanges(TLMDRTFChangeLink* aValue);
	__property int Count = {read=GetCount, nodefault};
	
__published:
	__property TLMDRichStorageItems* Items = {read=GetItems, write=FItems};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfstorage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFSTORAGE)
using namespace Lmdrtfstorage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfstorageHPP
