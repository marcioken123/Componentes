// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDList.pas' rev: 34.00 (Windows)

#ifndef LmdlistHPP
#define LmdlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDBuffer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlist
{
//-- forward type declarations -----------------------------------------------
struct TLMDBiDynNode;
class DELPHICLASS TLMDList;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDCompareItemEvent)(System::TObject* Sender, int item1, int item2, int result);

typedef TLMDBiDynNode *PLMDBiDynNode;

struct DECLSPEC_DRECORD TLMDBiDynNode
{
public:
	void *item;
	TLMDBiDynNode *next;
	TLMDBiDynNode *prev;
};


class PASCALIMPLEMENTATION TLMDList : public Lmdbuffer::TLMDBuffer
{
	typedef Lmdbuffer::TLMDBuffer inherited;
	
public:
	void * operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDBiDynNode *FCurrent;
	TLMDBiDynNode *FLast;
	TLMDBiDynNode *FRoot;
	TLMDCompareItemEvent FOnCompareItem;
	PLMDBiDynNode __fastcall AllocNode();
	void __fastcall FreeNode(PLMDBiDynNode Node);
	
protected:
	virtual void __fastcall FirstNode(void * &node);
	virtual void __fastcall NextNode(void * &node);
	virtual void * __fastcall GetItem(void * node);
	virtual bool __fastcall EOFBuffer(void * node);
	void __fastcall SetItem(int index, void * item);
	
public:
	__fastcall virtual TLMDList(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDList();
	System::TObject* __fastcall Item();
	void __fastcall First();
	void __fastcall Next();
	void __fastcall Last();
	void __fastcall Prev();
	bool __fastcall IsLast();
	void __fastcall Seek(int index);
	virtual bool __fastcall IsEmpty();
	virtual bool __fastcall IsFull();
	virtual void __fastcall Put(void * item);
	virtual void * __fastcall Get();
	int __fastcall IndexOf(void * aItem);
	void __fastcall Remove(void * aItem);
	void * __fastcall LastItem();
	void * __fastcall Extract();
	void * __fastcall ExtractByNr(int index);
	void * __fastcall GetItemByNr(int index);
	void __fastcall Delete();
	void __fastcall Add(void * item);
	void __fastcall Prepend(void * Item);
	void __fastcall Insert(void * Item);
	void __fastcall InsertAt(void * Item, int index);
	virtual void __fastcall Clear();
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	__property void * Items[int Index] = {read=GetItemByNr, write=SetItem/*, default*/};
	__property TLMDCompareItemEvent OnCompareItem = {read=FOnCompareItem, write=FOnCompareItem};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLIST)
using namespace Lmdlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlistHPP
