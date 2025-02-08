// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButton.pas' rev: 31.00 (Windows)

#ifndef LmdbuttonHPP
#define LmdbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomButton.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDButton : public Lmdcustombutton::TLMDCustomButton
{
	typedef Lmdcustombutton::TLMDCustomButton inherited;
	
public:
	__property CtlXP = {default=1};
	
__published:
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnDropDown;
public:
	/* TLMDCustomButton.Create */ inline __fastcall virtual TLMDButton(System::Classes::TComponent* AOwner) : Lmdcustombutton::TLMDCustomButton(AOwner) { }
	/* TLMDCustomButton.Destroy */ inline __fastcall virtual ~TLMDButton(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDButton(HWND ParentWindow) : Lmdcustombutton::TLMDCustomButton(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTON)
using namespace Lmdbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttonHPP
