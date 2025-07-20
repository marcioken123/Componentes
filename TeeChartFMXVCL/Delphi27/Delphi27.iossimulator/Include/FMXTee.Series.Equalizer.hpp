// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Equalizer.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Series_EqualizerHPP
#define Fmxtee_Series_EqualizerHPP

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
#include <System.UITypes.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Donut.hpp>
#include <FMXTee.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Equalizer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEqualizerSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEqualizerSeries : public Fmxtee::Series::TBarSeries
{
	typedef Fmxtee::Series::TBarSeries inherited;
	
private:
	Fmxtee::Series::TPointSeries* FHiMarkers;
	int FDegradeInterval;
	double FDownStep;
	bool applyDegradation;
	int lastPointCount;
	bool hasPainted;
	Fmx::Types::TTimer* ITimer;
	void __fastcall SetHighMarkers();
	void __fastcall SetDegradeHigh(bool Value);
	bool __fastcall GetDegradeHigh();
	void __fastcall TimerEvent(System::TObject* Sender);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	Fmxtee::Series::TPointSeries* __fastcall GetHiMarkers();
	void __fastcall HideSeries(Fmxtee::Engine::TChartSeries* ASeries);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DoAfterDrawValues();
	void __fastcall SetDegradeInterval(int value);
	int __fastcall GetDegradeInterval();
	
public:
	__fastcall virtual TEqualizerSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TEqualizerSeries();
	virtual void __fastcall DrawBar(int BarIndex, int StartPos, int EndPos);
	virtual bool __fastcall DrawSeriesForward(int ValueIndex);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
__published:
	__property bool DegradeHigh = {read=GetDegradeHigh, write=SetDegradeHigh, default=0};
	__property Fmxtee::Series::TPointSeries* HighMarker = {read=GetHiMarkers};
	__property int DegradeInterval = {read=GetDegradeInterval, write=SetDegradeInterval, nodefault};
	__property double DownStep = {read=FDownStep, write=FDownStep};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Equalizer */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_EQUALIZER)
using namespace Fmxtee::Series::Equalizer;
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
#endif	// Fmxtee_Series_EqualizerHPP
