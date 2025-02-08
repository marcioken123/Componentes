// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIdeManager.pas' rev: 31.00 (Windows)

#ifndef LmdidemanagerHPP
#define LmdidemanagerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Menus.hpp>
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
#include <LMDIdeCompPltte.hpp>
#include <LMDIdeCompBar.hpp>
#include <LMDIdeObjEdrMgr.hpp>
#include <LMDIdeCompTree.hpp>
#include <LMDIdeAlignPltte.hpp>
#include <LMDIdeActns.hpp>
#include <LMDInsEditorWnds.hpp>
#include <LMDInsEditorUtils.hpp>
#include <LMDSctScripter.hpp>
#include <LMDIdeDebugCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdidemanager
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDIdeManager;
class DELPHICLASS TLMDIdeManager;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDIdeManager : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDIdeManager(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDIdeManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDIdeManager(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDIdeManager(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDIdeManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDIdeManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDIdeManager(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDIdeManager(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDIdeManager(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDIdeManager(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDIdeManager(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDIdeManager(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDIdeManager(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM Lmdidemanager__2 : unsigned char { imsoAutoConnectObjectComboBox, imsoAutoConnectPropInsp, imsoAutoConnectObjectEditorMgr, imsoAutoConnectCompTree, imsoAutoConnectAlignPalette, imsoAutoConnectDebuggerSources, imsoProvideCompInsertionService, imsoProvideCompImageService, imsoProvideObjEditService, amsoProvideCurDesignerService };

typedef System::Set<Lmdidemanager__2, Lmdidemanager__2::imsoAutoConnectObjectComboBox, Lmdidemanager__2::amsoProvideCurDesignerService> TLMDIdeManagerServiceOptions;

class PASCALIMPLEMENTATION TLMDIdeManager : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	TLMDIdeManagerServiceOptions FServiceOptions;
	Lmddsgdesigner::TLMDDesigner* FCurrentDesigner;
	Lmdsctscripter::TLMDScriptDebugger* FCurrentDebugger;
	Lmdsvcpvdr::ILMDServicesNotifier* FServicesNotifier;
	Lmddsgdesigner::ILMDDesignerNotifier* FDesignerNotifier;
	Lmdsctscripter::ILMDScriptDebuggerNotifier* FDebuggerNotifier;
	Lmddsgdesigner::ILMDCompInsService* FCompInsService;
	Lmddsgdesigner::ILMDCompImageService* FCompImageService;
	Lmddsgdesigner::ILMDObjEditService* FObjEditService;
	Lmdideactns::ILMDCurDesignerService* FCurDesignerService;
	System::Classes::TNotifyEvent FOnCurrentDesignerChange;
	System::Classes::TNotifyEvent FOnCurrentDebuggerChange;
	bool FAutoCurrentDesigner;
	bool FAutoCurrentDebugger;
	void __fastcall RegisterAll(Lmdsvcpvdr::TLMDServiceProvider* ASvcPvdr);
	void __fastcall UnregisterAll(Lmdsvcpvdr::TLMDServiceProvider* ASvcPvdr);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SetServiceOptions(const TLMDIdeManagerServiceOptions Value);
	void __fastcall SetCurrentDesigner(Lmddsgdesigner::TLMDDesigner* const Value);
	void __fastcall SetCurrentDebugger(Lmdsctscripter::TLMDScriptDebugger* const Value);
	void __fastcall DesignersChanged(void);
	void __fastcall DebuggersChanged(void);
	Lmddsgcombobox::TLMDObjectComboBox* __fastcall FindComboBox(void);
	Lmddsgpropinsp::TLMDPropertyInspector* __fastcall FindPropInsp(void);
	Lmdideobjedrmgr::TLMDObjectEditorManager* __fastcall FindObjEditorMgr(void);
	Lmdidecomptree::TLMDComponentTree* __fastcall FindCompTree(void);
	Lmdidecomppltte::TLMDComponentPalette* __fastcall FindCompPalette(void);
	Lmdidecompbar::TLMDComponentBar* __fastcall FindCompBar(void);
	Lmdidealignpltte::TLMDAlignPalette* __fastcall FindAlignPalette(void);
	System::Classes::TList* __fastcall GetDebuggerSources(void);
	void __fastcall ConnectComboBox(void);
	void __fastcall ConnectPropInsp(void);
	void __fastcall ConnectCompEditors(void);
	void __fastcall ConnectCompTree(void);
	void __fastcall ConnectAlignPalette(void);
	void __fastcall ConnectDebuggerSources(void);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoCurrentDesignerChange(void);
	virtual void __fastcall DoCurrentDebuggerChange(void);
	
public:
	__fastcall virtual TLMDIdeManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDIdeManager(void);
	__property Lmddsgdesigner::TLMDDesigner* CurrentDesigner = {read=FCurrentDesigner};
	__property Lmdsctscripter::TLMDScriptDebugger* CurrentDebugger = {read=FCurrentDebugger};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDIdeManagerServiceOptions ServiceOptions = {read=FServiceOptions, write=SetServiceOptions, default=1023};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property bool AutoCurrentDesigner = {read=FAutoCurrentDesigner, write=FAutoCurrentDesigner, default=1};
	__property bool AutoCurrentDebugger = {read=FAutoCurrentDebugger, write=FAutoCurrentDebugger, default=1};
	__property System::Classes::TNotifyEvent OnCurrentDesignerChange = {read=FOnCurrentDesignerChange, write=FOnCurrentDesignerChange};
	__property System::Classes::TNotifyEvent OnCurrentDebuggerChange = {read=FOnCurrentDebuggerChange, write=FOnCurrentDebuggerChange};
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


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdidemanager */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIDEMANAGER)
using namespace Lmdidemanager;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdidemanagerHPP
