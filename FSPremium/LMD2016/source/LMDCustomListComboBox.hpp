// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomListComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomlistcomboboxHPP
#define LmdcustomlistcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomlistcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomListComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomListComboBox : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::UnicodeString FOld;
	int FDropDownCount;
	bool FSorted;
	System::Classes::TNotifyEvent FOnSelected;
	void __fastcall SetItems(System::Classes::TStrings* aValue);
	void __fastcall SetSorted(bool aValue);
	System::Classes::TStrings* __fastcall GetItems(void);
	Vcl::Stdctrls::TListBox* __fastcall GetListBox(void);
	void __fastcall SetItemIndex(int aValue);
	int __fastcall GetItemIndex(void);
	HIDESBASE MESSAGE void __fastcall CMRecreateWnd(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall CreateControl(void);
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall ReModifyControl(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall Cancel(void);
	bool __fastcall NoneSelected(void);
	System::UnicodeString __fastcall GetSelectedText(void);
	virtual void __fastcall Accept(void);
	virtual Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall DoDownKey(void);
	virtual void __fastcall DoUpKey(void);
	virtual void __fastcall Loaded(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	virtual void __fastcall ModifyTextRect(void);
	virtual bool __fastcall RedrawOnExit(void);
	virtual bool __fastcall RedrawOnEnter(void);
	__property bool Sorted = {read=FSorted, write=SetSorted, default=0};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, default=8};
	__property System::Classes::TNotifyEvent OnSelected = {read=FOnSelected, write=FOnSelected};
	
public:
	__fastcall virtual TLMDCustomListComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomListComboBox(void);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Init(void);
	void __fastcall SelectItem(const System::UnicodeString anItem);
	__property int ItemIndex = {read=GetItemIndex, write=SetItemIndex, nodefault};
	__property Vcl::Stdctrls::TListBox* ListBox = {read=GetListBox};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomListComboBox(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomlistcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMLISTCOMBOBOX)
using namespace Lmdcustomlistcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomlistcomboboxHPP
