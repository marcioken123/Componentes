// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElFlatCtl.pas' rev: 31.00 (Windows)

#ifndef ElflatctlHPP
#define ElflatctlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Types.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.TypInfo.hpp>
#include <ElVCLUtils.hpp>
#include <ElStyleMan.hpp>
#include <ElComponent.hpp>
#include <ElHook.hpp>
#include <LMDGraph.hpp>
#include <LMDSysIn.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elflatctl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElFlatController;
class DELPHICLASS TElFlatEntry;
class DELPHICLASS TElFlatEntries;
class DELPHICLASS TElFlatMultiController;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElFlatController : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	Elhook::TElHook* FHook;
	bool FMouseOver;
	bool FFlatFocusedScrollbars;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FThemeGlobalMode;
	void __fastcall SetFlatFocusedScrollbars(bool newValue);
	void __fastcall HookAfterProcessHandler(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall SetActive(bool newValue);
	bool __fastcall GetActive(void);
	void __fastcall SetControl(Vcl::Controls::TWinControl* newValue);
	Vcl::Controls::TWinControl* __fastcall GetControl(void);
	void __fastcall SetDesignActive(bool newValue);
	bool __fastcall GetDesignActive(void);
	void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall HookBeforeProcessHandler(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	bool __fastcall GetUseXPThemes(void);
	void __fastcall ReadUseXPThemes(System::Classes::TReader* Reader);
	
protected:
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FPreventStyleChange;
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall SetThemeGlobalMode(const bool Value);
	virtual void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	void __fastcall UpdateStyle(void);
	virtual void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	virtual void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	bool __fastcall IsControlThemed(Vcl::Controls::TControl* Control);
	virtual void __fastcall Loaded(void);
	void __fastcall DoNCPaint(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	
public:
	void __fastcall DrawFlatBorder(void);
	void __fastcall UpdateFrame(void);
	__fastcall virtual TElFlatController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFlatController(void);
	bool __fastcall IsThemed(void);
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
	
__published:
	__property bool FlatFocusedScrollbars = {read=FFlatFocusedScrollbars, write=SetFlatFocusedScrollbars, nodefault};
	__property bool Active = {read=GetActive, write=SetActive, nodefault};
	__property Vcl::Controls::TWinControl* Control = {read=GetControl, write=SetControl};
	__property bool DesignActive = {read=GetDesignActive, write=SetDesignActive, default=1};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, nodefault};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, nodefault};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, nodefault};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFlatEntry : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TElFlatController* FController;
	bool FDesignActive;
	Vcl::Controls::TWinControl* FControl;
	bool FActive;
	bool FFlatFocusedScrollbars;
	bool __fastcall GetActive(void);
	void __fastcall SetActive(bool newValue);
	bool __fastcall GetFlatFocusedScrollbars(void);
	void __fastcall SetFlatFocusedScrollbars(bool newValue);
	bool __fastcall GetDesignActive(void);
	void __fastcall SetDesignActive(bool newValue);
	void __fastcall SetControl(Vcl::Controls::TWinControl* newValue);
	Elvclutils::TElFlatBorderType __fastcall GetActiveBorderType(void);
	void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	Elvclutils::TElFlatBorderType __fastcall GetInactiveBorderType(void);
	void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	
protected:
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	Lmdgraph::TLMDBorderSides FBorderSides;
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	bool __fastcall GetUseXPThemes(void);
	void __fastcall SetUseXPThemes(bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TElFlatEntry(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElFlatEntry(void);
	
__published:
	__property bool Active = {read=GetActive, write=SetActive, nodefault};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, nodefault};
	__property bool FlatFocusedScrollbars = {read=GetFlatFocusedScrollbars, write=SetFlatFocusedScrollbars, nodefault};
	__property bool DesignActive = {read=GetDesignActive, write=SetDesignActive, nodefault};
	__property Vcl::Controls::TWinControl* Control = {read=FControl, write=SetControl};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=GetActiveBorderType, write=SetActiveBorderType, nodefault};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=GetInactiveBorderType, write=SetInactiveBorderType, nodefault};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, nodefault};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, nodefault};
	__property bool UseXPThemes = {read=GetUseXPThemes, write=SetUseXPThemes, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFlatEntries : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElFlatEntry* operator[](int index) { return this->Entries[index]; }
	
private:
	TElFlatMultiController* FController;
	TElFlatEntry* __fastcall GetEntries(int index);
	void __fastcall SetEntries(int index, TElFlatEntry* newValue);
	
public:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	HIDESBASE TElFlatEntry* __fastcall Add(void);
	__property TElFlatEntry* Entries[int index] = {read=GetEntries, write=SetEntries/*, default*/};
public:
	/* TCollection.Create */ inline __fastcall TElFlatEntries(System::Classes::TCollectionItemClass ItemClass) : System::Classes::TCollection(ItemClass) { }
	/* TCollection.Destroy */ inline __fastcall virtual ~TElFlatEntries(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElFlatMultiController : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FFlatFocusedScrollbars;
	bool FAutoAddControls;
	Elhook::TElHook* FHook;
	TElFlatEntries* FEntries;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	MESSAGE void __fastcall CMControlListChange(Winapi::Messages::TMessage &Msg);
	void __fastcall SetEntries(TElFlatEntries* newValue);
	void __fastcall SetActive(bool newValue);
	bool __fastcall GetActive(void);
	void __fastcall SetDesignActive(bool newValue);
	bool __fastcall GetDesignActive(void);
	void __fastcall AfterProcessHandler(System::TObject* Sender, Winapi::Messages::TMessage &Msg, bool &Handled);
	void __fastcall SetAutoAddControls(bool newValue);
	void __fastcall ScanForm(void);
	void __fastcall SetFlatFocusedScrollbars(bool newValue);
	void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	
protected:
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	bool FUseXPThemes;
	virtual void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	virtual void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall Loaded(void);
	void __fastcall SetUseXPThemes(bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TElFlatMultiController(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElFlatMultiController(void);
	
__published:
	__property TElFlatEntries* Entries = {read=FEntries, write=SetEntries};
	__property bool Active = {read=GetActive, write=SetActive, default=1};
	__property bool DesignActive = {read=GetDesignActive, write=SetDesignActive, default=1};
	__property bool AutoAddControls = {read=FAutoAddControls, write=SetAutoAddControls, default=1};
	__property bool FlatFocusedScrollbars = {read=FFlatFocusedScrollbars, write=SetFlatFocusedScrollbars, nodefault};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, nodefault};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, nodefault};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, nodefault};
	__property bool UseXPThemes = {read=FUseXPThemes, write=SetUseXPThemes, default=1};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elflatctl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELFLATCTL)
using namespace Elflatctl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElflatctlHPP
