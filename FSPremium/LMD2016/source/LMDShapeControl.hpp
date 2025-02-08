// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShapeControl.pas' rev: 31.00 (Windows)

#ifndef LmdshapecontrolHPP
#define LmdshapecontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDBaseShape.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDSimpleBevel.hpp>
#include <LMDTypes.hpp>
#include <LMDShape.hpp>
#include <LMDTeeth.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshapecontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShapeControl : public Lmdbaseshape::TLMDBaseShape
{
	typedef Lmdbaseshape::TLMDBaseShape inherited;
	
__published:
	__property Mode = {default=0};
	__property CaptionClip = {default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Bevel;
	__property RoundPercent = {default=33};
	__property Shape = {default=1};
	__property Teeth;
public:
	/* TLMDBaseShape.Create */ inline __fastcall virtual TLMDShapeControl(System::Classes::TComponent* aOwner) : Lmdbaseshape::TLMDBaseShape(aOwner) { }
	/* TLMDBaseShape.Destroy */ inline __fastcall virtual ~TLMDShapeControl(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshapecontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPECONTROL)
using namespace Lmdshapecontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapecontrolHPP
