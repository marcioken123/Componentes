// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEqualizerSeries.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeequalizerseriesHPP
#define Vcltee_TeeequalizerseriesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeDonut.hpp>
#include <VCLTee.TeeTools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeequalizerseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEqualizerSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEqualizerSeries : public Vcltee::Series::TBarSeries
{
	typedef Vcltee::Series::TBarSeries inherited;
	
private:
	Vcltee::Series::TPointSeries* FHiMarkers;
	int FDegradeInterval;
	double FDownStep;
	bool applyDegradation;
	int lastPointCount;
	bool hasPainted;
	Vcl::Extctrls::TTimer* ITimer;
	void __fastcall SetHighMarkers();
	void __fastcall SetDegradeHigh(bool Value);
	bool __fastcall GetDegradeHigh();
	void __fastcall TimerEvent(System::TObject* Sender);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	Vcltee::Series::TPointSeries* __fastcall GetHiMarkers();
	void __fastcall HideSeries(Vcltee::Teengine::TChartSeries* ASeries);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DoAfterDrawValues();
	void __fastcall SetDegradeInterval(int value);
	int __fastcall GetDegradeInterval();
	
public:
	__fastcall virtual TEqualizerSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TEqualizerSeries();
	virtual void __fastcall DrawBar(int BarIndex, int StartPos, int EndPos);
	virtual bool __fastcall DrawSeriesForward(int ValueIndex);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
__published:
	__property bool DegradeHigh = {read=GetDegradeHigh, write=SetDegradeHigh, default=0};
	__property Vcltee::Series::TPointSeries* HighMarker = {read=GetHiMarkers};
	__property int DegradeInterval = {read=GetDegradeInterval, write=SetDegradeInterval, nodefault};
	__property double DownStep = {read=FDownStep, write=FDownStep};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeequalizerseries */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEQUALIZERSERIES)
using namespace Vcltee::Teeequalizerseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeequalizerseriesHPP
