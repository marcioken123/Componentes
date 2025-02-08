// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlcomboboxHPP
#define LmdhtmlcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLExtListBox.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>
#include <LMDCustomListBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLComboBox;
class DELPHICLASS TLMDLabeledHTMLComboBox;
class DELPHICLASS TLMDHTMLExtListBoxH;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDHTMLComboBox : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::UnicodeString FOld;
	int FDropDownCount;
	Vcl::Stdctrls::TDrawItemEvent FOnDrawItem;
	Vcl::Stdctrls::TMeasureItemEvent FOnMeasureItem;
	Lmdhtmlunit::TLMDHTMLLinkClickEvent FOnLinkClick;
	Lmdhtmlunit::TLMDHTMLImageNeededEvent FOnImageNeeded;
	Lmdhtmlunit::TLMDHTMLVariableNeededEvent FOnVariableNeeded;
	bool FIsHTML;
	System::Uitypes::TColor FLinkColor;
	Vcl::Menus::TPopupMenu* FLinkPopupMenu;
	System::Uitypes::TFontStyles FLinkStyle;
	HIDESBASE MESSAGE void __fastcall WMKEYUP(Winapi::Messages::TWMKey &Msg);
	void __fastcall SetItems(System::Classes::TStrings* aValue);
	System::Classes::TStrings* __fastcall GetItems(void);
	Lmdhtmlextlistbox::TLMDHTMLExtListBox* __fastcall GetListBox(void);
	System::UnicodeString __fastcall GetValue(void);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetSValue(const System::UnicodeString Value);
	Vcl::Stdctrls::TMeasureItemEvent __fastcall GetMeasureItemEvent(void);
	void __fastcall SetMeasureItemEvent(const Vcl::Stdctrls::TMeasureItemEvent Value);
	Vcl::Stdctrls::TDrawItemEvent __fastcall GetOnDrawItem(void);
	void __fastcall SetOnDrawItem(const Vcl::Stdctrls::TDrawItemEvent Value);
	void __fastcall SetIsHTML(const bool Value);
	void __fastcall SetLinkColor(const System::Uitypes::TColor Value);
	void __fastcall SetLinkStyle(const System::Uitypes::TFontStyles Value);
	void __fastcall SetLinkPopupMenu(Vcl::Menus::TPopupMenu* const Value);
	
protected:
	Lmdhtmlunit::TLMDHTMLRender* FRender;
	virtual void __fastcall CreateControl(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall ReModifyControl(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall Accept(void);
	virtual void __fastcall ModifyTextRect(void);
	virtual bool __fastcall RedrawOnExit(void);
	virtual bool __fastcall RedrawOnEnter(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	virtual void __fastcall DrawEditText(int from)/* overload */;
	virtual void __fastcall DoDownKey(void);
	virtual void __fastcall DoUpKey(void);
	virtual Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall TriggerLinkClickEvent(System::TObject* Sender, Lmdtypes::TLMDString HRef);
	virtual void __fastcall TriggerImageNeededEvent(System::TObject* Sender, Lmdtypes::TLMDString Src, Vcl::Graphics::TPicture* Image);
	virtual void __fastcall TriggerVariableNeededEvent(System::TObject* Sender, const Lmdtypes::TLMDString aVar, Lmdtypes::TLMDString &aVal);
	
public:
	__fastcall virtual TLMDHTMLComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDHTMLComboBox(void);
	Lmdtypes::TLMDString __fastcall GetTextFromItem(int Index);
	virtual void __fastcall Init(void);
	virtual void __fastcall Clear(void);
	__property Lmdhtmlextlistbox::TLMDHTMLExtListBox* ListBox = {read=GetListBox};
	__property System::UnicodeString Value = {read=GetValue, write=SetSValue};
	
__published:
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property DropDownWidth = {default=0};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, default=8};
	__property ReadOnly = {index=1, default=0};
	__property Style = {default=0};
	__property Vcl::Stdctrls::TMeasureItemEvent OnMeasureItem = {read=GetMeasureItemEvent, write=SetMeasureItemEvent};
	__property Vcl::Stdctrls::TDrawItemEvent OnDrawItem = {read=GetOnDrawItem, write=SetOnDrawItem};
	__property Lmdhtmlunit::TLMDHTMLLinkClickEvent OnLinkClick = {read=FOnLinkClick, write=FOnLinkClick};
	__property Lmdhtmlunit::TLMDHTMLImageNeededEvent OnImageNeeded = {read=FOnImageNeeded, write=FOnImageNeeded};
	__property Lmdhtmlunit::TLMDHTMLVariableNeededEvent OnVariableNeeded = {read=FOnVariableNeeded, write=FOnVariableNeeded};
	__property bool IsHTML = {read=FIsHTML, write=SetIsHTML, default=1};
	__property System::Uitypes::TColor LinkColor = {read=FLinkColor, write=SetLinkColor, default=16711680};
	__property Vcl::Menus::TPopupMenu* LinkPopupMenu = {read=FLinkPopupMenu, write=SetLinkPopupMenu};
	__property System::Uitypes::TFontStyles LinkStyle = {read=FLinkStyle, write=SetLinkStyle, default=4};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHTMLComboBox(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DrawEditText(int from, const Lmdtypes::TLMDString aTxt){ Lmdcustomedit::TLMDCustomEdit::DrawEditText(from, aTxt); }
	
};


class PASCALIMPLEMENTATION TLMDLabeledHTMLComboBox : public TLMDHTMLComboBox
{
	typedef TLMDHTMLComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledHTMLComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDHTMLComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledHTMLComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledHTMLComboBox(HWND ParentWindow) : TLMDHTMLComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDHTMLExtListBoxH : public Lmdhtmlextlistbox::TLMDHTMLExtListBox
{
	typedef Lmdhtmlextlistbox::TLMDHTMLExtListBox inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDHTMLExtListBoxH(System::Classes::TComponent* AOwner);
public:
	/* TLMDHTMLExtListBox.Destroy */ inline __fastcall virtual ~TLMDHTMLExtListBoxH(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDHTMLExtListBoxH(HWND ParentWindow) : Lmdhtmlextlistbox::TLMDHTMLExtListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmlcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLCOMBOBOX)
using namespace Lmdhtmlcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlcomboboxHPP
