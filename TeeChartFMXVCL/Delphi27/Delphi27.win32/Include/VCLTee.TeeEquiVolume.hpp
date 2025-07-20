// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEquiVolume.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeequivolumeHPP
#define Vcltee_TeeequivolumeHPP

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
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.CandleCh.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.OHLChart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeequivolume
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEquiVolumeSeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TBoxFillStyle : unsigned char { bfsFillToClose, bfsOutline };

class PASCALIMPLEMENTATION TEquiVolumeSeries : public Vcltee::Candlech::TCandleSeries
{
	typedef Vcltee::Candlech::TCandleSeries inherited;
	
private:
	TBoxFillStyle FBoxFillStyle;
	Vcltee::Teengine::TChartValueList* FVolumeValues;
	Vcltee::Teengine::TSeriesPointer* FVolumePointer;
	int FCumulativeGap;
	int FTotalGap;
	int FPointGap;
	bool FCalcPassed;
	double FTotalVolume;
	double FPublicValuePerPixel;
	double OldIncrement;
	int OldLabelsAngle;
	int OldLabelsSize;
	Vcltee::Teengine::TAxisCalcPos OldCalcX;
	Vcltee::Teengine::TAxisCalcPosPoint OldCalcPosPoint;
	void __fastcall AxisCalcMaxLabel(Vcltee::Teengine::TChartAxis* Sender, int LabelIndex, double &LabelValue, bool &Stop);
	int __fastcall AxisCalcPosLabels(Vcltee::Teengine::TChartAxis* aAxis, int Value);
	void __fastcall ChartGetAxisLabel(Vcltee::Teengine::TChartAxis* Sender, Vcltee::Teengine::TChartSeries* Series, int ValueIndex, System::UnicodeString &LabelText);
	int __fastcall CalcXAccumulated(const double Value);
	void __fastcall CustomizeAxis(Vcltee::Teengine::TCustomAxisPanel* const AChart, bool Enable);
	HIDESBASE void __fastcall GetMarkText(Vcltee::Teengine::TChartSeries* Sender, int ValueIndex, System::UnicodeString &MarkText);
	Vcltee::Teengine::TSeriesPointer* __fastcall GetVolumePointer();
	void __fastcall SetBoxFillStyle(const TBoxFillStyle Value);
	void __fastcall SetPointGap(const int Value);
	void __fastcall SetVolumeValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetVolumePointer(Vcltee::Teengine::TSeriesPointer* const Value);
	System::UnicodeString __fastcall XLabelText(Vcltee::Teengine::TChartAxis* const Axis, int ValueIndex);
	
protected:
	virtual bool __fastcall IsPointInChartRect(int ValueIndex);
	double __fastcall GetCandleWidth(int ValueIndex);
	double __fastcall AdjustCalcPosPoint(const int PixelVal);
	int __fastcall CalcXPixelGap(int PixelVal);
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	void __fastcall DrawAxisLabels();
	virtual void __fastcall DrawValue(int ValueIndex);
	void __fastcall DoDrawPointer(bool isUp, int x, int y);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TEquiVolumeSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TEquiVolumeSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE int __fastcall Add(const System::TDateTime aDate, const double Volume, const double Open, const double High, const double Low, const double Close)/* overload */;
	HIDESBASE int __fastcall Add(const double Volume, const double Open, const double High, const double Low, const double Close)/* overload */;
	HIDESBASE int __fastcall Add(int Index, const double Volume, const double Open, const double High, const double Low, const double Close)/* overload */;
	void __fastcall CalcUnitSize(const double Min, const double Max);
	virtual int __fastcall CalcYPos(int ValueIndex);
	
__published:
	__property TBoxFillStyle BoxFillStyle = {read=FBoxFillStyle, write=SetBoxFillStyle, default=0};
	__property Vcltee::Teengine::TChartValueList* VolumeValues = {read=FVolumeValues, write=SetVolumeValues};
	__property Vcltee::Teengine::TSeriesPointer* VolumePointer = {read=GetVolumePointer, write=SetVolumePointer};
	__property int PointGap = {read=FPointGap, write=SetPointGap, nodefault};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Add(const System::TDateTime ADate, const double AOpen, const double AHigh, const double ALow, const double AClose){ return Vcltee::Candlech::TCandleSeries::Add(ADate, AOpen, AHigh, ALow, AClose); }
	inline int __fastcall  Add(const double AValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000)){ return Vcltee::Teengine::TChartSeries::Add(AValue, ALabel, AColor); }
	inline int __fastcall  Add(const double *ADetail, const int ADetail_High, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000)){ return Vcltee::Teengine::TChartSeries::Add(ADetail, ADetail_High, ALabel, AColor); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeequivolume */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEQUIVOLUME)
using namespace Vcltee::Teeequivolume;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeequivolumeHPP
