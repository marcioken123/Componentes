// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCheckListBox.pas' rev: 31.00 (Windows)

#ifndef LmdchecklistboxHPP
#define LmdchecklistboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomCheckListBox.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchecklistbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCheckListBox;
class DELPHICLASS TLMDLabeledCheckListBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCheckListBox : public Lmdcustomchecklistbox::TLMDCustomCheckListBox
{
	typedef Lmdcustomchecklistbox::TLMDCustomCheckListBox inherited;
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomCheckListBox.Create */ inline __fastcall virtual TLMDCheckListBox(System::Classes::TComponent* AOwner) : Lmdcustomchecklistbox::TLMDCustomCheckListBox(AOwner) { }
	/* TLMDCustomCheckListBox.Destroy */ inline __fastcall virtual ~TLMDCheckListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCheckListBox(HWND ParentWindow) : Lmdcustomchecklistbox::TLMDCustomCheckListBox(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledCheckListBox : public TLMDCheckListBox
{
	typedef TLMDCheckListBox inherited;
	
public:
	__fastcall virtual TLMDLabeledCheckListBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomCheckListBox.Destroy */ inline __fastcall virtual ~TLMDLabeledCheckListBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledCheckListBox(HWND ParentWindow) : TLMDCheckListBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchecklistbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHECKLISTBOX)
using namespace Lmdchecklistbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchecklistboxHPP
