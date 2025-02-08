// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgManager.pas' rev: 31.00 (Windows)

#ifndef LmddsgmanagerHPP
#define LmddsgmanagerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDDsgCst.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgObjects.hpp>
#include <LMDDsgModule.hpp>
#include <LMDDsgDesigner.hpp>
#include <LMDDsgComboBox.hpp>
#include <LMDDsgPropInsp.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsEditorUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgmanager
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDDesignManager;
class DELPHICLASS TLMDCustomDesignManager;
class DELPHICLASS TLMDDesignManager;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDDesignManager : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDDesignManager(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDDesignManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDesignManager(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDDesignManager(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDesignManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDDesignManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDDesignManager(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDDesignManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDesignManager(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDDesignManager(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDesignManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDDesignManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDDesignManager(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmddsgmanager__2 : unsigned char { dmsoAutoConnectObjectComboBox, dmsoAutoConnectPropInsp };

typedef System::Set<Lmddsgmanager__2, Lmddsgmanager__2::dmsoAutoConnectObjectComboBox, Lmddsgmanager__2::dmsoAutoConnectPropInsp> TLMDDesignManagerServiceOptions;

class PASCALIMPLEMENTATION TLMDCustomDesignManager : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	Lmddsgdesigner::TLMDDesigner* FCurrentDesigner;
	Lmdsvcpvdr::ILMDServicesNotifier* FServicesNotifier;
	Lmddsgdesigner::ILMDDesignerNotifier* FDesignerNotifier;
	System::Classes::TNotifyEvent FOnCurrentDesignerChange;
	bool FAutoCurrentDesigner;
	TLMDDesignManagerServiceOptions FServiceOptions;
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SetServiceOptions(const TLMDDesignManagerServiceOptions Value);
	void __fastcall SetCurrentDesigner(Lmddsgdesigner::TLMDDesigner* const Value);
	void __fastcall DesignersChanged(void);
	void __fastcall ConnectComboBox(void);
	void __fastcall ConnectPropInsp(void);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoCurrentDesignerChange(void);
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property TLMDDesignManagerServiceOptions ServiceOptions = {read=FServiceOptions, write=SetServiceOptions, default=3};
	__property Lmddsgdesigner::TLMDDesigner* CurrentDesigner = {read=FCurrentDesigner};
	__property bool AutoCurrentDesigner = {read=FAutoCurrentDesigner, write=FAutoCurrentDesigner, default=1};
	__property System::Classes::TNotifyEvent OnCurrentDesignerChange = {read=FOnCurrentDesignerChange, write=FOnCurrentDesignerChange};
	
public:
	__fastcall virtual TLMDCustomDesignManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomDesignManager(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
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


class PASCALIMPLEMENTATION TLMDDesignManager : public TLMDCustomDesignManager
{
	typedef TLMDCustomDesignManager inherited;
	
private:
	void __fastcall ReadDeprecatedBooleanProp(System::Classes::TReader* Reader);
	void __fastcall ReadDeprecatedEventProp(System::Classes::TReader* Reader);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__property CurrentDesigner;
	
__published:
	__property ServiceProvider;
	__property ServiceOptions = {default=3};
	__property AutoCurrentDesigner = {default=1};
	__property OnCurrentDesignerChange;
public:
	/* TLMDCustomDesignManager.Create */ inline __fastcall virtual TLMDDesignManager(System::Classes::TComponent* AOwner) : TLMDCustomDesignManager(AOwner) { }
	/* TLMDCustomDesignManager.Destroy */ inline __fastcall virtual ~TLMDDesignManager(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddsgmanager */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGMANAGER)
using namespace Lmddsgmanager;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgmanagerHPP
