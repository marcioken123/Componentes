// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLEDLabel.pas' rev: 31.00 (Windows)

#ifndef LmdledlabelHPP
#define LmdledlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDLEDCustomLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDLED.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdledlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLEDLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLEDLabel : public Lmdledcustomlabel::TLMDLEDCustomLabel
{
	typedef Lmdledcustomlabel::TLMDLEDCustomLabel inherited;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property AutoSize = {default=0};
	__property Bevel;
	__property Caption = {default=0};
	__property Digits = {default=2};
	__property LED;
	__property Style = {default=0};
	__property Transparent = {default=0};
	__property Value = {default=0};
public:
	/* TLMDLEDCustomLabel.Create */ inline __fastcall virtual TLMDLEDLabel(System::Classes::TComponent* AOwner) : Lmdledcustomlabel::TLMDLEDCustomLabel(AOwner) { }
	/* TLMDLEDCustomLabel.Destroy */ inline __fastcall virtual ~TLMDLEDLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdledlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLEDLABEL)
using namespace Lmdledlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdledlabelHPP
