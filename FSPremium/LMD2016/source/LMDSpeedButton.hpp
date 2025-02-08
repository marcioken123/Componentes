// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSpeedButton.pas' rev: 31.00 (Windows)

#ifndef LmdspeedbuttonHPP
#define LmdspeedbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.Classes.hpp>
#include <LMDButtonBase.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdspeedbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSpeedButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSpeedButton : public Lmdcustomspeedbutton::TLMDCustomSpeedButton
{
	typedef Lmdcustomspeedbutton::TLMDCustomSpeedButton inherited;
	
public:
	__property Transparent = {default=1};
	
__published:
	__property Align = {default=0};
	__property ButtonStyle = {default=1};
	__property AllowAllUp = {default=0};
	__property GroupIndex = {default=0};
	__property MultiLine = {default=0};
	__property Pressed = {default=0};
	__property DropDownCombo = {default=0};
	__property DropDownComboWidth = {default=12};
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
public:
	/* TLMDCustomSpeedButton.Create */ inline __fastcall virtual TLMDSpeedButton(System::Classes::TComponent* AOwner) : Lmdcustomspeedbutton::TLMDCustomSpeedButton(AOwner) { }
	/* TLMDCustomSpeedButton.Destroy */ inline __fastcall virtual ~TLMDSpeedButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdspeedbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSPEEDBUTTON)
using namespace Lmdspeedbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdspeedbuttonHPP
