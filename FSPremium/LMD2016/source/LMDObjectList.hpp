// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDObjectList.pas' rev: 34.00 (Windows)

#ifndef LmdobjectlistHPP
#define LmdobjectlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDRTLConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdobjectlist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDObjectList;
class DELPHICLASS TLMDInterfacedObjectList;
//-- type declarations -------------------------------------------------------
typedef int __fastcall (*TLMDListSortCompare)(void * Item1, void * Item2, void * Cargo);

typedef int __fastcall (__closure *TLMDListSortCompareEx)(void * Item1, void * Item2, void * Cargo);

typedef void __fastcall (__closure *TLMDListDeleteEvent)(System::TObject* Sender, void * &Item);

class PASCALIMPLEMENTATION TLMDObjectList : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	void * operator[](int Index) { return this->Items[Index]; }
	
protected:
	bool FAutoClearObjects;
	int FCapacity;
	int FCount;
	Lmdtypes::TPointerList *FList;
	TLMDListDeleteEvent FOnDelete;
	__classmethod void __fastcall Error(const System::UnicodeString Msg, int Data);
	virtual void * __fastcall Get(int Index);
	virtual void __fastcall Grow();
	virtual void __fastcall Put(int Index, const void * Item);
	void __fastcall SetCapacity(int NewCapacity);
	void __fastcall SetCount(int NewCount);
	void __fastcall IntDelete(int Index);
	virtual void __fastcall TriggerDeleteEvent(void * Item, int Index);
	
public:
	__fastcall TLMDObjectList();
	__fastcall virtual ~TLMDObjectList();
	void __fastcall CheckRange(int Index);
	void * __fastcall FastGet(int Index);
	int __fastcall Add(const void * Item);
	int __fastcall AddAndCheckDuplicates(const void * Item);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Clear();
	virtual void __fastcall Delete(int Index);
	virtual void __fastcall DeleteRange(int StartIndex, int EndIndex);
	void __fastcall Exchange(int Index1, int Index2);
	TLMDObjectList* __fastcall Expand();
	void * __fastcall First();
	int __fastcall IndexOf(const void * Item);
	int __fastcall IndexOfBack(int StartIndex, const void * Item);
	int __fastcall IndexOfFrom(int StartIndex, const void * Item);
	void __fastcall Insert(int Index, const void * Item);
	void * __fastcall Last();
	void __fastcall Move(int CurIndex, int NewIndex);
	void __fastcall MoveRange(int CurStart, int CurEnd, int NewStart);
	void __fastcall Pack();
	int __fastcall Remove(const void * Item);
	void __fastcall Sort(TLMDListSortCompare Compare, const void * Cargo);
	void __fastcall SortC(TLMDListSortCompareEx Compare, const void * Cargo);
	__property bool AutoClearObjects = {read=FAutoClearObjects, write=FAutoClearObjects, nodefault};
	__property int Capacity = {read=FCapacity, write=SetCapacity, nodefault};
	__property int Count = {read=FCount, write=SetCount, nodefault};
	__property void * Items[int Index] = {read=Get, write=Put/*, default*/};
	__property Lmdtypes::PPointerList List = {read=FList};
	__property TLMDListDeleteEvent OnDelete = {read=FOnDelete, write=FOnDelete};
};


class PASCALIMPLEMENTATION TLMDInterfacedObjectList : public TLMDObjectList
{
	typedef TLMDObjectList inherited;
	
private:
	System::_di_IInterface FOwnerInterface;
	
protected:
	int __stdcall _AddRef();
	int __stdcall _Release();
	
public:
	virtual HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	virtual void __fastcall AfterConstruction();
public:
	/* TLMDObjectList.Create */ inline __fastcall TLMDInterfacedObjectList() : TLMDObjectList() { }
	/* TLMDObjectList.Destroy */ inline __fastcall virtual ~TLMDInterfacedObjectList() { }
	
private:
	void *__IInterface;	// System::IInterface 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__IInterface; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word AlignMem = System::Word(0x500);
}	/* namespace Lmdobjectlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDOBJECTLIST)
using namespace Lmdobjectlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdobjectlistHPP
