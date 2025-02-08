// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDListComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdlistcomboboxHPP
#define LmdlistcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomListComboBox.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlistcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDListComboBox;
class DELPHICLASS TLMDLabeledListComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDListComboBox : public Lmdcustomlistcombobox::TLMDCustomListComboBox
{
	typedef Lmdcustomlistcombobox::TLMDCustomListComboBox inherited;
	
__published:
	__property Items;
	__property ItemIndex;
	__property Style = {default=0};
	__property DropDownWidth = {default=0};
	__property DropDownCount = {default=8};
public:
	/* TLMDCustomListComboBox.Create */ inline __fastcall virtual TLMDListComboBox(System::Classes::TComponent* aOwner) : Lmdcustomlistcombobox::TLMDCustomListComboBox(aOwner) { }
	/* TLMDCustomListComboBox.Destroy */ inline __fastcall virtual ~TLMDListComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDListComboBox(HWND ParentWindow) : Lmdcustomlistcombobox::TLMDCustomListComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledListComboBox : public TLMDListComboBox
{
	typedef TLMDListComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledListComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomListComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledListComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledListComboBox(HWND ParentWindow) : TLMDListComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlistcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLISTCOMBOBOX)
using namespace Lmdlistcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlistcomboboxHPP
