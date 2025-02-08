// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFHyperTextStorage.pas' rev: 31.00 (Windows)

#ifndef LmdrtfhypertextstorageHPP
#define LmdrtfhypertextstorageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDRTFBase.hpp>
#include <LMDRTFStorage.hpp>
#include <LMDRTFHyperText.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfhypertextstorage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichHyperTextStorageItem;
class DELPHICLASS TLMDRichHyperTextStorageItems;
class DELPHICLASS TLMDRichHyperTextStorage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichHyperTextStorageItem : public Lmdrtfstorage::TLMDRichStorageItem
{
	typedef Lmdrtfstorage::TLMDRichStorageItem inherited;
	
public:
	DYNAMIC void __fastcall DoLinkClick(System::TObject* aSender, const System::UnicodeString aURLText, System::Uitypes::TMouseButton aButton);
	__fastcall virtual TLMDRichHyperTextStorageItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDRichHyperTextStorageItem(void);
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRichHyperTextStorageItems : public Lmdrtfstorage::TLMDRichStorageItems
{
	typedef Lmdrtfstorage::TLMDRichStorageItems inherited;
	
public:
	TLMDRichHyperTextStorageItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	int __fastcall GetItemByName(const System::UnicodeString index);
	
protected:
	HIDESBASE TLMDRichHyperTextStorageItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDRichHyperTextStorageItem* const Value);
	HIDESBASE TLMDRichHyperTextStorage* __fastcall GetStorage(void);
	__classmethod virtual System::Classes::TCollectionItemClass __fastcall GetItemClass();
	
public:
	HIDESBASE TLMDRichHyperTextStorageItem* __fastcall Add(void);
	__property TLMDRichHyperTextStorageItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int ItemByName[const System::UnicodeString index] = {read=GetItemByName};
	__property TLMDRichHyperTextStorage* Storage = {read=GetStorage};
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDRichHyperTextStorageItems(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : Lmdrtfstorage::TLMDRichStorageItems(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDRichHyperTextStorageItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDRichHyperTextStorage : public Lmdrtfstorage::TLMDRichStorage
{
	typedef Lmdrtfstorage::TLMDRichStorage inherited;
	
private:
	Lmdrtfhypertext::TLMDRichHyperText* FHyperText;
	HIDESBASE TLMDRichHyperTextStorageItems* __fastcall GetItems(void);
	void __fastcall SetItems(TLMDRichHyperTextStorageItems* const Value);
	
public:
	__fastcall virtual TLMDRichHyperTextStorage(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRichHyperTextStorage(void);
	int __fastcall GetNamedIndex(const System::UnicodeString aValue);
	__property Lmdrtfhypertext::TLMDRichHyperText* HyperText = {read=FHyperText};
	
__published:
	__property TLMDRichHyperTextStorageItems* Items = {read=GetItems, write=SetItems};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfhypertextstorage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFHYPERTEXTSTORAGE)
using namespace Lmdrtfhypertextstorage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfhypertextstorageHPP
