// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysNetworkEnumerator.pas' rev: 31.00 (Windows)

#ifndef LmdsysnetworkenumeratorHPP
#define LmdsysnetworkenumeratorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysNetTreeView.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysnetworkenumerator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysNetItem;
class DELPHICLASS TLMDSysNetItems;
class DELPHICLASS TLMDSysNetThread;
class DELPHICLASS TLMDSysNetworkEnumerator;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysNetDisplay : unsigned char { ndDomain, ndGeneric, ndServer, ndShare, ndFile, ndGroup, ndNetwork, ndRoot, ndShareAdmin, ndDirectory, ndTree, ndNDSContainer };

enum DECLSPEC_DENUM TLMDSysNetScope : unsigned char { nsGlobal, nsContext, nsConnected, nsRemembered, nsRecent };

enum DECLSPEC_DENUM TLMDSysNetResourceType : unsigned char { nrAny, nrDisk, nrPrint };

enum DECLSPEC_DENUM TLMDSysNetUsage : unsigned char { nuConnectable, nuContainer };

typedef System::Set<TLMDSysNetUsage, TLMDSysNetUsage::nuConnectable, TLMDSysNetUsage::nuContainer> TLMDSysNetUsages;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysNetItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDSysNetScope FScope;
	TLMDSysNetResourceType FResourceType;
	TLMDSysNetDisplay FDisplay;
	TLMDSysNetUsages FUsage;
	int FIndex;
	System::UnicodeString FLocalName;
	System::UnicodeString FRemoteName;
	System::UnicodeString FComment;
	System::UnicodeString FProvider;
	TLMDSysNetItems* FSubItems;
	
public:
	__fastcall TLMDSysNetItem(void);
	__fastcall virtual ~TLMDSysNetItem(void);
	__property System::UnicodeString Comment = {read=FComment};
	__property TLMDSysNetDisplay Display = {read=FDisplay, nodefault};
	__property int Index = {read=FIndex, nodefault};
	__property System::UnicodeString LocalName = {read=FLocalName};
	__property System::UnicodeString Provider = {read=FProvider};
	__property TLMDSysNetItems* SubItems = {read=FSubItems};
	__property TLMDSysNetScope Scope = {read=FScope, nodefault};
	__property System::UnicodeString RemoteName = {read=FRemoteName};
	__property TLMDSysNetResourceType ResourceType = {read=FResourceType, nodefault};
	__property TLMDSysNetUsages Usage = {read=FUsage, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSysNetItems : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDSysNetItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TList* FList;
	void __fastcall SetItem(int Index, TLMDSysNetItem* Value);
	TLMDSysNetItem* __fastcall GetItem(int Index);
	int __fastcall GetCount(void);
	
public:
	__fastcall TLMDSysNetItems(void);
	__fastcall virtual ~TLMDSysNetItems(void);
	void __fastcall Clear(void);
	void __fastcall Add(TLMDSysNetItem* Item);
	void __fastcall Delete(int Index);
	__property TLMDSysNetItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDSysNetItemEvent)(System::TObject* Sender, TLMDSysNetItem* anItem);

class PASCALIMPLEMENTATION TLMDSysNetThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	Vcl::Comctrls::TTreeNode* FTreeNode;
	TLMDSysNetworkEnumerator* Parent;
	TLMDSysNetItem* NewItem;
	TLMDSysNetItemEvent FOnEnumItem;
	
protected:
	virtual void __fastcall Execute(void);
	void __fastcall DoItemEvent(void);
	
public:
	void __fastcall AddNode(void);
	void __fastcall EnumNodes(TLMDSysNetItems* NetItems, Winapi::Windows::PNetResourceW lpnr);
	__fastcall TLMDSysNetThread(TLMDSysNetworkEnumerator* Owner);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TLMDSysNetThread(void) { }
	
};


class PASCALIMPLEMENTATION TLMDSysNetworkEnumerator : public Lmdsysbase::TLMDSysComponent
{
	typedef Lmdsysbase::TLMDSysComponent inherited;
	
public:
	TLMDSysNetItem* operator[](int Index) { return this->ItemIdx[Index]; }
	
private:
	TLMDSysNetItems* FItems;
	System::Classes::TList* FInternal;
	TLMDSysNetScope FScope;
	TLMDSysNetResourceType FResourceType;
	TLMDSysNetUsages FUsage;
	Lmdsysnettreeview::TLMDSysNetTreeView* FTree;
	TLMDSysNetThread* FThread;
	bool FAuto;
	bool FThreaded;
	bool FShowRoot;
	Vcl::Comctrls::TTreeNode* FTreeNode;
	System::Classes::TNotifyEvent FOnEnumStart;
	System::Classes::TNotifyEvent FOnEnumEnd;
	TLMDSysNetItemEvent FOnEnumItem;
	TLMDSysNetItem* __fastcall GetItem(int Index);
	bool __fastcall CheckStates(void);
	void __fastcall SetTreeView(Lmdsysnettreeview::TLMDSysNetTreeView* const Value);
	void __fastcall SetThreaded(const bool Value);
	void __fastcall ThreadDone(System::TObject* Sender);
	void __fastcall SetScope(const TLMDSysNetScope Value);
	void __fastcall SetUsage(const TLMDSysNetUsages Value);
	void __fastcall SetResourceType(const TLMDSysNetResourceType Value);
	void __fastcall SetShowRoot(const bool Value);
	int __fastcall GetIdxCount(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall AssignValues(Vcl::Comctrls::TTreeNode* Target, TLMDSysNetItem* Value);
	void __fastcall EnumerateNet(TLMDSysNetItems* NetItems, Winapi::Windows::PNetResourceW lpnr);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDSysNetworkEnumerator(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSysNetworkEnumerator(void);
	void __fastcall Clear(void);
	void __fastcall Refresh(void);
	void __fastcall CancelThread(void);
	__property TLMDSysNetItem* ItemIdx[int Index] = {read=GetItem/*, default*/};
	__property int ItemIdxCount = {read=GetIdxCount, nodefault};
	__property TLMDSysNetItems* Items = {read=FItems};
	
__published:
	__property bool AutoRetrieve = {read=FAuto, write=FAuto, default=1};
	__property Lmdsysnettreeview::TLMDSysNetTreeView* DisplayControl = {read=FTree, write=SetTreeView};
	__property TLMDSysNetScope Scope = {read=FScope, write=SetScope, default=0};
	__property TLMDSysNetResourceType ResourceType = {read=FResourceType, write=SetResourceType, default=0};
	__property bool ShowRoot = {read=FShowRoot, write=SetShowRoot, default=0};
	__property TLMDSysNetUsages Usage = {read=FUsage, write=SetUsage, default=0};
	__property bool Threaded = {read=FThreaded, write=SetThreaded, default=0};
	__property System::Classes::TNotifyEvent OnEnumStart = {read=FOnEnumStart, write=FOnEnumStart};
	__property System::Classes::TNotifyEvent OnEnumEnd = {read=FOnEnumEnd, write=FOnEnumEnd};
	__property TLMDSysNetItemEvent OnEnumItem = {read=FOnEnumItem, write=FOnEnumItem};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysnetworkenumerator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSNETWORKENUMERATOR)
using namespace Lmdsysnetworkenumerator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysnetworkenumeratorHPP
