// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Functions.Histogram.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Functions_HistogramHPP
#define Fmxtee_Functions_HistogramHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMXTee.Engine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Functions
{
namespace Histogram
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THistogramFunction;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TDataStyle : unsigned char { hdsTruncate, hdsRound };

class PASCALIMPLEMENTATION THistogramFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	bool FCumulative;
	int FNumBins;
	bool FIncludeNulls;
	TDataStyle FDataStyle;
	void __fastcall SetCumulative(const bool Value);
	void __fastcall SetNumBins(int Value);
	HIDESBASE void __fastcall SetIncludeNulls(const bool Value);
	void __fastcall SetDataStyle(const TDataStyle Value);
	
protected:
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual THistogramFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property bool Cumulative = {read=FCumulative, write=SetCumulative, default=0};
	__property int NumBins = {read=FNumBins, write=SetNumBins, default=20};
	__property bool IncludeNulls = {read=FIncludeNulls, write=SetIncludeNulls, default=1};
	__property TDataStyle DataStyle = {read=FDataStyle, write=SetDataStyle, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~THistogramFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Histogram(const Fmxtee::Engine::TChartValues Data, Fmxtee::Engine::TChartValues &Bins, Fmxtee::Engine::TChartValues &Counts, double Min, double Max, int nbins, TDataStyle DataStyle);
}	/* namespace Histogram */
}	/* namespace Functions */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS_HISTOGRAM)
using namespace Fmxtee::Functions::Histogram;
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
#endif	// Fmxtee_Functions_HistogramHPP
