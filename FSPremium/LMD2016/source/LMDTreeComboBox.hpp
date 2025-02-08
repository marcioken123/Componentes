// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTreeComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdtreecomboboxHPP
#define LmdtreecomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtreecombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTreeComboBox;
class DELPHICLASS TLMDLabeledTreeComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTreeComboBox : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::UnicodeString FOld;
	int FDropDownCount;
	void __fastcall SetItems(Vcl::Comctrls::TTreeNodes* aValue);
	Vcl::Comctrls::TTreeNodes* __fastcall GetItems(void);
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	HIDESBASE bool __fastcall GetBoolean(int index);
	Vcl::Comctrls::TTreeView* __fastcall GetTreeView(void);
	System::UnicodeString __fastcall GetValue(void);
	void __fastcall SetSValue(const System::UnicodeString Value);
	void __fastcall SaveItemsToStream(System::Classes::TStream* AStream);
	void __fastcall LoadItemsFromStream(System::Classes::TStream* AStream);
	HIDESBASE MESSAGE void __fastcall CMRecreateWnd(Winapi::Messages::TMessage &Message);
	
protected:
	void __fastcall DoExpand(System::TObject* Sender, Vcl::Comctrls::TTreeNode* node, bool &AllowExpansion);
	void __fastcall DoExpanded(System::TObject* Sender, Vcl::Comctrls::TTreeNode* node);
	void __fastcall DoClick(System::TObject* Sender);
	void __fastcall DoDblClick(System::TObject* Sender);
	virtual void __fastcall CreateControl(void);
	DYNAMIC bool __fastcall DoMouseWheel(System::Classes::TShiftState Shift, int WheelDelta, const System::Types::TPoint &MousePos);
	virtual void __fastcall DoDownKey(void);
	virtual void __fastcall DoUpKey(void);
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall ReModifyControl(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall Accept(void);
	virtual Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDTreeComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTreeComboBox(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Clear(void);
	__property Vcl::Comctrls::TTreeView* TreeView = {read=GetTreeView};
	__property System::UnicodeString Value = {read=GetValue, write=SetSValue};
	
__published:
	__property Vcl::Comctrls::TTreeNodes* Items = {read=GetItems, write=SetItems, stored=true};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, default=8};
	__property bool ShowLines = {read=GetBoolean, write=SetBoolean, index=0, nodefault};
	__property bool ShowRoot = {read=GetBoolean, write=SetBoolean, index=1, nodefault};
	__property bool HotTrack = {read=GetBoolean, write=SetBoolean, index=2, nodefault};
	__property bool RowSelect = {read=GetBoolean, write=SetBoolean, index=3, nodefault};
	__property bool AutoExpand = {read=GetBoolean, write=SetBoolean, index=4, nodefault};
	__property bool ShowButtons = {read=GetBoolean, write=SetBoolean, index=5, nodefault};
	__property DropDownWidth = {default=0};
	__property ReadOnly = {index=1, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTreeComboBox(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledTreeComboBox : public TLMDTreeComboBox
{
	typedef TLMDTreeComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledTreeComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDTreeComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledTreeComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledTreeComboBox(HWND ParentWindow) : TLMDTreeComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtreecombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTREECOMBOBOX)
using namespace Lmdtreecombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtreecomboboxHPP
