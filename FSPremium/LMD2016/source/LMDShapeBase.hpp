// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShapeBase.pas' rev: 31.00 (Windows)

#ifndef LmdshapebaseHPP
#define LmdshapebaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshapebase
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShapeButtonMode : unsigned char { sbmShapeFast, sbmShapeFill };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Word __fastcall LMDTileMode2DSF(Lmdgraph::TLMDTileMode tm);
}	/* namespace Lmdshapebase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPEBASE)
using namespace Lmdshapebase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapebaseHPP
