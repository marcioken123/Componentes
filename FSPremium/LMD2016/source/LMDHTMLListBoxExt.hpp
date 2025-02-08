// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLListBoxExt.pas' rev: 31.00 (Windows)

#ifndef LmdhtmllistboxextHPP
#define LmdhtmllistboxextHPP

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
#include <LMDCustomListBoxExt.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDListBox.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDCustomScrollBoxExt.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDSBar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmllistboxext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLListBoxExt;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHTMLListBoxExt : public Lmdcustomlistboxext::TLMDCustomListBoxExt
{
	typedef Lmdcustomlistboxext::TLMDCustomListBoxExt inherited;
	
private:
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	bool FIsHTML;
	System::Uitypes::TColor __fastcall GetLinkColor(void);
	Vcl::Menus::TPopupMenu* __fastcall GetLinkPopupMenu(void);
	System::Uitypes::TFontStyles __fastcall GetLinkStyle(void);
	void __fastcall SetIsHTML(const bool Value);
	void __fastcall SetLinkColor(const System::Uitypes::TColor Value);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetLinkStyle(const System::Uitypes::TFontStyles Value);
	void __fastcall SetOnImageNeeded(const Lmdhtmlunit::TLMDHTMLImageNeededEvent Value);
	void __fastcall SetOnLinkClick(const Lmdhtmlunit::TLMDHTMLLinkClickEvent Value);
	void __fastcall SetOnVariableNeeded(const Lmdhtmlunit::TLMDHTMLVariableNeededEvent Value);
	
protected:
	void __fastcall TriggerLinkClickEvent(Lmdtypes::TLMDString HRef);
	void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	virtual void __fastcall DrawItem(Vcl::Controls::TWinControl* Control, int Index, const System::Types::TRect &Rect, Winapi::Windows::TOwnerDrawState State);
	virtual void __fastcall InternalMouseMove(System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TLMDHTMLListBoxExt(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDHTMLListBoxExt(void);
	
__published:
	__property HorzScrollBar;
	__property VertScrollBar;
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=SetOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=SetOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=SetOnVariableNeeded};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property System::Uitypes::TColor LinkColor = {read=GetLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=GetLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=GetLinkStyle, write=SetLinkStyle, default=4};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHTMLListBoxExt(HWND ParentWindow) : Lmdcustomlistboxext::TLMDCustomListBoxExt(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmllistboxext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLLISTBOXEXT)
using namespace Lmdhtmllistboxext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmllistboxextHPP
