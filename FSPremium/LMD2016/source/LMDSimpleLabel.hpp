// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimpleLabel.pas' rev: 31.00 (Windows)

#ifndef LmdsimplelabelHPP
#define LmdsimplelabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMD3DCaption.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsimplelabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSimpleLabel : public Lmdcustomsimplelabel::TLMDCustomSimpleLabel
{
	typedef Lmdcustomsimplelabel::TLMDCustomSimpleLabel inherited;
	
__published:
	__property About = {default=0};
	__property Action;
	__property Align = {default=0};
	__property FontSmoothing = {default=0};
	__property Caption = {default=0};
	__property Font;
	__property Font3D;
	__property Jump = {default=0};
	__property ActiveColor = {index=0, default=8388736};
	__property InActiveColor = {index=1, default=16711680};
	__property JumpUnderline = {default=1};
	__property JumpMode = {default=2};
	__property Options;
	__property ShowURLInHint = {default=0};
	__property ShowURLMenu = {default=0};
public:
	/* TLMDCustomSimpleLabel.Create */ inline __fastcall virtual TLMDSimpleLabel(System::Classes::TComponent* AOwner) : Lmdcustomsimplelabel::TLMDCustomSimpleLabel(AOwner) { }
	/* TLMDCustomSimpleLabel.Destroy */ inline __fastcall virtual ~TLMDSimpleLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsimplelabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLELABEL)
using namespace Lmdsimplelabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimplelabelHPP
