// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMD3DCaptionButton.pas' rev: 31.00 (Windows)

#ifndef Lmd3dcaptionbuttonHPP
#define Lmd3dcaptionbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustom3DButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmd3dcaptionbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMD3DCaptionButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMD3DCaptionButton : public Lmdcustom3dbutton::TLMDCustom3DButton
{
	typedef Lmdcustom3dbutton::TLMDCustom3DButton inherited;
	
public:
	__fastcall virtual TLMD3DCaptionButton(System::Classes::TComponent* AOwner);
public:
	/* TLMDCustom3DButton.Destroy */ inline __fastcall virtual ~TLMD3DCaptionButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmd3dcaptionbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMD3DCAPTIONBUTTON)
using namespace Lmd3dcaptionbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmd3dcaptionbuttonHPP
