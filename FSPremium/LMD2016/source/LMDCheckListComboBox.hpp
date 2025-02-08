// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCheckListComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdchecklistcomboboxHPP
#define LmdchecklistcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDBase.hpp>
#include <LMDButtonListData.hpp>
#include <LMDCheckListBox.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchecklistcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCheckListComboBox;
class DELPHICLASS TLMDLabeledCheckListComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCheckListComboBox : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::UnicodeString FOld;
	int FDropDownCount;
	bool FBtnDefault;
	Lmdbuttonlistdata::TLMDButtonListMode FBtnMode;
	void __fastcall SetBtnDefault(const bool aValue);
	void __fastcall SetBtnMode(const Lmdbuttonlistdata::TLMDButtonListMode aValue);
	void __fastcall SetItems(System::Classes::TStrings* aValue);
	void __fastcall SetChecked(int index, bool aValue);
	HIDESBASE void __fastcall SetEnabled(int index, bool aValue);
	void __fastcall SetState(int Index, const Vcl::Stdctrls::TCheckBoxState aValue);
	void __fastcall SetSValue(const System::UnicodeString Value);
	Lmdchecklistbox::TLMDCheckListBox* __fastcall GetCheckListBox(void);
	bool __fastcall GetChecked(int index);
	HIDESBASE bool __fastcall GetEnabled(int index);
	Vcl::Stdctrls::TCheckBoxState __fastcall GetState(int Index);
	System::Classes::TStrings* __fastcall GetItems(void);
	System::UnicodeString __fastcall GetValue(void);
	void __fastcall DoClickCheck(System::TObject* Sender);
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall CreateControl(void);
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall ReModifyControl(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall Accept(void);
	virtual Vcl::Controls::TWinControl* __fastcall GetControl(void);
	virtual void __fastcall Loaded(void);
	HIDESBASE MESSAGE void __fastcall CMRecreateWnd(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDCheckListComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCheckListComboBox(void);
	virtual void __fastcall Clear(void);
	virtual void __fastcall Init(void);
	void __fastcall CheckAll(bool UnCheck = false);
	__property bool Checked[int index] = {read=GetChecked, write=SetChecked};
	__property bool ItemEnabled[int index] = {read=GetEnabled, write=SetEnabled};
	__property Vcl::Stdctrls::TCheckBoxState State[int Index] = {read=GetState, write=SetState};
	__property Lmdchecklistbox::TLMDCheckListBox* CheckListBox = {read=GetCheckListBox};
	__property System::UnicodeString Value = {read=GetValue, write=SetSValue};
	
__published:
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property bool CheckBtnDefault = {read=FBtnDefault, write=SetBtnDefault, default=1};
	__property Lmdbuttonlistdata::TLMDButtonListMode CheckBtnMode = {read=FBtnMode, write=SetBtnMode, default=0};
	__property DropDownWidth = {default=0};
	__property int DropDownCount = {read=FDropDownCount, write=FDropDownCount, default=8};
	__property ReadOnly = {index=1, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCheckListComboBox(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledCheckListComboBox : public TLMDCheckListComboBox
{
	typedef TLMDCheckListComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledCheckListComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCheckListComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledCheckListComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledCheckListComboBox(HWND ParentWindow) : TLMDCheckListComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchecklistcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHECKLISTCOMBOBOX)
using namespace Lmdchecklistcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchecklistcomboboxHPP
