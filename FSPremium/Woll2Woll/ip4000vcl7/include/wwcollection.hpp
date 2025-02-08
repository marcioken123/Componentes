// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwCollection.pas' rev: 6.00

#ifndef wwCollectionHPP
#define wwCollectionHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysUtils.hpp>	// Pascal unit
#include <ActiveX.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwcollection
{
//-- type declarations -------------------------------------------------------
__interface IwwCollectionItem;
typedef System::DelphiInterface<IwwCollectionItem> _di_IwwCollectionItem;
typedef void __fastcall (__closure *TwwUpdateNameEvent)(_di_IwwCollectionItem Item);

typedef void __fastcall (__closure *TwwSelectionMethod)(_di_IwwCollectionItem Item);

__interface IwwNavButtons;
typedef System::DelphiInterface<IwwNavButtons> _di_IwwNavButtons;
__interface  INTERFACE_UUID("{BCDB6D20-2D56-11D2-A5AC-00104B216B5B}") IwwNavButtons  : public IInterface 
{
	
public:
	virtual void __fastcall AddInfoPowerDialogs(void) = 0 ;
};

__interface IwwCollection;
typedef System::DelphiInterface<IwwCollection> _di_IwwCollection;
__interface  INTERFACE_UUID("{D4CC0381-0B8D-11D2-A5AC-00104B216B5B}") IwwCollectionItem  : public IInterface 
{
	
public:
	virtual _di_IwwCollection __fastcall GetCollection(void) = 0 ;
	virtual AnsiString __fastcall GetDisplayName(void) = 0 ;
	virtual int __fastcall GetIndex(void) = 0 ;
	virtual Classes::TPersistent* __fastcall GetInstance(void) = 0 ;
	virtual void __fastcall SetIndex(int Value) = 0 ;
	__property int Index = {read=GetIndex, write=SetIndex};
	virtual void __fastcall SetOnUpdateName(TwwUpdateNameEvent Value) = 0 ;
	virtual void __fastcall SetSelectionMethod(TwwSelectionMethod Value) = 0 ;
	__property TwwUpdateNameEvent OnUpdateName = {write=SetOnUpdateName};
	__property TwwSelectionMethod SelectionMethod = {write=SetSelectionMethod};
};

__interface  INTERFACE_UUID("{D4CC0380-0B8D-11D2-A5AC-00104B216B5B}") IwwCollection  : public IInterface 
{
	
public:
	virtual int __fastcall GetCount(void) = 0 ;
	virtual _di_IwwCollectionItem __fastcall GetItem(int Index) = 0 ;
	virtual _di_IwwCollectionItem __fastcall Add(void) = 0 ;
	virtual void __fastcall BeginUpdate(void) = 0 ;
	virtual void __fastcall Clear(void) = 0 ;
	virtual void __fastcall EndUpdate(void) = 0 ;
	virtual void __fastcall SetDesigner(Controls::TControl* Value) = 0 ;
	__property int Count = {read=GetCount};
	__property Controls::TControl* Designer = {write=SetDesigner};
	__property _di_IwwCollectionItem Items[int Index] = {read=GetItem};
};

class DELPHICLASS TwwCollectionItem;
class PASCALIMPLEMENTATION TwwCollectionItem : public Classes::TCollectionItem 
{
	typedef Classes::TCollectionItem inherited;
	
public:
	int __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef(void);
	int __stdcall _Release(void);
public:
	#pragma option push -w-inl
	/* TCollectionItem.Create */ inline __fastcall virtual TwwCollectionItem(Classes::TCollection* Collection) : Classes::TCollectionItem(Collection) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TwwCollectionItem(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwCollection;
class PASCALIMPLEMENTATION TwwCollection : public Classes::TCollection 
{
	typedef Classes::TCollection inherited;
	
public:
	int __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	int __stdcall _AddRef(void);
	int __stdcall _Release(void);
public:
	#pragma option push -w-inl
	/* TCollection.Create */ inline __fastcall TwwCollection(TMetaClass* ItemClass) : Classes::TCollection(ItemClass) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TCollection.Destroy */ inline __fastcall virtual ~TwwCollection(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwCollection)

}	/* namespace Wwcollection */
using namespace Wwcollection;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwCollection
