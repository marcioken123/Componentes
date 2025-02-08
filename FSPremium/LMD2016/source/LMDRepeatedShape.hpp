// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRepeatedShape.pas' rev: 31.00 (Windows)

#ifndef LmdrepeatedshapeHPP
#define LmdrepeatedshapeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDBaseShape.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrepeatedshape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRepeatedShape;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRepeatedShape : public Lmdbaseshape::TLMDBaseShape
{
	typedef Lmdbaseshape::TLMDBaseShape inherited;
	
private:
	int FShapeWidth;
	int FShapeHeight;
	int FHorOffset;
	int FVerOffset;
	int FHorCount;
	int FVerCount;
	bool FSetPerCount;
	void __fastcall SetInteger(int Index, int aValue);
	void __fastcall SetSetPerCount(bool aValue);
	
protected:
	virtual System::Types::TRect __fastcall GetGradientRect(void);
	DYNAMIC HPALETTE __fastcall GetPalette(void);
	
public:
	__fastcall virtual TLMDRepeatedShape(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDRepeatedShape(void);
	virtual void __fastcall Paint(void);
	
__published:
	__property CaptionClip = {default=0};
	__property int HorCount = {read=FHorCount, write=SetInteger, index=4, default=5};
	__property int HorOffset = {read=FHorOffset, write=SetInteger, index=2, default=0};
	__property int ShapeWidth = {read=FShapeWidth, write=SetInteger, index=0, default=0};
	__property bool SetPerCount = {read=FSetPerCount, write=SetSetPerCount, default=1};
	__property int ShapeHeight = {read=FShapeHeight, write=SetInteger, index=1, default=0};
	__property int VerCount = {read=FVerCount, write=SetInteger, index=5, default=5};
	__property int VerOffset = {read=FVerOffset, write=SetInteger, index=3, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrepeatedshape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREPEATEDSHAPE)
using namespace Lmdrepeatedshape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrepeatedshapeHPP
