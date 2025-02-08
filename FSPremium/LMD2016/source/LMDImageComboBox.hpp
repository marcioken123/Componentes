// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDImageComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdimagecomboboxHPP
#define LmdimagecomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomImageComboBox.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDCustomComboBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdimagecombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImageComboBox;
class DELPHICLASS TLMDLabeledImageComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDImageComboBox : public Lmdcustomimagecombobox::TLMDCustomImageComboBox
{
	typedef Lmdcustomimagecombobox::TLMDCustomImageComboBox inherited;
	
__published:
	__property ItemIndex;
public:
	/* TLMDCustomImageComboBox.Create */ inline __fastcall virtual TLMDImageComboBox(System::Classes::TComponent* AOwner) : Lmdcustomimagecombobox::TLMDCustomImageComboBox(AOwner) { }
	/* TLMDCustomImageComboBox.Destroy */ inline __fastcall virtual ~TLMDImageComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDImageComboBox(HWND ParentWindow) : Lmdcustomimagecombobox::TLMDCustomImageComboBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledImageComboBox : public Lmdcustomimagecombobox::TLMDCustomImageComboBox
{
	typedef Lmdcustomimagecombobox::TLMDCustomImageComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledImageComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property ItemIndex;
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomImageComboBox.Destroy */ inline __fastcall virtual ~TLMDLabeledImageComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledImageComboBox(HWND ParentWindow) : Lmdcustomimagecombobox::TLMDCustomImageComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdimagecombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIMAGECOMBOBOX)
using namespace Lmdimagecombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdimagecomboboxHPP
