// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDColorComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcolorcomboboxHPP
#define LmdcolorcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <Vcl.Controls.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDCustomComboBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcolorcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDColorComboBox;
class DELPHICLASS TLMDLabeledColorComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDColorComboBox : public Lmdcustomcolorcombobox::TLMDCustomColorComboBox
{
	typedef Lmdcustomcolorcombobox::TLMDCustomColorComboBox inherited;
	
public:
	/* TLMDCustomColorComboBox.Create */ inline __fastcall virtual TLMDColorComboBox(System::Classes::TComponent* AOwner) : Lmdcustomcolorcombobox::TLMDCustomColorComboBox(AOwner) { }
	/* TLMDCustomColorComboBox.Destroy */ inline __fastcall virtual ~TLMDColorComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDColorComboBox(HWND ParentWindow) : Lmdcustomcolorcombobox::TLMDCustomColorComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledColorComboBox : public TLMDColorComboBox
{
	typedef TLMDColorComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledColorComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomColorComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledColorComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledColorComboBox(HWND ParentWindow) : TLMDColorComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcolorcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCOLORCOMBOBOX)
using namespace Lmdcolorcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcolorcomboboxHPP
