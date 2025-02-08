// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShapeButton.pas' rev: 31.00 (Windows)

#ifndef LmdshapebuttonHPP
#define LmdshapebuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomShapeButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshapebutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShapeButton : public Lmdcustomshapebutton::TLMDCustomShapeButton
{
	typedef Lmdcustomshapebutton::TLMDCustomShapeButton inherited;
	
public:
	/* TLMDCustomShapeButton.Create */ inline __fastcall virtual TLMDShapeButton(System::Classes::TComponent* AOwner) : Lmdcustomshapebutton::TLMDCustomShapeButton(AOwner) { }
	/* TLMDCustomShapeButton.Destroy */ inline __fastcall virtual ~TLMDShapeButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshapebutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPEBUTTON)
using namespace Lmdshapebutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapebuttonHPP
