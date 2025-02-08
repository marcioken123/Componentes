// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHASHList.pas' rev: 31.00 (Windows)

#ifndef LmdhashlistHPP
#define LmdhashlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhashlist
{
//-- forward type declarations -----------------------------------------------
struct TLMDHashItem;
class DELPHICLASS TLMDHashStringList;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDHashItem
{
public:
	System::UnicodeString Name;
	System::TObject* pObj;
};
#pragma pack(pop)


typedef System::DynamicArray<TLMDHashItem> TLMDHashItems;

typedef System::StaticArray<TLMDHashItems, 2048> TLMDHashArray;

typedef TLMDHashArray *PHashArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHashStringList : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	NativeUInt FHashHandle;
	TLMDHashArray *FHashTable;
	int __fastcall GetCount(void);
	int __fastcall InternalIndexOf(const System::UnicodeString Str, const TLMDHashItems Items);
	int __fastcall InternalIndexOfObject(System::TObject* pObj, const TLMDHashItems Items);
	
public:
	__fastcall TLMDHashStringList(void);
	__fastcall virtual ~TLMDHashStringList(void);
	void __fastcall AddObject(const System::UnicodeString Str, System::TObject* Obj);
	int __fastcall FindObject(const System::UnicodeString Str, System::TObject* &Obj);
	System::TObject* __fastcall GetObject(const System::UnicodeString Str);
	int __fastcall IndexOf(const System::UnicodeString Str);
	int __fastcall IndexOfObject(System::TObject* const Obj, System::Word &Hash);
	void __fastcall Delete(const System::Word Hash, int Index);
	__classmethod System::Word __fastcall GetHash(const System::UnicodeString Str);
	__property PHashArray HashTable = {read=FHashTable};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word HASHTABLE_SIZE = System::Word(0x7ff);
}	/* namespace Lmdhashlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHASHLIST)
using namespace Lmdhashlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhashlistHPP
