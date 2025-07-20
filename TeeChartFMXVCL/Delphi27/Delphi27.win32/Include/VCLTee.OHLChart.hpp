// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.OHLChart.pas' rev: 34.00 (Windows)

#ifndef Vcltee_OhlchartHPP
#define Vcltee_OhlchartHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <Vcl.Graphics.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Ohlchart
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOHLCSeries;
class DELPHICLASS TFinancialFunction;
class DELPHICLASS TOBVFunction;
class DELPHICLASS TPointFigureSeries;
class DELPHICLASS TSARFunction;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOHLCSeries : public Vcltee::Series::TCustomSeries
{
	typedef Vcltee::Series::TCustomSeries inherited;
	
private:
	Vcltee::Teengine::TChartValueList* FHighValues;
	Vcltee::Teengine::TChartValueList* FLowValues;
	Vcltee::Teengine::TChartValueList* FOpenValues;
	Vcltee::Teengine::TChartValueList* __fastcall GetCloseValues();
	Vcltee::Teengine::TChartValueList* __fastcall GetDateValues();
	void __fastcall SetCloseValues(Vcltee::Teengine::TChartValueList* Value);
	void __fastcall SetDateValues(Vcltee::Teengine::TChartValueList* Value);
	void __fastcall SetHighValues(Vcltee::Teengine::TChartValueList* Value);
	void __fastcall SetLowValues(Vcltee::Teengine::TChartValueList* Value);
	void __fastcall SetOpenValues(Vcltee::Teengine::TChartValueList* Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual double __fastcall CalcMinMaxValue(bool IsMin);
	
public:
	__fastcall virtual TOHLCSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddOHLC(const System::TDateTime ADate, const double AOpen, const double AHigh, const double ALow, const double AClose, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	int __fastcall AddOHLC(const double AOpen, const double AHigh, const double ALow, const double AClose)/* overload */;
	__classmethod void __fastcall GetRandomOHLC(double AOpen, double &AClose, double &AHigh, double &ALow, const double YRange);
	DYNAMIC bool __fastcall IsValidSourceOf(Vcltee::Teengine::TChartSeries* Value);
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property Vcltee::Teengine::TChartValueList* CloseValues = {read=GetCloseValues, write=SetCloseValues};
	__property Vcltee::Teengine::TChartValueList* DateValues = {read=GetDateValues, write=SetDateValues};
	__property Vcltee::Teengine::TChartValueList* HighValues = {read=FHighValues, write=SetHighValues};
	__property Vcltee::Teengine::TChartValueList* LowValues = {read=FLowValues, write=SetLowValues};
	__property Vcltee::Teengine::TChartValueList* OpenValues = {read=FOpenValues, write=SetOpenValues};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TOHLCSeries() { }
	
};


class PASCALIMPLEMENTATION TFinancialFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
protected:
	void __fastcall HideSeries(Vcltee::Teengine::TChartSeries* const ASeries);
	DYNAMIC bool __fastcall IsValidSource(Vcltee::Teengine::TChartSeries* const Value);
	
public:
	__classmethod virtual Vcltee::Teengine::TChartSeriesClass __fastcall GallerySource();
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TFinancialFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TFinancialFunction() { }
	
};


class PASCALIMPLEMENTATION TOBVFunction : public TFinancialFunction
{
	typedef TFinancialFunction inherited;
	
private:
	Vcltee::Teengine::TChartSeries* FVolume;
	void __fastcall SetVolume(Vcltee::Teengine::TChartSeries* const Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TOBVFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property Vcltee::Teengine::TChartSeries* Volume = {read=FVolume, write=SetVolume};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TOBVFunction() { }
	
};


class PASCALIMPLEMENTATION TPointFigureSeries : public TOHLCSeries
{
	typedef TOHLCSeries inherited;
	
	
private:
	typedef System::DynamicArray<int> _TPointFigureSeries__1;
	
	
private:
	double FBoxSize;
	Vcltee::Teengine::TSeriesPointer* FDown;
	_TPointFigureSeries__1 FInversions;
	double FReversal;
	Vcltee::Teengine::TSeriesPointer* FUp;
	void __fastcall DrawColumn(Vcltee::Teengine::TSeriesPointer* const Pointer, double FromValue, const double ToValue, int tmpX);
	void __fastcall SetBoxSize(const double Value);
	void __fastcall SetDown(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetReversal(const double Value);
	void __fastcall SetUp(Vcltee::Teengine::TSeriesPointer* const Value);
	
protected:
	int __fastcall CalcMaxColumns(bool Draw = false);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TPointFigureSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPointFigureSeries();
	virtual int __fastcall CountLegendItems();
	int __fastcall GetInversionColumn(int Index);
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	
__published:
	__property double BoxSize = {read=FBoxSize, write=SetBoxSize};
	__property Vcltee::Teengine::TSeriesPointer* DownSymbol = {read=FDown, write=SetDown};
	__property double ReversalAmount = {read=FReversal, write=SetReversal};
	__property Vcltee::Teengine::TSeriesPointer* UpSymbol = {read=FUp, write=SetUp};
	__property Active = {default=1};
	__property Brush;
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property Pen;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property XValues;
	__property YValues;
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property OnAfterAdd;
	__property OnBeforeAdd;
	__property OnClearValues;
	__property OnClick;
	__property OnDblClick;
	__property OnGetMarkText;
	__property OnMouseEnter;
	__property OnMouseLeave;
};


class PASCALIMPLEMENTATION TSARFunction : public TFinancialFunction
{
	typedef TFinancialFunction inherited;
	
private:
	double FAF;
	double FMS;
	Vcltee::Tecanvas::TDoubleArray __fastcall CalculateSAR(const int ACount, const double FirstClose, const Vcltee::Teengine::TChartValues HighValues, const Vcltee::Teengine::TChartValues LowValues);
	void __fastcall SetAF(const double Value);
	void __fastcall SetMS(const double Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TSARFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property double AccelerationFactor = {read=FAF, write=SetAF};
	__property double MaxStep = {read=FMS, write=SetMS};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSARFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcltee::Teengine::TChartSeriesClass TeeVolumeSeriesClass;
extern DELPHI_PACKAGE Vcltee::Teengine::TChartSeriesClass TeeCandleSeriesClass;
}	/* namespace Ohlchart */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_OHLCHART)
using namespace Vcltee::Ohlchart;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_OhlchartHPP
