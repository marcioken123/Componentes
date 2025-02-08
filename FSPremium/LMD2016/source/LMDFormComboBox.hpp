// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdformcomboboxHPP
#define LmdformcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDCustomFormComboBox.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFormComboBox : public Lmdcustomformcombobox::TLMDCustomFormComboBox
{
	typedef Lmdcustomformcombobox::TLMDCustomFormComboBox inherited;
	
public:
	/* TLMDCustomFormComboBox.Create */ inline __fastcall virtual TLMDFormComboBox(System::Classes::TComponent* aOwner) : Lmdcustomformcombobox::TLMDCustomFormComboBox(aOwner) { }
	/* TLMDCustomFormComboBox.Destroy */ inline __fastcall virtual ~TLMDFormComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFormComboBox(HWND ParentWindow) : Lmdcustomformcombobox::TLMDCustomFormComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMCOMBOBOX)
using namespace Lmdformcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformcomboboxHPP
