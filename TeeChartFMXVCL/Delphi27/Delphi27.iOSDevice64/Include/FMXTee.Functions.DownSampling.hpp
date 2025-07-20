// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Functions.DownSampling.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Functions_DownsamplingHPP
#define Fmxtee_Functions_DownsamplingHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Functions
{
namespace Downsampling
{
//-- forward type declarations -----------------------------------------------
struct TPointFloat2D;
class DELPHICLASS TDownSamplingFunction;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TPointFloat2D
{
public:
	double X;
	double Y;
};
#pragma pack(pop)


enum DECLSPEC_DENUM TDownSampleMethod : unsigned char { dsDouglas, dsMax, dsMin, dsMinMax, dsAverage, dsMinMaxFirstLast, dsMinMaxFirstLastNull };

class PASCALIMPLEMENTATION TDownSamplingFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	int FDisplayedPointCount;
	TDownSampleMethod FDownSampleMethod;
	double FTolerance;
	void __fastcall SetDownSampleMethod(const TDownSampleMethod Value);
	void __fastcall SetTolerance(const double Value);
	int __fastcall Reduce(TDownSampleMethod Method, const double Tol, const int lbound, const int ubound, Fmxtee::Engine::TChartSeries* const s, Fmxtee::Engine::TChartValues &RX, Fmxtee::Engine::TChartValues &RY, System::Uitypes::TAlphaColor *colors, const int colors_High, const System::Uitypes::TAlphaColor color);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	int ReducedSize;
	__fastcall virtual TDownSamplingFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property TDownSampleMethod DownSampleMethod = {read=FDownSampleMethod, write=SetDownSampleMethod, default=0};
	__property double Tolerance = {read=FTolerance, write=SetTolerance};
	__property int DisplayedPointCount = {read=FDisplayedPointCount, write=FDisplayedPointCount, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TDownSamplingFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Downsampling */
}	/* namespace Functions */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS_DOWNSAMPLING)
using namespace Fmxtee::Functions::Downsampling;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS)
using namespace Fmxtee::Functions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Functions_DownsamplingHPP
