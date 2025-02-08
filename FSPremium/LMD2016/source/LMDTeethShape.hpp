// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTeethShape.pas' rev: 31.00 (Windows)

#ifndef LmdteethshapeHPP
#define LmdteethshapeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDShapeControl.hpp>
#include <LMDBaseShape.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdteethshape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTeethShape;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTeethShape : public Lmdshapecontrol::TLMDShapeControl
{
	typedef Lmdshapecontrol::TLMDShapeControl inherited;
	
public:
	__fastcall virtual TLMDTeethShape(System::Classes::TComponent* aOwner);
public:
	/* TLMDBaseShape.Destroy */ inline __fastcall virtual ~TLMDTeethShape(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdteethshape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEETHSHAPE)
using namespace Lmdteethshape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdteethshapeHPP
