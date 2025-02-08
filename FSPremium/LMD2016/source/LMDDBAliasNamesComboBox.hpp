// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBAliasNamesComboBox.pas' rev: 31.00 (Windows)

#ifndef LmddbaliasnamescomboboxHPP
#define LmddbaliasnamescomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDCustomListComboBox.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbaliasnamescombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBAliasNamesComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBAliasNamesComboBox : public Lmdcustomlistcombobox::TLMDCustomListComboBox
{
	typedef Lmdcustomlistcombobox::TLMDCustomListComboBox inherited;
	
protected:
	virtual void __fastcall BeforeDropDown(void);
	void __fastcall UpdateItems(void);
	virtual void __fastcall Accept(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBAliasNamesComboBox(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDDBAliasNamesComboBox(void);
	
__published:
	__property OnSelected;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBAliasNamesComboBox(HWND ParentWindow) : Lmdcustomlistcombobox::TLMDCustomListComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbaliasnamescombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBALIASNAMESCOMBOBOX)
using namespace Lmddbaliasnamescombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbaliasnamescomboboxHPP
