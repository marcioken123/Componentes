// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDObjectStorage.pas' rev: 31.00 (Windows)

#ifndef LmdobjectstorageHPP
#define LmdobjectstorageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Win.Registry.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Forms.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDZLib.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdobjectstorage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormEventsHook;
class DELPHICLASS TLMDPropertyStorageItem;
class DELPHICLASS TLMDPropertyStorage;
class DELPHICLASS TLMDCustomObjectStorage;
class DELPHICLASS TLMDObjectStorage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormEventsHook : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FEnabled;
	bool FHandled;
	System::Classes::TNotifyEvent FOwnerFormCreate;
	System::Classes::TNotifyEvent FOwnerFormDestroy;
	System::Classes::TNotifyEvent FOnLoading;
	System::Classes::TNotifyEvent FOnSaving;
	Vcl::Forms::TCloseQueryEvent FOwnerFormClose;
	Vcl::Forms::TForm* __fastcall GetOwnerForm(void);
	void __fastcall OwnerFormCreate(System::TObject* Sender);
	void __fastcall OwnerFormDestroy(System::TObject* Sender);
	void __fastcall OwnerFormClose(System::TObject* Sender, bool &CanClose);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall RestoreEvents(void);
	void __fastcall SetEvents(void);
	DYNAMIC void __fastcall DoOnLoading(void);
	DYNAMIC void __fastcall DoOnSaving(void);
	
public:
	__fastcall virtual TLMDFormEventsHook(System::Classes::TComponent* aOwner);
	__property Vcl::Forms::TForm* Form = {read=GetOwnerForm};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property System::Classes::TNotifyEvent OnLoading = {read=FOnLoading, write=FOnLoading};
	__property System::Classes::TNotifyEvent OnSaving = {read=FOnSaving, write=FOnSaving};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDFormEventsHook(void) { }
	
};


enum DECLSPEC_DENUM TLMDRegRoot : unsigned char { rrCurrentUser, rrLocalMachine };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyStorageItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::UnicodeString FComponentName;
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetComponentName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TLMDPropertyStorageItem(System::Classes::TCollection* Collection);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::UnicodeString ComponentName = {read=FComponentName, write=SetComponentName};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDPropertyStorageItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPropertyStorage : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDPropertyStorageItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDPropertyStorageItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TLMDPropertyStorage(System::Classes::TPersistent* AOwner);
	HIDESBASE TLMDPropertyStorageItem* __fastcall Add(void);
	TLMDPropertyStorageItem* __fastcall FindItem(System::UnicodeString szComponent, System::UnicodeString szProperty);
	__property TLMDPropertyStorageItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDPropertyStorage(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCustomObjectStorage : public TLMDFormEventsHook
{
	typedef TLMDFormEventsHook inherited;
	
private:
	bool FCompressed;
	System::UnicodeString FRegistryPath;
	TLMDRegRoot FRegistryKey;
	TLMDPropertyStorage* FPropertyStorage;
	void __fastcall SetRegistryPath(const System::UnicodeString Value);
	void __fastcall SetRegistryKey(const TLMDRegRoot Value);
	void __fastcall SaveToRegistry(void);
	void __fastcall LoadFromRegistry(void);
	void __fastcall ClearRegistry(void);
	void __fastcall ReadBoolean(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC void __fastcall DoOnLoading(void);
	DYNAMIC void __fastcall DoOnSaving(void);
	__property bool Compressed = {read=FCompressed, write=FCompressed, default=0};
	__property System::UnicodeString RegistryPath = {read=FRegistryPath, write=SetRegistryPath};
	__property TLMDRegRoot RegistryKey = {read=FRegistryKey, write=SetRegistryKey, nodefault};
	__property TLMDPropertyStorage* Properties = {read=FPropertyStorage, write=FPropertyStorage};
	
public:
	__fastcall virtual TLMDCustomObjectStorage(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomObjectStorage(void);
	void __fastcall ClearData(void);
	void __fastcall Load(void);
	void __fastcall Save(void);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual bool __fastcall LoadFromFile(const System::UnicodeString szFileName);
	virtual bool __fastcall SaveToFile(const System::UnicodeString szFileName);
};


class PASCALIMPLEMENTATION TLMDObjectStorage : public TLMDCustomObjectStorage
{
	typedef TLMDCustomObjectStorage inherited;
	
__published:
	__property About = {default=0};
	__property Enabled = {default=1};
	__property Properties;
	__property Compressed = {default=0};
	__property RegistryPath = {default=0};
	__property RegistryKey;
	__property OnLoading;
	__property OnSaving;
public:
	/* TLMDCustomObjectStorage.Create */ inline __fastcall virtual TLMDObjectStorage(System::Classes::TComponent* aOwner) : TLMDCustomObjectStorage(aOwner) { }
	/* TLMDCustomObjectStorage.Destroy */ inline __fastcall virtual ~TLMDObjectStorage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdobjectstorage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDOBJECTSTORAGE)
using namespace Lmdobjectstorage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdobjectstorageHPP
