// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDPluginWizard.pas' rev: 31.00 (Windows)

#ifndef PlmdpluginwizardHPP
#define PlmdpluginwizardHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <ToolsAPI.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <DesignMenus.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdpluginwizard
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPluginCustomModule;
class DELPHICLASS TLMDCustomPluginWizard;
class DELPHICLASS TLMDFormGenerator;
class DELPHICLASS TLMDOTAFile;
class DELPHICLASS TLMDPluginWizard;
class DELPHICLASS TLMDDelphiPluginModuleWizard;
class DELPHICLASS TLMDBuilderPluginModuleWizard;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginCustomModule : public Designeditors::TCustomModule
{
	typedef Designeditors::TCustomModule inherited;
	
public:
	__classmethod virtual System::Classes::TComponentClass __fastcall DesignClass();
public:
	/* TCustomModule.Create */ inline __fastcall virtual TLMDPluginCustomModule(System::Classes::TComponent* ARoot, const Designintf::_di_IDesigner ADesigner) : Designeditors::TCustomModule(ARoot, ADesigner) { }
	/* TCustomModule.Destroy */ inline __fastcall virtual ~TLMDPluginCustomModule(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomPluginWizard : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
protected:
	virtual System::UnicodeString __fastcall GetFormName(void);
	virtual System::Classes::TComponentClass __fastcall GetFormClass(void) = 0 ;
	
public:
	virtual System::UnicodeString __fastcall GetIDString(void);
	System::UnicodeString __fastcall GetName(void);
	Toolsapi::TWizardState __fastcall GetState(void);
	void __fastcall Execute(void);
	System::UnicodeString __fastcall GetAuthor(void);
	virtual System::UnicodeString __fastcall GetComment(void) = 0 ;
	virtual System::UnicodeString __fastcall GetPage(void);
	unsigned __fastcall GetGlyph(void);
	System::UnicodeString __fastcall GetDesigner(void)/* overload */;
	virtual Toolsapi::_di_IOTAGalleryCategory __fastcall GetGalleryCategory(void) = 0 ;
	virtual System::UnicodeString __fastcall GetPersonality(void) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TLMDCustomPluginWizard(void) : Toolsapi::TNotifierObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCustomPluginWizard(void) { }
	
private:
	void *__IOTARepositoryWizard80;	// Toolsapi::IOTARepositoryWizard80 
	void *__IOTAProjectWizard;	// Toolsapi::IOTAProjectWizard 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D7714D41-BC4A-445E-B695-25A65C2F561E}
	operator Toolsapi::_di_IOTARepositoryWizard80()
	{
		Toolsapi::_di_IOTARepositoryWizard80 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard80*(void) { return (Toolsapi::IOTARepositoryWizard80*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {08FCCD88-3A21-4281-ADC9-62FC034CDD12}
	operator Toolsapi::_di_IOTARepositoryWizard60()
	{
		Toolsapi::_di_IOTARepositoryWizard60 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard60*(void) { return (Toolsapi::IOTARepositoryWizard60*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {36C8BF36-EFFE-11D1-AB1D-00C04FB16FB3}
	operator Toolsapi::_di_IOTAProjectWizard()
	{
		Toolsapi::_di_IOTAProjectWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAProjectWizard*(void) { return (Toolsapi::IOTAProjectWizard*)&__IOTAProjectWizard; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE1-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTARepositoryWizard()
	{
		Toolsapi::_di_IOTARepositoryWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard*(void) { return (Toolsapi::IOTARepositoryWizard*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE0-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAWizard*(void) { return (Toolsapi::IOTAWizard*)&__IOTARepositoryWizard80; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFormGenerator : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	System::UnicodeString FAncestorName;
	
public:
	System::UnicodeString __fastcall GetCreatorType(void);
	bool __fastcall GetExisting(void);
	System::UnicodeString __fastcall GetFileSystem(void);
	Toolsapi::_di_IOTAModule __fastcall GetOwner(void);
	Toolsapi::_di_IOTAProject __fastcall GetCurrentProject(void);
	bool __fastcall GetUnnamed(void);
	System::UnicodeString __fastcall GetAncestorName(void);
	System::UnicodeString __fastcall GetImplFileName(void);
	System::UnicodeString __fastcall GetIntfFileName(void);
	System::UnicodeString __fastcall GetFormName(void);
	bool __fastcall GetMainForm(void);
	bool __fastcall GetShowForm(void);
	bool __fastcall GetShowSource(void);
	Toolsapi::_di_IOTAFile __fastcall NewFormFile(const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewImplSource(const System::UnicodeString ModuleIdent, const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	Toolsapi::_di_IOTAFile __fastcall NewIntfSource(const System::UnicodeString ModuleIdent, const System::UnicodeString FormIdent, const System::UnicodeString AncestorIdent);
	void __fastcall FormCreated(const Toolsapi::_di_IOTAFormEditor FormEditor);
	__fastcall TLMDFormGenerator(const System::UnicodeString FormName, const System::UnicodeString AncestorName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFormGenerator(void) { }
	
private:
	void *__IOTAModuleCreator;	// Toolsapi::IOTAModuleCreator 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {6EDB9B9A-F57A-11D1-AB23-00C04FB16FB3}
	operator Toolsapi::_di_IOTAModuleCreator()
	{
		Toolsapi::_di_IOTAModuleCreator intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAModuleCreator*(void) { return (Toolsapi::IOTAModuleCreator*)&__IOTAModuleCreator; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {6EDB9B9E-F57A-11D1-AB23-00C04FB16FB3}
	operator Toolsapi::_di_IOTACreator()
	{
		Toolsapi::_di_IOTACreator intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTACreator*(void) { return (Toolsapi::IOTACreator*)&__IOTAModuleCreator; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDOTAFile : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	System::UnicodeString FSource;
	
public:
	System::UnicodeString __fastcall GetSource(void);
	System::TDateTime __fastcall GetAge(void);
	__fastcall TLMDOTAFile(const System::UnicodeString ASource);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDOTAFile(void) { }
	
private:
	void *__IOTAFile;	// Toolsapi::IOTAFile 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {6E2AD9B0-F7F0-11D1-AB26-00C04FB16FB3}
	operator Toolsapi::_di_IOTAFile()
	{
		Toolsapi::_di_IOTAFile intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAFile*(void) { return (Toolsapi::IOTAFile*)&__IOTAFile; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPluginWizard : public TLMDCustomPluginWizard
{
	typedef TLMDCustomPluginWizard inherited;
	
protected:
	virtual System::Classes::TComponentClass __fastcall GetFormClass(void);
	
public:
	virtual System::UnicodeString __fastcall GetComment(void);
public:
	/* TObject.Create */ inline __fastcall TLMDPluginWizard(void) : TLMDCustomPluginWizard() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPluginWizard(void) { }
	
private:
	void *__IOTARepositoryWizard80;	// Toolsapi::IOTARepositoryWizard80 
	void *__IOTAProjectWizard;	// Toolsapi::IOTAProjectWizard 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D7714D41-BC4A-445E-B695-25A65C2F561E}
	operator Toolsapi::_di_IOTARepositoryWizard80()
	{
		Toolsapi::_di_IOTARepositoryWizard80 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard80*(void) { return (Toolsapi::IOTARepositoryWizard80*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {08FCCD88-3A21-4281-ADC9-62FC034CDD12}
	operator Toolsapi::_di_IOTARepositoryWizard60()
	{
		Toolsapi::_di_IOTARepositoryWizard60 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard60*(void) { return (Toolsapi::IOTARepositoryWizard60*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {36C8BF36-EFFE-11D1-AB1D-00C04FB16FB3}
	operator Toolsapi::_di_IOTAProjectWizard()
	{
		Toolsapi::_di_IOTAProjectWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAProjectWizard*(void) { return (Toolsapi::IOTAProjectWizard*)&__IOTAProjectWizard; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE1-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTARepositoryWizard()
	{
		Toolsapi::_di_IOTARepositoryWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard*(void) { return (Toolsapi::IOTARepositoryWizard*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE0-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAWizard*(void) { return (Toolsapi::IOTAWizard*)&__IOTARepositoryWizard80; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDelphiPluginModuleWizard : public TLMDPluginWizard
{
	typedef TLMDPluginWizard inherited;
	
public:
	virtual System::UnicodeString __fastcall GetPage(void);
	virtual System::UnicodeString __fastcall GetIDString(void);
	virtual Toolsapi::_di_IOTAGalleryCategory __fastcall GetGalleryCategory(void);
	virtual System::UnicodeString __fastcall GetPersonality(void);
public:
	/* TObject.Create */ inline __fastcall TLMDDelphiPluginModuleWizard(void) : TLMDPluginWizard() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDelphiPluginModuleWizard(void) { }
	
private:
	void *__IOTARepositoryWizard80;	// Toolsapi::IOTARepositoryWizard80 
	void *__IOTAProjectWizard;	// Toolsapi::IOTAProjectWizard 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D7714D41-BC4A-445E-B695-25A65C2F561E}
	operator Toolsapi::_di_IOTARepositoryWizard80()
	{
		Toolsapi::_di_IOTARepositoryWizard80 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard80*(void) { return (Toolsapi::IOTARepositoryWizard80*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {08FCCD88-3A21-4281-ADC9-62FC034CDD12}
	operator Toolsapi::_di_IOTARepositoryWizard60()
	{
		Toolsapi::_di_IOTARepositoryWizard60 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard60*(void) { return (Toolsapi::IOTARepositoryWizard60*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {36C8BF36-EFFE-11D1-AB1D-00C04FB16FB3}
	operator Toolsapi::_di_IOTAProjectWizard()
	{
		Toolsapi::_di_IOTAProjectWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAProjectWizard*(void) { return (Toolsapi::IOTAProjectWizard*)&__IOTAProjectWizard; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE1-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTARepositoryWizard()
	{
		Toolsapi::_di_IOTARepositoryWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard*(void) { return (Toolsapi::IOTARepositoryWizard*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE0-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAWizard*(void) { return (Toolsapi::IOTAWizard*)&__IOTARepositoryWizard80; }
	#endif
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBuilderPluginModuleWizard : public TLMDPluginWizard
{
	typedef TLMDPluginWizard inherited;
	
public:
	virtual System::UnicodeString __fastcall GetPage(void);
	virtual System::UnicodeString __fastcall GetIDString(void);
	virtual Toolsapi::_di_IOTAGalleryCategory __fastcall GetGalleryCategory(void);
	virtual System::UnicodeString __fastcall GetPersonality(void);
public:
	/* TObject.Create */ inline __fastcall TLMDBuilderPluginModuleWizard(void) : TLMDPluginWizard() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBuilderPluginModuleWizard(void) { }
	
private:
	void *__IOTARepositoryWizard80;	// Toolsapi::IOTARepositoryWizard80 
	void *__IOTAProjectWizard;	// Toolsapi::IOTAProjectWizard 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D7714D41-BC4A-445E-B695-25A65C2F561E}
	operator Toolsapi::_di_IOTARepositoryWizard80()
	{
		Toolsapi::_di_IOTARepositoryWizard80 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard80*(void) { return (Toolsapi::IOTARepositoryWizard80*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {08FCCD88-3A21-4281-ADC9-62FC034CDD12}
	operator Toolsapi::_di_IOTARepositoryWizard60()
	{
		Toolsapi::_di_IOTARepositoryWizard60 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard60*(void) { return (Toolsapi::IOTARepositoryWizard60*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {36C8BF36-EFFE-11D1-AB1D-00C04FB16FB3}
	operator Toolsapi::_di_IOTAProjectWizard()
	{
		Toolsapi::_di_IOTAProjectWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAProjectWizard*(void) { return (Toolsapi::IOTAProjectWizard*)&__IOTAProjectWizard; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE1-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTARepositoryWizard()
	{
		Toolsapi::_di_IOTARepositoryWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard*(void) { return (Toolsapi::IOTARepositoryWizard*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE0-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAWizard*(void) { return (Toolsapi::IOTAWizard*)&__IOTARepositoryWizard80; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdpluginwizard */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDPLUGINWIZARD)
using namespace Plmdpluginwizard;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdpluginwizardHPP
