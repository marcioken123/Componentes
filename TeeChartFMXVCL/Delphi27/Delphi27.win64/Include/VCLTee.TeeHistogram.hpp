// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeHistogram.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeehistogramHPP
#define Vcltee_TeehistogramHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <VCLTee.TeEngine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teehistogram
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THistogramFunction;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TDataStyle : unsigned char { hdsTruncate, hdsRound };

class PASCALIMPLEMENTATION THistogramFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
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
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual THistogramFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property bool Cumulative = {read=FCumulative, write=SetCumulative, default=0};
	__property int NumBins = {read=FNumBins, write=SetNumBins, default=20};
	__property bool IncludeNulls = {read=FIncludeNulls, write=SetIncludeNulls, default=1};
	__property TDataStyle DataStyle = {read=FDataStyle, write=SetDataStyle, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~THistogramFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Histogram(const Vcltee::Teengine::TChartValues Data, Vcltee::Teengine::TChartValues &Bins, Vcltee::Teengine::TChartValues &Counts, double Min, double Max, int nbins, TDataStyle DataStyle);
}	/* namespace Teehistogram */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEHISTOGRAM)
using namespace Vcltee::Teehistogram;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeehistogramHPP
