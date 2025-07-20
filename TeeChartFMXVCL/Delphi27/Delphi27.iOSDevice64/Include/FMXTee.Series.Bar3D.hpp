// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Bar3D.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_Bar3dHPP
#define Fmxtee_Series_Bar3dHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Bar3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBar3DSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBar3DSeries : public Fmxtee::Series::TBarSeries
{
	typedef Fmxtee::Series::TBarSeries inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FOffsetValues;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	void __fastcall SetOffsetValues(Fmxtee::Engine::TChartValueList* Value);
	__classmethod virtual bool __fastcall SubGalleryStack();
	
public:
	__fastcall virtual TBar3DSeries(System::Classes::TComponent* AOwner);
	HIDESBASE int __fastcall AddBar(const double AX, const double AY, const double AOffset, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual double __fastcall GetOriginValue(int ValueIndex);
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall PointOrigin(int ValueIndex, bool SumAll);
	
__published:
	__property Fmxtee::Engine::TChartValueList* OffsetValues = {read=FOffsetValues, write=SetOffsetValues};
public:
	/* TCustomBarSeries.Destroy */ inline __fastcall virtual ~TBar3DSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Bar3d */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_BAR3D)
using namespace Fmxtee::Series::Bar3d;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES)
using namespace Fmxtee::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Series_Bar3dHPP
