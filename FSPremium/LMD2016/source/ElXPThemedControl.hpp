// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElXPThemedControl.pas' rev: 31.00 (Windows)

#ifndef ElxpthemedcontrolHPP
#define ElxpthemedcontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Types.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <Vcl.Themes.hpp>
#include <ElVCLUtils.hpp>
#include <ElStyleMan.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elxpthemedcontrol
{
//-- forward type declarations -----------------------------------------------
__interface ILMDElParentControlInterface;
typedef System::DelphiInterface<ILMDElParentControlInterface> _di_ILMDElParentControlInterface;
class DELPHICLASS TElXPThemedControl;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{650B1E65-792D-4669-87D0-81666305B0C5}") ILMDElParentControlInterface  : public System::IInterface 
{
	virtual void __fastcall RepaintRect(const System::Types::TRect &ARect) = 0 ;
};

class PASCALIMPLEMENTATION TElXPThemedControl : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	int FCreating;
	bool FThemeGlobalMode;
	virtual void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	virtual void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	MESSAGE void __fastcall WMStyleChanging(Winapi::Messages::TWMStyleChange &Message);
	MESSAGE void __fastcall WMStyleChanged(Winapi::Messages::TWMStyleChange &Message);
	MESSAGE void __fastcall WMSetRedraw(Winapi::Messages::TWMSetRedraw &Message);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Message);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool FParentThemeMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FPreventStyleChange;
	bool __fastcall GetUseXPThemes(void);
	void __fastcall BeginCreate(void);
	void __fastcall EndCreate(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoThemeChanged(void);
	void __fastcall UpdateStyle(void);
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	
public:
	__fastcall virtual TElXPThemedControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElXPThemedControl(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	bool __fastcall IsThemed(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElXPThemedControl(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
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
}	/* namespace Elxpthemedcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELXPTHEMEDCONTROL)
using namespace Elxpthemedcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElxpthemedcontrolHPP
