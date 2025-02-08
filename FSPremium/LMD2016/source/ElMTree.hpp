// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElMTree.pas' rev: 31.00 (Windows)

#ifndef ElmtreeHPP
#define ElmtreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDObjectList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elmtree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElMTreeItem;
class DELPHICLASS TElMTree;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TElMTreeItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElMTreeItem* FParent;
	void *FData;
	Lmdobjectlist::TLMDObjectList* FList;
	int FTag;
	
public:
	virtual void __fastcall MoveTo(TElMTreeItem* NewParent);
	virtual void __fastcall MoveToIns(TElMTreeItem* NewParent, int AnIndex);
	__property TElMTreeItem* Parent = {read=FParent, write=FParent};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property void * Data = {read=FData, write=FData};
	__property Lmdobjectlist::TLMDObjectList* List = {read=FList, write=FList};
public:
	/* TObject.Create */ inline __fastcall TElMTreeItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TElMTreeItem(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (*TIterProc)(TElMTreeItem* Item, int Index, bool &ContinueIterate, void * IterateData);

typedef void __fastcall (__closure *TItemSaveEvent)(System::TObject* Sender, TElMTreeItem* Item, System::Classes::TStream* Stream);

typedef void __fastcall (__closure *TElMTreeItemDelete)(System::TObject* Sender, TElMTreeItem* Item, void * Data);

class PASCALIMPLEMENTATION TElMTree : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElMTreeItem* FRoot;
	int FCount;
	TItemSaveEvent FOnItemSave;
	TItemSaveEvent FOnItemLoad;
	TElMTreeItemDelete FOnItemDelete;
	TElMTreeItem* __fastcall GetItem(int index);
	
protected:
	virtual void __fastcall TriggerItemSaveEvent(TElMTreeItem* Item, System::Classes::TStream* Stream);
	virtual void __fastcall TriggerItemLoadEvent(TElMTreeItem* Item, System::Classes::TStream* Stream);
	virtual void __fastcall TriggerItemDeleteEvent(TElMTreeItem* Item, void * Data);
	
public:
	__fastcall TElMTree(void);
	__fastcall virtual ~TElMTree(void);
	virtual TElMTreeItem* __fastcall AddItem(TElMTreeItem* Parent, void * Value);
	virtual TElMTreeItem* __fastcall InsertItem(TElMTreeItem* Parent, int Index, void * Value);
	void __fastcall DeleteItem(TElMTreeItem* Item);
	void __fastcall MoveTo(TElMTreeItem* Item, TElMTreeItem* NewParent);
	virtual void __fastcall Clear(void);
	int __fastcall GetIndex(TElMTreeItem* Item);
	int __fastcall GetAbsIndex(TElMTreeItem* Item);
	TElMTreeItem* __fastcall GetNextSibling(TElMTreeItem* Item);
	void __fastcall Iterate(TIterProc IterateProc, void * IterateData);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveSubTreeToStream(TElMTreeItem* Item, System::Classes::TStream* Stream, bool ReadRoot = true);
	virtual void __fastcall LoadSubTreeFromStream(TElMTreeItem* Item, System::Classes::TStream* Stream, bool ReadRoot = true);
	void __fastcall MoveToIns(TElMTreeItem* Item, TElMTreeItem* NewParent, int Index);
	TElMTreeItem* __fastcall FindData(void * Data);
	int __fastcall GetLevel(TElMTreeItem* Item);
	__property int Count = {read=FCount, nodefault};
	__property TElMTreeItem* Item[int index] = {read=GetItem};
	__property TItemSaveEvent OnItemSave = {read=FOnItemSave, write=FOnItemSave};
	__property TItemSaveEvent OnItemLoad = {read=FOnItemLoad, write=FOnItemLoad};
	__property TElMTreeItemDelete OnItemDelete = {read=FOnItemDelete, write=FOnItemDelete};
	__property TElMTreeItem* Root = {read=FRoot};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elmtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELMTREE)
using namespace Elmtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElmtreeHPP
