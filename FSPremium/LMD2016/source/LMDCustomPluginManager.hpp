// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomPluginManager.pas' rev: 31.00 (Windows)

#ifndef LmdcustompluginmanagerHPP
#define LmdcustompluginmanagerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDPluginModule.hpp>
#include <LMDPluginManager.hpp>
#include <System.SysUtils.hpp>
#include <LMDPluginImpl.hpp>
#include <LMDVariants.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustompluginmanager
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPluginDataModules;
class DELPHICLASS TLMDPluginDataModuleItem;
class DELPHICLASS TLMDCustomPluginEvent;
class DELPHICLASS TLMDCustomPluginEvents;
class DELPHICLASS TLMDCustomPluginManager;
class DELPHICLASS TLMDPluginManager;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDPluginOnLoad)(System::UnicodeString APluginPath, bool &Accept);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginDataModules : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDPluginDataModules(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDPluginDataModules(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginDataModuleItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdpluginmodule::TLMDPluginModule* FModule;
	
__published:
	__property Lmdpluginmodule::TLMDPluginModule* Module = {read=FModule, write=FModule};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDPluginDataModuleItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDPluginDataModuleItem(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDOnPluginEvent)(System::TObject* Sendet, void * AData);

class PASCALIMPLEMENTATION TLMDCustomPluginEvent : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDOnPluginEvent FOnPluginEvent;
	System::WideString FName;
	
__published:
	__property TLMDOnPluginEvent OnPluginEvent = {read=FOnPluginEvent, write=FOnPluginEvent};
	__property System::WideString Name = {read=FName, write=FName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDCustomPluginEvent(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDCustomPluginEvent(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomPluginEvents : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDCustomPluginEvents(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDCustomPluginEvents(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCustomPluginManager : public Lmdpluginimpl::TLMDPluginComponent
{
	typedef Lmdpluginimpl::TLMDPluginComponent inherited;
	
public:
	Lmdpluginmanager::_di_ILMDPlugin operator[](int Index) { return this->Plugins[Index]; }
	
private:
	bool FAutoLoading;
	System::Classes::TStrings* FHostParameters;
	Lmdpluginmanager::TLMDBaseMenuController* FMenuController;
	System::Classes::TInterfaceList* FPlugins;
	System::Classes::TStrings* FPluginsToLoad;
	Lmdpluginmanager::TLMDBaseToolbarController* FToolbarController;
	Lmdpluginmanager::_di_ILMDHost FHost;
	System::UnicodeString FPathMask;
	TLMDPluginDataModules* FPluginModules;
	TLMDPluginOnLoad FOnLoad;
	TLMDCustomPluginEvents* FEvents;
	Lmdpluginimpl::TLMDPluginEvent* FEventCallback;
	Lmdvariants::TLMDVariantList* FInvokes;
	int __fastcall GetPluginCount(void);
	void __fastcall SetPluginsToLoad(System::Classes::TStrings* AList);
	Lmdpluginmanager::_di_ILMDPlugin __fastcall GetPlugin(int AIndex);
	System::Variant __fastcall GetInvoke(int AIndex);
	
public:
	__fastcall virtual TLMDCustomPluginManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomPluginManager(void);
	virtual void __fastcall Loaded(void);
	bool __fastcall LoadPlugin(const System::UnicodeString AFileName);
	bool __fastcall AddPlugin(Lmdpluginmanager::_di_ILMDPlugin APlugin);
	bool __fastcall LoadPlugins(void);
	bool __fastcall UnloadPlugin(int AIndex);
	bool __fastcall UnloadPlugins(void);
	void __fastcall OnPerformPluginEvent(const System::WideString AName, void * AData);
	__property bool AutoLoading = {read=FAutoLoading, write=FAutoLoading, nodefault};
	__property System::Classes::TStrings* HostParameters = {read=FHostParameters, write=FHostParameters};
	__property Lmdpluginmanager::TLMDBaseMenuController* MenuController = {read=FMenuController, write=FMenuController};
	__property int PluginsCount = {read=GetPluginCount, nodefault};
	__property System::Classes::TStrings* PluginsToLoad = {read=FPluginsToLoad, write=SetPluginsToLoad};
	__property Lmdpluginmanager::TLMDBaseToolbarController* ToolbarController = {read=FToolbarController, write=FToolbarController};
	__property Lmdpluginmanager::_di_ILMDHost Host = {read=FHost, write=FHost};
	__property Lmdpluginmanager::_di_ILMDPlugin Plugins[int Index] = {read=GetPlugin/*, default*/};
	__property System::UnicodeString PathMask = {read=FPathMask, write=FPathMask};
	__property TLMDPluginDataModules* PluginModules = {read=FPluginModules, write=FPluginModules};
	__property TLMDPluginOnLoad OnLoad = {read=FOnLoad, write=FOnLoad};
	__property TLMDCustomPluginEvents* Events = {read=FEvents, write=FEvents};
	__property System::Variant PluginInvoke[int Index] = {read=GetInvoke};
};


class PASCALIMPLEMENTATION TLMDPluginManager : public TLMDCustomPluginManager
{
	typedef TLMDCustomPluginManager inherited;
	
public:
	__property PluginsToLoad;
	
__published:
	__property AutoLoading;
	__property HostParameters;
	__property MenuController;
	__property ToolbarController;
	__property PathMask = {default=0};
	__property PluginModules;
	__property OnLoad;
	__property Events;
	__property About = {default=0};
public:
	/* TLMDCustomPluginManager.Create */ inline __fastcall virtual TLMDPluginManager(System::Classes::TComponent* AOwner) : TLMDCustomPluginManager(AOwner) { }
	/* TLMDCustomPluginManager.Destroy */ inline __fastcall virtual ~TLMDPluginManager(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustompluginmanager */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMPLUGINMANAGER)
using namespace Lmdcustompluginmanager;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustompluginmanagerHPP
