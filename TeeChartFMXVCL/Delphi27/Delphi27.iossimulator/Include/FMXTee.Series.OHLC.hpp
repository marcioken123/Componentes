// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.OHLC.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Series_OhlcHPP
#define Fmxtee_Series_OhlcHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Ohlc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TOHLCSeries;
class DELPHICLASS TFinancialFunction;
class DELPHICLASS TOBVFunction;
class DELPHICLASS TPointFigureSeries;
class DELPHICLASS TSARFunction;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TOHLCSeries : public Fmxtee::Series::TCustomSeries
{
	typedef Fmxtee::Series::TCustomSeries inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FHighValues;
	Fmxtee::Engine::TChartValueList* FLowValues;
	Fmxtee::Engine::TChartValueList* FOpenValues;
	Fmxtee::Engine::TChartValueList* __fastcall GetCloseValues();
	Fmxtee::Engine::TChartValueList* __fastcall GetDateValues();
	void __fastcall SetCloseValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetDateValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetHighValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetLowValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetOpenValues(Fmxtee::Engine::TChartValueList* Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual double __fastcall CalcMinMaxValue(bool IsMin);
	
public:
	__fastcall virtual TOHLCSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddOHLC(const System::TDateTime ADate, const double AOpen, const double AHigh, const double ALow, const double AClose, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff))/* overload */;
	int __fastcall AddOHLC(const double AOpen, const double AHigh, const double ALow, const double AClose)/* overload */;
	__classmethod void __fastcall GetRandomOHLC(double AOpen, double &AClose, double &AHigh, double &ALow, const double YRange);
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property Fmxtee::Engine::TChartValueList* CloseValues = {read=GetCloseValues, write=SetCloseValues};
	__property Fmxtee::Engine::TChartValueList* DateValues = {read=GetDateValues, write=SetDateValues};
	__property Fmxtee::Engine::TChartValueList* HighValues = {read=FHighValues, write=SetHighValues};
	__property Fmxtee::Engine::TChartValueList* LowValues = {read=FLowValues, write=SetLowValues};
	__property Fmxtee::Engine::TChartValueList* OpenValues = {read=FOpenValues, write=SetOpenValues};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TOHLCSeries() { }
	
};


class PASCALIMPLEMENTATION TFinancialFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
protected:
	void __fastcall HideSeries(Fmxtee::Engine::TChartSeries* const ASeries);
	DYNAMIC bool __fastcall IsValidSource(Fmxtee::Engine::TChartSeries* const Value);
	
public:
	__classmethod virtual Fmxtee::Engine::TChartSeriesClass __fastcall GallerySource();
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TFinancialFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TFinancialFunction() { }
	
};


class PASCALIMPLEMENTATION TOBVFunction : public TFinancialFunction
{
	typedef TFinancialFunction inherited;
	
private:
	Fmxtee::Engine::TChartSeries* FVolume;
	void __fastcall SetVolume(Fmxtee::Engine::TChartSeries* const Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TOBVFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property Fmxtee::Engine::TChartSeries* Volume = {read=FVolume, write=SetVolume};
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
	Fmxtee::Engine::TSeriesPointer* FDown;
	_TPointFigureSeries__1 FInversions;
	double FReversal;
	Fmxtee::Engine::TSeriesPointer* FUp;
	void __fastcall DrawColumn(Fmxtee::Engine::TSeriesPointer* const Pointer, double FromValue, const double ToValue, int tmpX);
	void __fastcall SetBoxSize(const double Value);
	void __fastcall SetDown(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetReversal(const double Value);
	void __fastcall SetUp(Fmxtee::Engine::TSeriesPointer* const Value);
	
protected:
	int __fastcall CalcMaxColumns(bool Draw = false);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TPointFigureSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPointFigureSeries();
	virtual int __fastcall CountLegendItems();
	int __fastcall GetInversionColumn(int Index);
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Fmxtee::Engine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	
__published:
	__property double BoxSize = {read=FBoxSize, write=SetBoxSize};
	__property Fmxtee::Engine::TSeriesPointer* DownSymbol = {read=FDown, write=SetDown};
	__property double ReversalAmount = {read=FReversal, write=SetReversal};
	__property Fmxtee::Engine::TSeriesPointer* UpSymbol = {read=FUp, write=SetUp};
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
	Fmxtee::Canvas::TDoubleArray __fastcall CalculateSAR(const int ACount, const double FirstClose, const Fmxtee::Engine::TChartValues HighValues, const Fmxtee::Engine::TChartValues LowValues);
	void __fastcall SetAF(const double Value);
	void __fastcall SetMS(const double Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TSARFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property double AccelerationFactor = {read=FAF, write=SetAF};
	__property double MaxStep = {read=FMS, write=SetMS};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSARFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Fmxtee::Engine::TChartSeriesClass TeeVolumeSeriesClass;
extern DELPHI_PACKAGE Fmxtee::Engine::TChartSeriesClass TeeCandleSeriesClass;
}	/* namespace Ohlc */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_OHLC)
using namespace Fmxtee::Series::Ohlc;
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
#endif	// Fmxtee_Series_OhlcHPP
