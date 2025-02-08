// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLabel.pas' rev: 31.00 (Windows)

#ifndef LmdlabelHPP
#define LmdlabelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomLabel.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDFXCaption.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLabel : public Lmdcustomlabel::TLMDCustomLabel
{
	typedef Lmdcustomlabel::TLMDCustomLabel inherited;
	
__published:
	__property About = {default=0};
	__property Align = {default=0};
	__property Alignment = {default=0};
	__property AutoSize = {index=0, default=1};
	__property Bevel;
	__property Caption = {default=0};
	__property Color = {default=-16777211};
	__property Font;
	__property FontFX;
	__property MultiLine = {index=1, default=0};
	__property Options;
	__property ShowAccelChar = {index=2, default=1};
	__property Transparent = {default=1};
	__property Twinkle = {index=3, default=0};
	__property TwinkleVisible = {index=0, default=700};
	__property TwinkleInVisible = {index=1, default=700};
	__property TwinkleColor = {default=536870911};
public:
	/* TLMDCustomLabel.Create */ inline __fastcall virtual TLMDLabel(System::Classes::TComponent* AOwner) : Lmdcustomlabel::TLMDCustomLabel(AOwner) { }
	/* TLMDCustomLabel.Destroy */ inline __fastcall virtual ~TLMDLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLABEL)
using namespace Lmdlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlabelHPP
