// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHeaderControl.pas' rev: 31.00 (Windows)

#ifndef LmdheadercontrolHPP
#define LmdheadercontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdheadercontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHeaderControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHeaderControl : public Vcl::Comctrls::THeaderControl
{
	typedef Vcl::Comctrls::THeaderControl inherited;
	
private:
	int __fastcall GetSectionWidth(int Index);
	void __fastcall SetSectionWidth(int Index, int aValue);
	void __fastcall SetThemeGlobalMode(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	bool FMouseDown;
	bool FMouseDownOnDivider;
	bool FMouseOnDivider;
	bool FDragging;
	int FActiveSection;
	int FOldActiveSection;
	bool FThemeGlobalMode;
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FParentThemeMode;
	void __fastcall CheckActiveSection(int APosX, int APosY, bool ARepaintSection = true);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoThemeChanged(void);
	DYNAMIC void __fastcall DrawSection(Vcl::Comctrls::THeaderSection* Section, const System::Types::TRect &Rect, bool Pressed);
	virtual System::Types::TRect __fastcall DrawThemedSection(Vcl::Graphics::TCanvas* ACanvas, int AIndex, bool AActive, bool APressed)/* overload */;
	virtual System::Types::TRect __fastcall DrawThemedSection(Vcl::Graphics::TCanvas* ACanvas, Vcl::Comctrls::THeaderSection* ASection, bool AActive, bool APressed, const System::Types::TRect &ARect)/* overload */;
	System::Types::TRect __fastcall GetItemRect(int Index);
	bool __fastcall IsThemed(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall PaintWindow(HDC DC);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDHeaderControl(System::Classes::TComponent* AOwner);
	__property int SectionWidth[int Index] = {read=GetSectionWidth, write=SetSectionWidth};
	
__published:
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, default=1};
	__property OnGesture;
	__property Touch;
public:
	/* TCustomHeaderControl.Destroy */ inline __fastcall virtual ~TLMDHeaderControl(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHeaderControl(HWND ParentWindow) : Vcl::Comctrls::THeaderControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdheadercontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHEADERCONTROL)
using namespace Lmdheadercontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdheadercontrolHPP
