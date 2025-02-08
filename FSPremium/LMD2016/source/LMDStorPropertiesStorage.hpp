// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorPropertiesStorage.pas' rev: 31.00 (Windows)

#ifndef LmdstorpropertiesstorageHPP
#define LmdstorpropertiesstorageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Consts.hpp>
#include <System.Variants.hpp>
#include <LMDStorBase.hpp>
#include <LMDStorFormHook.hpp>
#include <LMDStorCommon.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorpropertiesstorage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorPropertyStorageItem;
class DELPHICLASS TLMDStorPropertyStorageItems;
class DELPHICLASS TLMDStorCustomProperty;
class DELPHICLASS TLMDStorCustomProperties;
class DELPHICLASS TLMDStorCustomPropertiesStorage;
class DELPHICLASS TLMDStorPropertiesStorage;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorPropertyStorageItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FPropertyName;
	System::UnicodeString FComponentName;
	void __fastcall SetPropertyName(const System::UnicodeString Value);
	void __fastcall SetComponentName(const System::UnicodeString Value);
	
public:
	__fastcall virtual TLMDStorPropertyStorageItem(System::Classes::TCollection* Collection);
	
__published:
	__property System::UnicodeString PropertyName = {read=FPropertyName, write=SetPropertyName};
	__property System::UnicodeString ComponentName = {read=FComponentName, write=SetComponentName};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDStorPropertyStorageItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorPropertyStorageItems : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDStorPropertyStorageItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDStorPropertyStorageItem* __fastcall GetItems(int Index);
	
public:
	__fastcall TLMDStorPropertyStorageItems(System::Classes::TPersistent* AOwner);
	HIDESBASE TLMDStorPropertyStorageItem* __fastcall Add(void);
	TLMDStorPropertyStorageItem* __fastcall FindItem(System::UnicodeString szComponent, System::UnicodeString szProperty);
	__property TLMDStorPropertyStorageItem* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDStorPropertyStorageItems(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDStorCustomProperty : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	System::Variant FValue;
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall SetValue(const System::Variant &Value);
	
public:
	__fastcall virtual TLMDStorCustomProperty(System::Classes::TCollection* Collection);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property System::Variant Value = {read=FValue, write=SetValue};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDStorCustomProperty(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStorCustomProperties : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDStorCustomProperty* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TPersistent* FOwner;
	TLMDStorCustomProperty* __fastcall GetItems(int Index);
	
protected:
	HIDESBASE System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	__fastcall TLMDStorCustomProperties(System::Classes::TPersistent* AOwner);
	HIDESBASE TLMDStorCustomProperty* __fastcall Add(void);
	TLMDStorCustomProperty* __fastcall FindItem(System::UnicodeString Name);
	__property TLMDStorCustomProperty* Items[int Index] = {read=GetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDStorCustomProperties(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDNotFoundEventNotify)(System::TObject* Sender, const System::UnicodeString CompName, bool &RaiseException);

class PASCALIMPLEMENTATION TLMDStorCustomPropertiesStorage : public Lmdstorformhook::TLMDStorFormHook
{
	typedef Lmdstorformhook::TLMDStorFormHook inherited;
	
private:
	System::Classes::TNotifyEvent FOnNoStorageData;
	Lmdstorbase::TLMDStorStreamEvent FOnLoadData;
	Lmdstorbase::TLMDStorStreamEvent FOnSaveData;
	int FID;
	TLMDNotFoundEventNotify FOnNotFound;
	System::UnicodeString FComplexPropDelimiter;
	void __fastcall SetStorageVault(Lmdstorbase::TLMDAbstractStorageVault* const Value);
	void __fastcall ComponentNotFound(System::TObject* Sender, const System::UnicodeString CompName, bool &RaiseException);
	System::UnicodeString __fastcall GetComplexPropDelimiter(void);
	void __fastcall SetComplexPropDelimiter(const System::UnicodeString Value);
	
protected:
	TLMDStorPropertyStorageItems* FPropertyStorage;
	Lmdstorbase::TLMDAbstractStorageVault* FStorageVault;
	TLMDStorCustomProperties* FCustomProperties;
	bool FEnabled;
	bool FAutoLoad;
	bool FAutoSave;
	bool FSkipNotFoundComponents;
	virtual bool __fastcall IsPropListEmpty(void);
	DYNAMIC void __fastcall OwnerFormCreate(System::TObject* Sender);
	DYNAMIC void __fastcall OwnerFormDestroy(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall DoOnLoading(void);
	DYNAMIC void __fastcall DoOnSaving(void);
	DYNAMIC void __fastcall DoOnLoadData(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnSaveData(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	__property TLMDStorPropertyStorageItems* Properties = {read=FPropertyStorage, write=FPropertyStorage};
	__property Lmdstorbase::TLMDAbstractStorageVault* StorageVault = {read=FStorageVault, write=SetStorageVault};
	__property TLMDStorCustomProperties* CustomProperties = {read=FCustomProperties, write=FCustomProperties};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property bool AutoLoad = {read=FAutoLoad, write=FAutoLoad, default=1};
	__property bool AutoSave = {read=FAutoSave, write=FAutoSave, default=1};
	__property System::UnicodeString ComplexPropDelimiter = {read=GetComplexPropDelimiter, write=SetComplexPropDelimiter};
	__property Lmdstorbase::TLMDStorStreamEvent OnLoadData = {read=FOnLoadData, write=FOnLoadData};
	__property Lmdstorbase::TLMDStorStreamEvent OnSaveData = {read=FOnSaveData, write=FOnSaveData};
	__property System::Classes::TNotifyEvent OnNoStorageData = {read=FOnNoStorageData, write=FOnNoStorageData};
	
public:
	__fastcall virtual TLMDStorCustomPropertiesStorage(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDStorCustomPropertiesStorage(void);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	virtual void __fastcall Save(void);
	virtual void __fastcall Load(void);
	__property int ID = {read=FID, nodefault};
	__property bool SkipNotFoundComponents = {read=FSkipNotFoundComponents, write=FSkipNotFoundComponents, nodefault};
	__property TLMDNotFoundEventNotify OnNotFound = {read=FOnNotFound, write=FOnNotFound};
};


class PASCALIMPLEMENTATION TLMDStorPropertiesStorage : public TLMDStorCustomPropertiesStorage
{
	typedef TLMDStorCustomPropertiesStorage inherited;
	
__published:
	__property Properties;
	__property Enabled = {default=1};
	__property CustomProperties;
	__property ComplexPropDelimiter = {default=0};
	__property StorageVault;
	__property SkipNotFoundComponents;
	__property AutoLoad = {default=1};
	__property AutoSave = {default=1};
	__property OnLoading;
	__property OnSaving;
	__property OnLoadData;
	__property OnSaveData;
	__property OnNotFound;
public:
	/* TLMDStorCustomPropertiesStorage.Create */ inline __fastcall virtual TLMDStorPropertiesStorage(System::Classes::TComponent* aOwner) : TLMDStorCustomPropertiesStorage(aOwner) { }
	/* TLMDStorCustomPropertiesStorage.Destroy */ inline __fastcall virtual ~TLMDStorPropertiesStorage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString cComplexPropDelimiter;
}	/* namespace Lmdstorpropertiesstorage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORPROPERTIESSTORAGE)
using namespace Lmdstorpropertiesstorage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorpropertiesstorageHPP
