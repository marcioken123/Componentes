// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHashTable.pas' rev: 34.00 (Windows)

#ifndef LmdhashtableHPP
#define LmdhashtableHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDProcs.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhashtable
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHashTableTraits;
class DELPHICLASS TLMDHashTableColl;
class DELPHICLASS TLMDHashTable;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDHashTableTraitsClass;

enum DECLSPEC_DENUM TLMDHashUpdateAction : unsigned char { uaDelete, uaNothing };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHashTableTraits : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod virtual bool __fastcall BeforeAdd(System::TObject* AItem, TLMDHashTable* ATable);
	__classmethod virtual int __fastcall MakeHashI(System::TObject* AItem);
	__classmethod virtual int __fastcall MakeHashK(const void *AKey);
	__classmethod virtual bool __fastcall Compare(const void *AKey, System::TObject* AItem);
	__classmethod virtual TLMDHashUpdateAction __fastcall OnUpdate(System::TObject* AItem);
public:
	/* TObject.Create */ inline __fastcall TLMDHashTableTraits() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDHashTableTraits() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHashTableColl : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::TObject* Item;
	System::TObject* Next;
public:
	/* TObject.Create */ inline __fastcall TLMDHashTableColl() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDHashTableColl() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDHashTableItemProc)(System::TObject* AItem);

typedef void __fastcall (__closure *TLMDHashTableItemProcEx)(System::TObject* AItem, void * AUserData);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHashTable : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<System::TObject*> _TLMDHashTable__1;
	
	
private:
	TLMDHashTableTraitsClass FTraits;
	bool FOwnItems;
	_TLMDHashTable__1 FItems;
	int FIndexMask;
	int FCount;
	void __fastcall Grow(int AOldLength);
	void __fastcall Rehash(int AOldLength);
	void __fastcall InsertItem(System::TObject* AItem);
	TLMDHashTableColl* __fastcall CreateColl(System::TObject* AItem, System::TObject* ANext);
	bool __fastcall DecodeEntry(System::TObject* ACur, /* out */ System::TObject* &AItem, /* out */ System::TObject* &ANext, /* out */ bool &AIsCol);
	
public:
	__fastcall TLMDHashTable(TLMDHashTableTraitsClass ATraits, bool AOwnItems);
	__fastcall virtual ~TLMDHashTable();
	__classmethod int __fastcall IntHash(int AKey);
	__classmethod int __fastcall PtrHash(void * AKey);
	__classmethod int __fastcall StrHash(const Lmdtypes::TLMDString AKey);
	void __fastcall Clear();
	bool __fastcall Add(System::TObject* AItem);
	bool __fastcall Remove(const void *AKey);
	System::TObject* __fastcall Find(const void *AKey);
	void __fastcall GetAll(System::Classes::TList* AResult)/* overload */;
	void __fastcall GetAll(TLMDHashTableItemProc AProc)/* overload */;
	void __fastcall GetAll(TLMDHashTableItemProcEx AProc, void * AUserData)/* overload */;
	void __fastcall Update();
	__property int Count = {read=FCount, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhashtable */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHASHTABLE)
using namespace Lmdhashtable;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhashtableHPP
