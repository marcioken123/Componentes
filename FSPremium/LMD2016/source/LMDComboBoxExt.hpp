// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDComboBoxExt.pas' rev: 31.00 (Windows)

#ifndef LmdcomboboxextHPP
#define LmdcomboboxextHPP

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
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDListBoxExt.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomListBoxExt.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>
#include <LMDCustomScrollBoxExt.hpp>
#include <LMDCustomParentPanel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcomboboxext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDComboBoxExt;
class DELPHICLASS TLMDLabeledComboBoxExt;
class DELPHICLASS TLMDListBoxExtHack;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDComboBoxExt : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::UnicodeString FOld;
	int FDisplayColumn;
	int FDropDownCount;
	Vcl::Stdctrls::TDrawItemEvent FOnDrawItem;
	Vcl::Stdctrls::TMeasureItemEvent FOnMeasureItem;
	int FHeaderHeight;
	bool FHeaderVisible;
	void __fastcall SetItems(System::Classes::TStrings* aValue);
	System::Classes::TStrings* __fastcall GetItems(void);
	void __fastcall SetHeaderSections(Vcl::Comctrls::THeaderSections* aValue);
	Vcl::Comctrls::THeaderSections* __fastcall GetHeaderSections(void);
	void __fastcall SetDisplayColumn(int aValue);
	void __fastcall SetDelimiter(System::WideChar aValue);
	System::WideChar __fastcall GetDelimiter(void);
	Lmdlistboxext::TLMDListBoxExt* __fastcall GetListBox(void);
	System::UnicodeString __fastcall GetValue(void);
	int __fastcall GetItemIndex(void);
	void __fastcall SetItemIndex(const int Value);
	void __fastcall SetSValue(const System::UnicodeString Value);
	HIDESBASE MESSAGE void __fastcall WMKEYUP(Winapi::Messages::TWMKey &Msg);
	Vcl::Stdctrls::TMeasureItemEvent __fastcall GetMeasureItemEvent(void);
	void __fastcall SetMeasureItemEvent(const Vcl::Stdctrls::TMeasureItemEvent Value);
	int __fastcall GetHeaderHeight(void);
	bool __fastcall GetHeaderVisible(void);
	void __fastcall SetHeaderHeight(const int Value);
	void __fastcall SetHeaderVisible(const bool Value);
	
protected:
	virtual void __fastcall Change(void);
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
	virtual Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall DoDownKey(void);
	virtual void __fastcall DoUpKey(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDComboBoxExt(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDComboBoxExt(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Clear(void);
	__property Lmdlistboxext::TLMDListBoxExt* ListBox = {read=GetListBox};
	__property System::UnicodeString Value = {read=GetValue, write=SetSValue};
	
__published:
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property DropDownWidth = {default=0};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, default=8};
	__property Vcl::Comctrls::THeaderSections* HeaderSections = {read=GetHeaderSections, write=SetHeaderSections};
	__property int HeaderHeight = {read=GetHeaderHeight, write=SetHeaderHeight, default=0};
	__property bool HeaderVisible = {read=GetHeaderVisible, write=SetHeaderVisible, default=0};
	__property int DisplayColumn = {read=FDisplayColumn, write=SetDisplayColumn, default=-1};
	__property System::WideChar Delimiter = {read=GetDelimiter, write=SetDelimiter, nodefault};
	__property ReadOnly = {index=1, default=0};
	__property Style = {default=0};
	__property Vcl::Stdctrls::TMeasureItemEvent OnMeasureItem = {read=GetMeasureItemEvent, write=SetMeasureItemEvent};
	__property Vcl::Stdctrls::TDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDComboBoxExt(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledComboBoxExt : public TLMDComboBoxExt
{
	typedef TLMDComboBoxExt inherited;
	
public:
	__fastcall virtual TLMDLabeledComboBoxExt(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDComboBoxExt.Destroy */ inline __fastcall virtual ~TLMDLabeledComboBoxExt(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledComboBoxExt(HWND ParentWindow) : TLMDComboBoxExt(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDListBoxExtHack : public Lmdlistboxext::TLMDListBoxExt
{
	typedef Lmdlistboxext::TLMDListBoxExt inherited;
	
private:
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall InternalMouseMove(System::Classes::TShiftState Shift, int X, int Y);
	
public:
	__fastcall virtual TLMDListBoxExtHack(System::Classes::TComponent* AOwner);
public:
	/* TLMDCustomListBoxExt.Destroy */ inline __fastcall virtual ~TLMDListBoxExtHack(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDListBoxExtHack(HWND ParentWindow) : Lmdlistboxext::TLMDListBoxExt(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcomboboxext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCOMBOBOXEXT)
using namespace Lmdcomboboxext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcomboboxextHPP
