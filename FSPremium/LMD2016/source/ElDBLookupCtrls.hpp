// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDBLookupCtrls.pas' rev: 31.00 (Windows)

#ifndef EldblookupctrlsHPP
#define EldblookupctrlsHPP

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
#include <Data.DB.hpp>
#include <Vcl.DBCtrls.hpp>
#include <System.Variants.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElDBWideLookupControls.hpp>
#include <LMDTypes.hpp>
#include <LMDGraphUtils.hpp>
#include <ElVCLUtils.hpp>
#include <ElListBox.hpp>
#include <ElXPThemedControl.hpp>
#include <HTMLLbx.hpp>
#include <ElCombos.hpp>
#include <ElBtnEdit.hpp>
#include <ElEdits.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldblookupctrls
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElDBLookupListBox;
class DELPHICLASS TElDBLookupComboBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElDBLookupListBox : public Eldbwidelookupcontrols::TElWideDBLookupListBox
{
	typedef Eldbwidelookupcontrols::TElWideDBLookupListBox inherited;
	
public:
	/* TElWideDBLookupListBox.Create */ inline __fastcall virtual TElDBLookupListBox(System::Classes::TComponent* AOwner) : Eldbwidelookupcontrols::TElWideDBLookupListBox(AOwner) { }
	/* TElWideDBLookupListBox.Destroy */ inline __fastcall virtual ~TElDBLookupListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBLookupListBox(HWND ParentWindow) : Eldbwidelookupcontrols::TElWideDBLookupListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElDBLookupComboBox : public Eldbwidelookupcontrols::TElWideDBLookupComboBox
{
	typedef Eldbwidelookupcontrols::TElWideDBLookupComboBox inherited;
	
public:
	/* TElWideDBLookupComboBox.Create */ inline __fastcall virtual TElDBLookupComboBox(System::Classes::TComponent* AOwner) : Eldbwidelookupcontrols::TElWideDBLookupComboBox(AOwner) { }
	/* TElWideDBLookupComboBox.Destroy */ inline __fastcall virtual ~TElDBLookupComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDBLookupComboBox(HWND ParentWindow) : Eldbwidelookupcontrols::TElWideDBLookupComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eldblookupctrls */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDBLOOKUPCTRLS)
using namespace Eldblookupctrls;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldblookupctrlsHPP
