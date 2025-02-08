// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDockOfficeButton.pas' rev: 31.00 (Windows)

#ifndef LmddockofficebuttonHPP
#define LmddockofficebuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDButtonBase.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddockofficebutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDockOfficeButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDockOfficeButton : public Lmddockspeedbutton::TLMDDockSpeedButton
{
	typedef Lmddockspeedbutton::TLMDDockSpeedButton inherited;
	
public:
	__fastcall virtual TLMDDockOfficeButton(System::Classes::TComponent* AOwner);
	
__published:
	__property Style;
public:
	/* TLMDDockSpeedButton.Destroy */ inline __fastcall virtual ~TLMDDockOfficeButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddockofficebutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDOCKOFFICEBUTTON)
using namespace Lmddockofficebutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddockofficebuttonHPP
