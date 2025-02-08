// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShapeButtonColor.pas' rev: 31.00 (Windows)

#ifndef LmdshapebuttoncolorHPP
#define LmdshapebuttoncolorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDObject.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshapebuttoncolor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShapeButtonColor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShapeButtonColor : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FDisabled;
	System::Uitypes::TColor FDown;
	System::Uitypes::TColor FMouseOver;
	System::Uitypes::TColor FOptionSet;
	System::Uitypes::TColor FUp;
	void __fastcall SetColor(int index, System::Uitypes::TColor aValue);
	
public:
	__fastcall virtual TLMDShapeButtonColor(System::Classes::TPersistent* Owner);
	
__published:
	__property System::Uitypes::TColor Disabled = {read=FDisabled, write=SetColor, index=0, default=-16777201};
	__property System::Uitypes::TColor Down = {read=FDown, write=SetColor, index=1, default=-16777201};
	__property System::Uitypes::TColor MouseOver = {read=FMouseOver, write=SetColor, index=2, default=-16777201};
	__property System::Uitypes::TColor OptionSet = {read=FOptionSet, write=SetColor, index=3, default=-16777201};
	__property System::Uitypes::TColor Up = {read=FUp, write=SetColor, index=4, default=-16777201};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDShapeButtonColor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshapebuttoncolor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPEBUTTONCOLOR)
using namespace Lmdshapebuttoncolor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapebuttoncolorHPP
