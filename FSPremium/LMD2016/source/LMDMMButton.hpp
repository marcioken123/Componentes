// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMMButton.pas' rev: 31.00 (Windows)

#ifndef LmdmmbuttonHPP
#define LmdmmbuttonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomMMButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmmbutton
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMMButton;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMMButton : public Lmdcustommmbutton::TLMDCustomMMButton
{
	typedef Lmdcustommmbutton::TLMDCustomMMButton inherited;
	
public:
	/* TLMDCustomMMButton.Create */ inline __fastcall virtual TLMDMMButton(System::Classes::TComponent* AOwner) : Lmdcustommmbutton::TLMDCustomMMButton(AOwner) { }
	/* TLMDCustomMMButton.Destroy */ inline __fastcall virtual ~TLMDMMButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmmbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMMBUTTON)
using namespace Lmdmmbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmmbuttonHPP
