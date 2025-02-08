// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDControl.pas' rev: 31.00 (Windows)

#ifndef LmdcontrolHPP
#define LmdcontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <intfLMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBasePopupMenu;
class DELPHICLASS TLMDBaseCustomControl;
class DELPHICLASS TLMDBaseTreeView;
class DELPHICLASS TLMDBaseListView;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBasePopupMenu : public Vcl::Menus::TPopupMenu
{
	typedef Vcl::Menus::TPopupMenu inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
protected:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout};
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
public:
	/* TPopupMenu.Create */ inline __fastcall virtual TLMDBasePopupMenu(System::Classes::TComponent* AOwner) : Vcl::Menus::TPopupMenu(AOwner) { }
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TLMDBasePopupMenu(void) { }
	
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


class PASCALIMPLEMENTATION TLMDBaseCustomControl : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
private:
	Lmdtypes::TLMDString FHint;
	Lmdtypes::TLMDAboutVar FAbout;
	bool FNeedInvalidate;
	System::Word FUpdateCount;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseExit;
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall MouseEnter(void);
	virtual void __fastcall MouseExit(void);
	__property bool NeedInvalidate = {read=FNeedInvalidate, write=FNeedInvalidate, default=1};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseExit = {read=FOnMouseExit, write=FOnMouseExit};
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	
public:
	__fastcall virtual TLMDBaseCustomControl(System::Classes::TComponent* AOwner);
	void __fastcall BeginUpdate(void);
	bool __fastcall IsUpdating(void);
	virtual void __fastcall EndUpdate(bool repaint = false);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property OnGesture;
	__property Touch;
public:
	/* TCustomControl.Destroy */ inline __fastcall virtual ~TLMDBaseCustomControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBaseCustomControl(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
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


class PASCALIMPLEMENTATION TLMDBaseTreeView : public Vcl::Comctrls::TCustomTreeView
{
	typedef Vcl::Comctrls::TCustomTreeView inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TCustomTreeView.Create */ inline __fastcall virtual TLMDBaseTreeView(System::Classes::TComponent* AOwner) : Vcl::Comctrls::TCustomTreeView(AOwner) { }
	/* TCustomTreeView.Destroy */ inline __fastcall virtual ~TLMDBaseTreeView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBaseTreeView(HWND ParentWindow) : Vcl::Comctrls::TCustomTreeView(ParentWindow) { }
	
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


class PASCALIMPLEMENTATION TLMDBaseListView : public Vcl::Comctrls::TCustomListView
{
	typedef Vcl::Comctrls::TCustomListView inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	bool FThemeGlobalMode;
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FParentThemeMode;
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	
public:
	bool __fastcall IsThemed(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
public:
	/* TCustomListView.Create */ inline __fastcall virtual TLMDBaseListView(System::Classes::TComponent* AOwner) : Vcl::Comctrls::TCustomListView(AOwner) { }
	/* TCustomListView.Destroy */ inline __fastcall virtual ~TLMDBaseListView(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBaseListView(HWND ParentWindow) : Vcl::Comctrls::TCustomListView(ParentWindow) { }
	
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
}	/* namespace Lmdcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCONTROL)
using namespace Lmdcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcontrolHPP
