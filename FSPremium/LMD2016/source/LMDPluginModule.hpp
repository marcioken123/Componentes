// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPluginModule.pas' rev: 31.00 (Windows)

#ifndef LmdpluginmoduleHPP
#define LmdpluginmoduleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDPluginManager.hpp>
#include <LMDPluginImpl.hpp>
#include <intfLMDBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpluginmodule
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomPluginParameter;
class DELPHICLASS TLMDPluginParameter;
class DELPHICLASS TLMDPluginParameters;
class DELPHICLASS TLMDCustomPluginAction;
class DELPHICLASS TLMDPluginAction;
class DELPHICLASS TLMDPluginActions;
class DELPHICLASS TLMDPluginForms;
class DELPHICLASS TLMDCustomPluginForm;
class DELPHICLASS TLMDPluginForm;
class DELPHICLASS TLMDGuid;
class DELPHICLASS TLMDGuids;
class DELPHICLASS TLMDCustomPluginModule;
class DELPHICLASS TLMDPluginModule;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomPluginParameter : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FName;
	Lmdpluginmanager::TLMDParameterType FParamType;
	bool FIsOptional;
	
public:
	__property Lmdtypes::TLMDString Name = {read=FName, write=FName};
	__property Lmdpluginmanager::TLMDParameterType ParamType = {read=FParamType, write=FParamType, nodefault};
	__property bool IsOptional = {read=FIsOptional, write=FIsOptional, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDCustomPluginParameter(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDCustomPluginParameter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginParameter : public TLMDCustomPluginParameter
{
	typedef TLMDCustomPluginParameter inherited;
	
__published:
	__property Name = {default=0};
	__property ParamType;
	__property IsOptional;
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDPluginParameter(System::Classes::TCollection* Collection) : TLMDCustomPluginParameter(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDPluginParameter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginParameters : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDPluginParameters(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDPluginParameters(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCustomPluginAction : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FName;
	TLMDPluginParameters* FParameters;
	Lmdpluginmanager::TLMDPerformActionEvent FOnPerformAction;
	
public:
	__fastcall virtual TLMDCustomPluginAction(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDCustomPluginAction(void);
	__property Lmdtypes::TLMDString Name = {read=FName, write=FName};
	__property TLMDPluginParameters* Parameters = {read=FParameters, write=FParameters};
	__property Lmdpluginmanager::TLMDPerformActionEvent OnPerformAction = {read=FOnPerformAction, write=FOnPerformAction};
};


class PASCALIMPLEMENTATION TLMDPluginAction : public TLMDCustomPluginAction
{
	typedef TLMDCustomPluginAction inherited;
	
__published:
	__property Name = {default=0};
	__property Parameters;
	__property OnPerformAction;
public:
	/* TLMDCustomPluginAction.Create */ inline __fastcall virtual TLMDPluginAction(System::Classes::TCollection* Collection) : TLMDCustomPluginAction(Collection) { }
	/* TLMDCustomPluginAction.Destroy */ inline __fastcall virtual ~TLMDPluginAction(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginActions : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDPluginActions(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDPluginActions(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginForms : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDPluginForms(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDPluginForms(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomPluginForm : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdpluginimpl::TLMDPluginForm* FForm;
	Lmdtypes::TLMDString FName;
	
public:
	__property Lmdpluginimpl::TLMDPluginForm* Form = {read=FForm, write=FForm};
	__property Lmdtypes::TLMDString Name = {read=FName, write=FName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDCustomPluginForm(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDCustomPluginForm(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginForm : public TLMDCustomPluginForm
{
	typedef TLMDCustomPluginForm inherited;
	
__published:
	__property Form;
	__property Name = {default=0};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDPluginForm(System::Classes::TCollection* Collection) : TLMDCustomPluginForm(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDPluginForm(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGuid : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	GUID FGuid;
	System::UnicodeString __fastcall GetGuid(void);
	void __fastcall SetGuid(System::UnicodeString AValue);
	
public:
	__fastcall virtual TLMDGuid(System::Classes::TCollection* Collection);
	
__published:
	__property System::UnicodeString Guid = {read=GetGuid, write=SetGuid};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDGuid(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGuids : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDGuids(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDGuids(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCustomPluginModule : public System::Classes::TDataModule
{
	typedef System::Classes::TDataModule inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::UnicodeString FAuthor;
	System::Word FMajorVersion;
	System::Word FMinorVersion;
	System::UnicodeString FProjectFolder;
	TLMDPluginActions* FActions;
	Lmdtypes::TLMDString FFileName;
	TLMDGuids* FGuids;
	Lmdtypes::TLMDString FDescription;
	Lmdpluginimpl::TLMDPlugin* FPlugin;
	Lmdpluginmanager::_di_ILMDPluginEvent __fastcall GetPluginEvent(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	void __fastcall InitPlugin(void);
	
protected:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	
public:
	__fastcall virtual TLMDCustomPluginModule(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomPluginModule(void);
	Lmdpluginmanager::_di_ILMDPlugin __fastcall GetPlugin(void);
	__property System::UnicodeString Author = {read=FAuthor, write=FAuthor};
	__property System::Word MajorVersion = {read=FMajorVersion, write=FMajorVersion, nodefault};
	__property System::Word MinorVersion = {read=FMinorVersion, write=FMinorVersion, nodefault};
	__property System::UnicodeString ProjectFolder = {read=FProjectFolder, write=FProjectFolder};
	__property TLMDPluginActions* Actions = {read=FActions, write=FActions};
	__property Lmdtypes::TLMDString FileName = {read=FFileName, write=FFileName};
	__property TLMDGuids* Guids = {read=FGuids, write=FGuids};
	__property Lmdtypes::TLMDString Description = {read=FDescription, write=FDescription};
	__property Lmdpluginmanager::_di_ILMDPluginEvent PluginEvent = {read=GetPluginEvent};
	__property Lmdpluginimpl::TLMDPlugin* Plugin = {read=FPlugin};
public:
	/* TDataModule.CreateNew */ inline __fastcall virtual TLMDCustomPluginModule(System::Classes::TComponent* AOwner, int Dummy) : System::Classes::TDataModule(AOwner, Dummy) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDPluginModule : public TLMDCustomPluginModule
{
	typedef TLMDCustomPluginModule inherited;
	
__published:
	__property Author = {default=0};
	__property MajorVersion;
	__property MinorVersion;
	__property ProjectFolder = {default=0};
	__property Actions;
	__property FileName = {default=0};
	__property Guids;
	__property Description = {default=0};
	__property About = {default=0};
public:
	/* TLMDCustomPluginModule.Create */ inline __fastcall virtual TLMDPluginModule(System::Classes::TComponent* AOwner) : TLMDCustomPluginModule(AOwner) { }
	/* TLMDCustomPluginModule.Destroy */ inline __fastcall virtual ~TLMDPluginModule(void) { }
	
public:
	/* TDataModule.CreateNew */ inline __fastcall virtual TLMDPluginModule(System::Classes::TComponent* AOwner, int Dummy) : TLMDCustomPluginModule(AOwner, Dummy) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpluginmodule */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPLUGINMODULE)
using namespace Lmdpluginmodule;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpluginmoduleHPP
