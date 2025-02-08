// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShapeLabel.pas' rev: 31.00 (Windows)

#ifndef LmdshapelabelHPP
#define LmdshapelabelHPP

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

namespace Lmdshapelabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeLabel;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShapeLabel : public Lmdshapecontrol::TLMDShapeControl
{
	typedef Lmdshapecontrol::TLMDShapeControl inherited;
	
public:
	__fastcall virtual TLMDShapeLabel(System::Classes::TComponent* aOwner);
public:
	/* TLMDBaseShape.Destroy */ inline __fastcall virtual ~TLMDShapeLabel(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshapelabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPELABEL)
using namespace Lmdshapelabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapelabelHPP
