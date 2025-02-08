// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLHeaderControl.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlheadercontrolHPP
#define LmdhtmlheadercontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <LMDTypes.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDHeaderControl.hpp>
#include <LMDHTMLUnit.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlheadercontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLHeaderControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHTMLHeaderControl : public Lmdheadercontrol::TLMDHeaderControl
{
	typedef Lmdheadercontrol::TLMDHeaderControl inherited;
	
private:
	System::Uitypes::TCursor FCursor;
	bool FIsHTML;
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	void __fastcall SetIsHTML(const bool Value);
	void __fastcall SetLinkColor(const System::Uitypes::TColor Value);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetLinkStyle(const System::Uitypes::TFontStyles Value);
	
protected:
	void __fastcall DoLinkPopup(const System::Types::TPoint &MousePos);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	virtual System::Types::TRect __fastcall DrawThemedSection(Vcl::Graphics::TCanvas* ACanvas, Vcl::Comctrls::THeaderSection* ASection, bool AActive, bool APressed, const System::Types::TRect &ARect)/* overload */;
	
public:
	__fastcall virtual TLMDHTMLHeaderControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDHTMLHeaderControl(void);
	__property int ActiveSection = {read=FActiveSection, nodefault};
	
__published:
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHTMLHeaderControl(HWND ParentWindow) : Lmdheadercontrol::TLMDHeaderControl(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	inline System::Types::TRect __fastcall  DrawThemedSection(Vcl::Graphics::TCanvas* ACanvas, int AIndex, bool AActive, bool APressed){ return Lmdheadercontrol::TLMDHeaderControl::DrawThemedSection(ACanvas, AIndex, AActive, APressed); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmlheadercontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLHEADERCONTROL)
using namespace Lmdhtmlheadercontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlheadercontrolHPP
