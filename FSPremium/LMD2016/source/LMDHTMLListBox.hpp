// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLListBox.pas' rev: 31.00 (Windows)

#ifndef LmdhtmllistboxHPP
#define LmdhtmllistboxHPP

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
#include <LMDListBox.hpp>
#include <LMDHTMLExtListBox.hpp>
#include <LMDHTMLHeaderControl.hpp>
#include <LMDHTMLUnit.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomScrollBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmllistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHTMLListBox : public Lmdlistbox::TLMDListBox
{
	typedef Lmdlistbox::TLMDListBox inherited;
	
private:
	bool FIsHTML;
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	HIDESBASE Lmdhtmlextlistbox::TLMDHTMLExtListBox* __fastcall GetListBox(void);
	void __fastcall SetIsHTML(const bool Value);
	System::Uitypes::TColor __fastcall GetLinkColor(void);
	Vcl::Menus::TPopupMenu* __fastcall GetLinkPopupMenu(void);
	System::Uitypes::TFontStyles __fastcall GetLinkStyle(void);
	void __fastcall SetLinkColor(const System::Uitypes::TColor Value);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetLinkStyle(const System::Uitypes::TFontStyles Value);
	Lmdhtmlheadercontrol::TLMDHTMLHeaderControl* __fastcall GetHeader(void);
	void __fastcall SetOnImageNeeded(const Lmdhtmlunit::TLMDHTMLImageNeededEvent Value);
	void __fastcall SetOnLinkClick(const Lmdhtmlunit::TLMDHTMLLinkClickEvent Value);
	void __fastcall SetOnVariableNeeded(const Lmdhtmlunit::TLMDHTMLVariableNeededEvent Value);
	
protected:
	virtual void __fastcall CreateHeader(void);
	virtual void __fastcall CreateLB(void);
	void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	virtual void __fastcall DrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TLMDHTMLListBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDHTMLListBox(void);
	__property Lmdhtmlextlistbox::TLMDHTMLExtListBox* ListBox = {read=GetListBox};
	__property Lmdhtmlheadercontrol::TLMDHTMLHeaderControl* Header = {read=GetHeader};
	
__published:
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=SetOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=SetOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=SetOnVariableNeeded};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property System::Uitypes::TColor LinkColor = {read=GetLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=GetLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=GetLinkStyle, write=SetLinkStyle, default=4};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHTMLListBox(HWND ParentWindow) : Lmdlistbox::TLMDListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmllistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLLISTBOX)
using namespace Lmdhtmllistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmllistboxHPP
