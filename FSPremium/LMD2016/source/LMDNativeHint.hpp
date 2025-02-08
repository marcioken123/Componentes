// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDNativeHint.pas' rev: 31.00 (Windows)

#ifndef LmdnativehintHPP
#define LmdnativehintHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdnativehint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseHintWindow;
class DELPHICLASS TLMDBaseHint;
class DELPHICLASS TLMDNativeHintWindow;
class DELPHICLASS TLMDNativeHint;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBaseHintWindow : public Vcl::Controls::THintWindow
{
	typedef Vcl::Controls::THintWindow inherited;
	
private:
	TLMDBaseHint* FHintControl;
	bool FIsCustom;
	TLMDBaseHint* FCreatingWith;
	
public:
	__fastcall virtual TLMDBaseHintWindow(System::Classes::TComponent* AOwner);
	__fastcall TLMDBaseHintWindow(System::Classes::TComponent* AOwner, TLMDBaseHint* AHintControl);
	__fastcall virtual ~TLMDBaseHintWindow(void);
	__property TLMDBaseHint* HintControl = {read=FHintControl};
	__property bool IsCustom = {read=FIsCustom, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBaseHintWindow(HWND ParentWindow) : Vcl::Controls::THintWindow(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDBaseHint : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FHideAccelChar;
	int FMaxWidth;
	Vcl::Controls::THintWindowClass FOldHintClass;
	bool FEnabled;
	bool FHookEnabled;
	System::Classes::TList* FWindows;
	void __fastcall InsertWindow(TLMDBaseHintWindow* AWindow);
	void __fastcall RemoveWindow(TLMDBaseHintWindow* AWindow);
	void __fastcall UpdateHintHook(void);
	void __fastcall SetEnabled(bool Value);
	int __fastcall GetWindowCount(void);
	TLMDBaseHintWindow* __fastcall GetWindows(int AIndex);
	
protected:
	virtual bool __fastcall NeedHintHook(void);
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void) = 0 ;
	virtual void __fastcall Loaded(void);
	System::Uitypes::TColor __fastcall GetThemedHintColor(void);
	__property int WindowCount = {read=GetWindowCount, nodefault};
	__property TLMDBaseHintWindow* Windows[int AIndex] = {read=GetWindows};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property bool HideAccelChar = {read=FHideAccelChar, write=FHideAccelChar, default=1};
	__property int MaxWidth = {read=FMaxWidth, write=FMaxWidth, default=-4};
	
public:
	__fastcall virtual TLMDBaseHint(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBaseHint(void);
	int __fastcall RealMaxWidth(void);
};


class PASCALIMPLEMENTATION TLMDNativeHintWindow : public TLMDBaseHintWindow
{
	typedef TLMDBaseHintWindow inherited;
	
private:
	NativeUInt FHintWindow;
	MESSAGE void __fastcall WMShowWindow(Winapi::Messages::TWMShowWindow &Message);
	
public:
	virtual void __fastcall ActivateHint(const System::Types::TRect &Rect, const System::UnicodeString AHint);
	HIDESBASE TLMDNativeHint* __fastcall HintControl(void);
public:
	/* TLMDBaseHintWindow.Create */ inline __fastcall virtual TLMDNativeHintWindow(System::Classes::TComponent* AOwner) : TLMDBaseHintWindow(AOwner) { }
	/* TLMDBaseHintWindow.CreateCustom */ inline __fastcall TLMDNativeHintWindow(System::Classes::TComponent* AOwner, TLMDBaseHint* AHintControl) : TLMDBaseHintWindow(AOwner, AHintControl) { }
	/* TLMDBaseHintWindow.Destroy */ inline __fastcall virtual ~TLMDNativeHintWindow(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDNativeHintWindow(HWND ParentWindow) : TLMDBaseHintWindow(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDNativeHint : public TLMDBaseHint
{
	typedef TLMDBaseHint inherited;
	
private:
	bool FIsBalloon;
	
protected:
	virtual Vcl::Controls::THintWindowClass __fastcall GetHintClass(void);
	
__published:
	__property About = {default=0};
	__property Enabled = {default=1};
	__property HideAccelChar = {default=1};
	__property bool IsBalloon = {read=FIsBalloon, write=FIsBalloon, default=0};
	__property MaxWidth = {default=-4};
public:
	/* TLMDBaseHint.Create */ inline __fastcall virtual TLMDNativeHint(System::Classes::TComponent* AOwner) : TLMDBaseHint(AOwner) { }
	/* TLMDBaseHint.Destroy */ inline __fastcall virtual ~TLMDNativeHint(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdnativehint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDNATIVEHINT)
using namespace Lmdnativehint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdnativehintHPP
