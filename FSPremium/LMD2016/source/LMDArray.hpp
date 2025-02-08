// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDArray.pas' rev: 34.00 (Windows)

#ifndef LmdarrayHPP
#define LmdarrayHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <LMDRTLConst.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdarray
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDArray;
//-- type declarations -------------------------------------------------------
typedef int __fastcall (*TLMDArraySortCompare)(void * Item1, void * Item2, void * Cargo);

typedef void __fastcall (__closure *TLMDArrayDeleteEvent)(System::TObject* Sender, void * Item);

class PASCALIMPLEMENTATION TLMDArray : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	void * operator[](int Index) { return this->Items[Index]; }
	
protected:
	Lmdtypes::TPointerList *FList;
	int FCount;
	int FCapacity;
	bool FAutoClearObjects;
	TLMDArrayDeleteEvent FOnDelete;
	virtual void * __fastcall Get(int Index);
	virtual void __fastcall Grow();
	virtual void __fastcall Put(int Index, const void * Item);
	void __fastcall SetCapacity(int NewCapacity);
	void __fastcall SetCount(int NewCount);
	virtual void __fastcall TriggerDeleteEvent(const void * Item);
	__classmethod void __fastcall Error(const System::UnicodeString Msg, int Data);
	
public:
	__fastcall TLMDArray();
	__fastcall virtual ~TLMDArray();
	void __fastcall CheckRange(int Index);
	int __fastcall Add(const void * Item);
	void __fastcall Clear();
	void __fastcall Assign(TLMDArray* AList);
	virtual void __fastcall Delete(int Index);
	void __fastcall Exchange(int Index1, int Index2);
	TLMDArray* __fastcall Expand();
	void * __fastcall First();
	int __fastcall IndexOf(const void * Item);
	int __fastcall IndexOfFrom(int StartIndex, const void * Item);
	int __fastcall IndexOfBack(int StartIndex, const void * Item);
	void __fastcall Insert(int Index, const void * Item);
	void * __fastcall Last();
	void __fastcall Move(int CurIndex, int NewIndex);
	void __fastcall MoveRange(int CurStart, int CurEnd, int NewStart);
	int __fastcall Remove(const void * Item);
	void __fastcall Pack();
	void __fastcall Sort(TLMDArraySortCompare Compare, const void * Cargo);
	__property int Capacity = {read=FCapacity, write=SetCapacity, default=0};
	__property int Count = {read=FCount, write=SetCount, default=0};
	__property void * Items[int Index] = {read=Get, write=Put/*, default*/};
	__property Lmdtypes::PPointerList List = {read=FList};
	__property bool AutoClearObjects = {read=FAutoClearObjects, write=FAutoClearObjects, default=0};
	__property TLMDArrayDeleteEvent OnDelete = {read=FOnDelete, write=FOnDelete};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdarray */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDARRAY)
using namespace Lmdarray;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdarrayHPP
