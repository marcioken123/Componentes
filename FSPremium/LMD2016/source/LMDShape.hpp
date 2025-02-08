// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShape.pas' rev: 31.00 (Windows)

#ifndef LmdshapeHPP
#define LmdshapeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDTypes.hpp>
#include <LMDGraph.hpp>
#include <LMDSimpleBevel.hpp>
#include <LMDShadow.hpp>
#include <LMDObject.hpp>
#include <LMDPointList.hpp>
#include <LMDTeeth.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShape;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::Types::TPoint, 111> TPoints;

typedef TPoints *PPoints;

enum DECLSPEC_DENUM TLMDShapeType : unsigned char { stEllipse, stRectangle, stRoundRect, stDirectUp, stDirectRight, stDirectDown, stDirectLeft, stDiamond, stComb, stOctagon, stStar };

class PASCALIMPLEMENTATION TLMDShape : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdsimplebevel::TLMDSimpleBevel* FBevel;
	Vcl::Graphics::TBrush* FBrush;
	Lmdtypes::TLMDPercent FRoundPercent;
	Lmdshadow::TLMDShadow* FShadow;
	TLMDShapeType FShape;
	bool FSquare;
	void __fastcall SetBevel(Lmdsimplebevel::TLMDSimpleBevel* aValue);
	void __fastcall SetBrush(Vcl::Graphics::TBrush* aValue);
	void __fastcall SetRoundPercent(Lmdtypes::TLMDPercent aValue);
	void __fastcall SetShadow(Lmdshadow::TLMDShadow* aValue);
	void __fastcall SetShape(TLMDShapeType aValue);
	void __fastcall SetSquare(bool aValue);
	
public:
	__fastcall virtual TLMDShape(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDShape(void);
	
__published:
	__property Lmdsimplebevel::TLMDSimpleBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Vcl::Graphics::TBrush* Brush = {read=FBrush, write=SetBrush};
	__property Lmdtypes::TLMDPercent RoundPercent = {read=FRoundPercent, write=SetRoundPercent, default=33};
	__property Lmdshadow::TLMDShadow* Shadow = {read=FShadow, write=SetShadow};
	__property TLMDShapeType Shape = {read=FShape, write=SetShape, default=1};
	__property bool Square = {read=FSquare, write=SetSquare, default=0};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDShapeCalc(const System::Types::TRect &aRect, TLMDShapeType aShape, Lmdteeth::TLMDTeeth* aTeeth, bool Square, Vcl::Graphics::TBrush* aBrush, Lmdtypes::TLMDPercent aRoundPercent, Lmdsimplebevel::TLMDSimpleBevel* aBevel, Lmdshadow::TLMDShadow* aShadow, Lmdpointlist::TLMDPointList* aList);
extern DELPHI_PACKAGE void __fastcall LMDShapeDraw(const System::Types::TRect &aRect, Vcl::Graphics::TCanvas* aCanvas, TLMDShapeType aShape, Lmdteeth::TLMDTeeth* aTeeth, Lmdpointlist::TLMDPointList* aList, bool Square, Vcl::Graphics::TBrush* aBrush, Lmdtypes::TLMDPercent aRoundPercent, Lmdsimplebevel::TLMDSimpleBevel* aBevel, Lmdshadow::TLMDShadow* aShadow, Vcl::Graphics::TBitmap* aBitmap, System::Uitypes::TColor TransCol, System::Uitypes::TColor BrushBackCol, System::Word flags);
extern DELPHI_PACKAGE void __fastcall LMDOffsetPointArray(System::Types::TPoint *anArray, const int anArray_High, int Count, int Offsx, int Offsy);
extern DELPHI_PACKAGE void __fastcall LMDOffsetPointList(Lmdpointlist::TLMDPointList* aList, int Offsx, int Offsy);
}	/* namespace Lmdshape */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHAPE)
using namespace Lmdshape;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshapeHPP
