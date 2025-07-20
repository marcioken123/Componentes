// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDownSampling.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedownsamplingHPP
#define Vcltee_TeedownsamplingHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeEngine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedownsampling
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

class PASCALIMPLEMENTATION TDownSamplingFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	int FDisplayedPointCount;
	TDownSampleMethod FDownSampleMethod;
	double FTolerance;
	void __fastcall SetDownSampleMethod(const TDownSampleMethod Value);
	void __fastcall SetTolerance(const double Value);
	int __fastcall Reduce(TDownSampleMethod Method, const double Tol, const int lbound, const int ubound, Vcltee::Teengine::TChartSeries* const s, Vcltee::Teengine::TChartValues &RX, Vcltee::Teengine::TChartValues &RY, System::Uitypes::TColor *colors, const int colors_High, const System::Uitypes::TColor color);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	int ReducedSize;
	__fastcall virtual TDownSamplingFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property TDownSampleMethod DownSampleMethod = {read=FDownSampleMethod, write=SetDownSampleMethod, default=0};
	__property double Tolerance = {read=FTolerance, write=SetTolerance};
	__property int DisplayedPointCount = {read=FDisplayedPointCount, write=FDisplayedPointCount, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TDownSamplingFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedownsampling */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDOWNSAMPLING)
using namespace Vcltee::Teedownsampling;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedownsamplingHPP
