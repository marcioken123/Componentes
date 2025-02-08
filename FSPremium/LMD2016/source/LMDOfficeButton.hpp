// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDOfficeButton.pas' rev: 31.00 (Windows)

#ifndef LmdofficebuttonHPP
#define LmdofficebuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdofficebutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDOfficeButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDOfficeButton : public Lmdcustomspeedbutton::TLMDCustomSpeedButton
{
	typedef Lmdcustomspeedbutton::TLMDCustomSpeedButton inherited;
	
protected:
	virtual bool __fastcall RepaintOnMouse(void);
	
public:
	__fastcall virtual TLMDOfficeButton(System::Classes::TComponent* AOwner);
	
__published:
	__property AllowAllUp = {default=0};
	__property GroupIndex = {default=0};
	__property Pressed = {default=0};
	__property DropDownMenu;
	__property DropDownIndent = {default=0};
	__property DropDownRight = {default=0};
	__property Style;
public:
	/* TLMDCustomSpeedButton.Destroy */ inline __fastcall virtual ~TLMDOfficeButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdofficebutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDOFFICEBUTTON)
using namespace Lmdofficebutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdofficebuttonHPP
