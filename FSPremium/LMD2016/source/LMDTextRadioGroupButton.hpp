// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextRadioGroupButton.pas' rev: 31.00 (Windows)

#ifndef LmdtextradiogroupbuttonHPP
#define LmdtextradiogroupbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <LMDCustomRadioGroup.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDTextRadioButton.hpp>
#include <LMDRadioButton.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextradiogroupbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextRadioGroupButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextRadioGroupButton : public Lmdtextradiobutton::TLMDTextRadioButton
{
	typedef Lmdtextradiobutton::TLMDTextRadioButton inherited;
	
public:
	__fastcall TLMDTextRadioGroupButton(Lmdcustomradiogroup::TLMDCustomRadioGroup* Group);
	__fastcall virtual ~TLMDTextRadioGroupButton(void);
	__property Transparent = {default=1};
public:
	/* TLMDTextRadioButton.Create */ inline __fastcall virtual TLMDTextRadioGroupButton(System::Classes::TComponent* aOwner) : Lmdtextradiobutton::TLMDTextRadioButton(aOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextRadioGroupButton(HWND ParentWindow) : Lmdtextradiobutton::TLMDTextRadioButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextradiogroupbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTRADIOGROUPBUTTON)
using namespace Lmdtextradiogroupbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextradiogroupbuttonHPP
