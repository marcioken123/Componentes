// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Functions.Stats.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Functions_StatsHPP
#define Fmxtee_Functions_StatsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Candle.hpp>
#include <FMXTee.Series.OHLC.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Functions
{
namespace Stats
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMovingAverageFunction;
class DELPHICLASS TExpMovAveFunction;
class DELPHICLASS TExpAverageFunction;
class DELPHICLASS TSmoothedMovAvgFunction;
class DELPHICLASS TMomentumFunction;
class DELPHICLASS TMomentumDivFunction;
class DELPHICLASS TKDEOptions;
class DELPHICLASS TKDEFunction;
class DELPHICLASS TRMSFunction;
class DELPHICLASS TStdDeviationFunction;
class DELPHICLASS TMACDFunction;
class DELPHICLASS TStochasticFunction;
class DELPHICLASS THistogramSeries;
class DELPHICLASS THorizHistogramSeries;
class DELPHICLASS TSkewnessFunction;
class DELPHICLASS TKurtosisFunction;
class DELPHICLASS TCLVFunction;
class DELPHICLASS TMoneyFlowFunction;
class DELPHICLASS TRVIFunction;
class DELPHICLASS TAOFunction;
class DELPHICLASS TACFunction;
class DELPHICLASS TAlligatorFunction;
class DELPHICLASS TGatorFunction;
class DELPHICLASS TBollingerFunction;
class DELPHICLASS TCrossPointsFunction;
class DELPHICLASS TPerformanceFunction;
class DELPHICLASS TVarianceFunction;
class DELPHICLASS TPerimeterFunction;
class DELPHICLASS TPercentChangeFunction;
class DELPHICLASS TSlopeFunction;
class DELPHICLASS TPVOFunction;
class DELPHICLASS TCCIFunction;
class DELPHICLASS TCentroidTeeFunction;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMovingAverageFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
private:
	bool FWeighted;
	bool FWeightedIndex;
	void __fastcall SetWeighted(bool Value);
	void __fastcall SetWeightedIndex(const bool Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	
__published:
	__property bool Weighted = {read=FWeighted, write=SetWeighted, default=0};
	__property bool WeightedIndex = {read=FWeightedIndex, write=SetWeightedIndex, default=0};
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TMovingAverageFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TMovingAverageFunction() { }
	
};


class PASCALIMPLEMENTATION TExpMovAveFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	bool FIgnoreNulls;
	void __fastcall SetIgnoreNulls(const bool Value);
	
public:
	__fastcall virtual TExpMovAveFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property bool IgnoreNulls = {read=FIgnoreNulls, write=SetIgnoreNulls, default=1};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TExpMovAveFunction() { }
	
};


class PASCALIMPLEMENTATION TExpAverageFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
private:
	double FWeight;
	void __fastcall SetWeight(const double Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TExpAverageFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	
__published:
	__property double Weight = {read=FWeight, write=SetWeight};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TExpAverageFunction() { }
	
};


class PASCALIMPLEMENTATION TSmoothedMovAvgFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
private:
	double IFirstMovAvg;
	
protected:
	virtual void __fastcall DoCalculation(Fmxtee::Engine::TChartSeries* Source, Fmxtee::Engine::TChartValueList* NotMandatorySource);
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TSmoothedMovAvgFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSmoothedMovAvgFunction() { }
	
};


class PASCALIMPLEMENTATION TMomentumFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
public:
	__fastcall virtual TMomentumFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int FirstIndex, int LastIndex);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TMomentumFunction() { }
	
};


class PASCALIMPLEMENTATION TMomentumDivFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TMomentumDivFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int FirstIndex, int LastIndex);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TMomentumDivFunction() { }
	
};


typedef System::DynamicArray<Fmxtee::Canvas::TFloatPoint> TFloatPointArray;

enum DECLSPEC_DENUM TKDEClamp : unsigned char { kdcMinMax, kdcManual };

enum DECLSPEC_DENUM TKDEType : unsigned char { kdtViolin, kdtBeeSwarm };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TKDEOptions : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TKDEType FKDEType;
	int FResolution;
	int FBandwidth;
	int FWidth;
	TKDEClamp FClamp;
	
protected:
	void __fastcall SetKDEType(TKDEType Value);
	void __fastcall SetResolution(int Value);
	void __fastcall SetBandwidth(int Value);
	void __fastcall SetWidth(int Value);
	void __fastcall SetClamp(TKDEClamp Value);
	
public:
	__property TKDEType KDEType = {read=FKDEType, write=SetKDEType, nodefault};
	__property int Resolution = {read=FResolution, write=SetResolution, nodefault};
	__property int Bandwidth = {read=FBandwidth, write=SetBandwidth, nodefault};
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
	__property TKDEClamp Clamp = {read=FClamp, write=SetClamp, nodefault};
public:
	/* TObject.Create */ inline __fastcall TKDEOptions() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TKDEOptions() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TKDEFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FSourceValues;
	TFloatPointArray FKDEPoints;
	TKDEOptions* FOptions;
	double FPosition;
	double FClampMin;
	double FClampMax;
	
protected:
	TFloatPointArray __fastcall KernelDensityEstimator(double *x, const int x_High, Fmxtee::Engine::TChartValueList* vals);
	void __fastcall SetPosition(double aPos);
	void __fastcall SetClampMax(double aVal);
	void __fastcall SetClampMin(double aVal);
	TKDEOptions* __fastcall GetOptions();
	
public:
	__fastcall virtual TKDEFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Clear();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source)/* overload */;
	void __fastcall AddListPoints(Fmxtee::Engine::TChartValueList* Source)/* overload */;
	
__published:
	__property double Position = {read=FPosition, write=SetPosition};
	__property double ClampMax = {read=FClampMax, write=SetClampMax};
	__property double ClampMin = {read=FClampMin, write=SetClampMin};
	__property TKDEOptions* Options = {read=GetOptions, write=FOptions};
	__property TFloatPointArray KDEPoints = {read=FKDEPoints, write=FKDEPoints};
	void __fastcall CalculateKDE();
	void __fastcall CalcClampRange();
	void __fastcall CalculateValues(Fmxtee::Engine::TChartValueList* aValues);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TKDEFunction() { }
	
};


class PASCALIMPLEMENTATION TRMSFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	bool FComplete;
	void __fastcall SetComplete(const bool Value);
	
protected:
	virtual double __fastcall CalculateValue(const Fmxtee::Engine::TChartValues Values);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
__published:
	__property bool Complete = {read=FComplete, write=SetComplete, default=0};
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TRMSFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TRMSFunction() { }
	
};


class PASCALIMPLEMENTATION TStdDeviationFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	bool FComplete;
	void __fastcall SetComplete(bool Value);
	
protected:
	virtual double __fastcall CalculateValue(const Fmxtee::Engine::TChartValues Values);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
__published:
	__property bool Complete = {read=FComplete, write=SetComplete, default=0};
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TStdDeviationFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TStdDeviationFunction() { }
	
};


class PASCALIMPLEMENTATION TMACDFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
private:
	Fmxtee::Series::Candle::TVolumeSeries* IHisto;
	TExpMovAveFunction* IMoving1;
	TExpMovAveFunction* IMoving2;
	Fmxtee::Series::TFastLineSeries* IOther;
	Fmxtee::Engine::TChartSeries* ISeries1;
	Fmxtee::Engine::TChartSeries* ISeries2;
	Fmxtee::Canvas::TTeePen* __fastcall GetHistoPen();
	Fmxtee::Canvas::TTeePen* __fastcall GetMACDExpPen();
	double __fastcall GetPeriod2();
	int __fastcall GetPeriod3();
	void __fastcall SetHistoPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetMACDExpPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetPeriod2(const double Value);
	void __fastcall SetPeriod3(const int Value);
	Fmxtee::Canvas::TTeePen* __fastcall GetMACDPen();
	void __fastcall SetMACDPen(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TMACDFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMACDFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	__property Fmxtee::Series::TFastLineSeries* MACDExp = {read=IOther};
	__property Fmxtee::Series::Candle::TVolumeSeries* Histogram = {read=IHisto};
	
__published:
	__property Fmxtee::Canvas::TTeePen* HistogramPen = {read=GetHistoPen, write=SetHistoPen};
	__property Fmxtee::Canvas::TTeePen* MACDPen = {read=GetMACDPen, write=SetMACDPen};
	__property Fmxtee::Canvas::TTeePen* MACDExpPen = {read=GetMACDExpPen, write=SetMACDExpPen};
	__property double Period2 = {read=GetPeriod2, write=SetPeriod2};
	__property int Period3 = {read=GetPeriod3, write=SetPeriod3, default=9};
};


class PASCALIMPLEMENTATION TStochasticFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
protected:
	Fmxtee::Canvas::TDoubleArray FNums;
	Fmxtee::Canvas::TDoubleArray FDens;
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TStochasticFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TStochasticFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	__classmethod virtual Fmxtee::Engine::TChartSeriesClass __fastcall GallerySource();
};


class PASCALIMPLEMENTATION THistogramSeries : public Fmxtee::Series::TCustomLineSeries
{
	typedef Fmxtee::Series::TCustomLineSeries inherited;
	
private:
	Fmxtee::Canvas::TTeeHiddenPen* FLinesPen;
	double FOrigin;
	bool FUseOrigin;
	float IPrevious;
	void __fastcall InternalCalcHoriz(Fmxtee::Engine::TChartAxis* Axis, int &Min, int &Max);
	void __fastcall SetLinesPen(Fmxtee::Canvas::TTeeHiddenPen* const Value);
	void __fastcall SetOrigin(const double Value);
	void __fastcall SetUseOrigin(bool Value);
	int __fastcall VisiblePoints();
	
protected:
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual System::Types::TRectF __fastcall CalcRect(int ValueIndex);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	int __fastcall GetOriginPos(int ValueIndex);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual THistogramSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~THistogramSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual void __fastcall CalcFirstLastVisibleIndex();
	
__published:
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property HorizAxis = {default=1};
	__property LinePen;
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
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
	__property Brush;
	__property Fmxtee::Canvas::TTeeHiddenPen* LinesPen = {read=FLinesPen, write=SetLinesPen};
	__property Pen;
	__property Transparency = {default=0};
	__property XValues;
	__property bool UseYOrigin = {read=FUseOrigin, write=SetUseOrigin, default=0};
	__property YValues;
	__property double YOrigin = {read=FOrigin, write=SetOrigin};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION THorizHistogramSeries : public THistogramSeries
{
	typedef THistogramSeries inherited;
	
protected:
	virtual System::Types::TRectF __fastcall CalcRect(int ValueIndex);
	
public:
	__fastcall virtual THorizHistogramSeries(System::Classes::TComponent* AOwner);
public:
	/* THistogramSeries.Destroy */ inline __fastcall virtual ~THorizHistogramSeries() { }
	
};


class PASCALIMPLEMENTATION TSkewnessFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	bool FComplete;
	double __fastcall Distrib(Fmxtee::Engine::TChartSeries* Series, int Exponent);
	void __fastcall SetComplete(bool Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
	
__published:
	__property bool Complete = {read=FComplete, write=SetComplete, default=0};
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TSkewnessFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSkewnessFunction() { }
	
};


class PASCALIMPLEMENTATION TKurtosisFunction : public TSkewnessFunction
{
	typedef TSkewnessFunction inherited;
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TKurtosisFunction(System::Classes::TComponent* AOwner) : TSkewnessFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TKurtosisFunction() { }
	
};


class PASCALIMPLEMENTATION TCLVFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
private:
	bool FAccumulate;
	Fmxtee::Engine::TChartSeries* FVolume;
	void __fastcall SetAccumulate(const bool Value);
	void __fastcall SetVolume(Fmxtee::Engine::TChartSeries* const Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCLVFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property bool Accumulate = {read=FAccumulate, write=SetAccumulate, default=1};
	__property Fmxtee::Engine::TChartSeries* Volume = {read=FVolume, write=SetVolume};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCLVFunction() { }
	
};


enum DECLSPEC_DENUM TCMFStyle : unsigned char { cmfLine, cmfArea, cmfVolume, cmfHistogram };

class PASCALIMPLEMENTATION TMoneyFlowFunction : public TCLVFunction
{
	typedef TCLVFunction inherited;
	
private:
	TCMFStyle FCMFStyle;
	System::Uitypes::TAlphaColor FDownColor;
	System::Uitypes::TAlphaColor FUpColor;
	Fmxtee::Series::Candle::TVolumeSeries* IVolume;
	Fmxtee::Series::TAreaSeries* IArea;
	THistogramSeries* IHistogram;
	Fmxtee::Canvas::TTeePen* __fastcall GetAreaPen();
	Fmxtee::Canvas::TTeePen* __fastcall GetHistoPen();
	void __fastcall SetAreaPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetCMFStyle(const TCMFStyle Value);
	void __fastcall SetDownColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetHistoPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetUpColor(const System::Uitypes::TAlphaColor Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TMoneyFlowFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMoneyFlowFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	__property Fmxtee::Series::TAreaSeries* Area = {read=IArea};
	__property THistogramSeries* Histogram = {read=IHistogram};
	
__published:
	__property Accumulate = {default=0};
	__property Fmxtee::Canvas::TTeePen* AreaPen = {read=GetAreaPen, write=SetAreaPen};
	__property TCMFStyle CMFStyle = {read=FCMFStyle, write=SetCMFStyle, default=0};
	__property System::Uitypes::TAlphaColor DownColor = {read=FDownColor, write=SetDownColor, default=-65536};
	__property Fmxtee::Canvas::TTeePen* HistogramPen = {read=GetHistoPen, write=SetHistoPen};
	__property System::Uitypes::TAlphaColor UpColor = {read=FUpColor, write=SetUpColor, default=-16744448};
};


class PASCALIMPLEMENTATION TRVIFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
private:
	Fmxtee::Series::TFastLineSeries* ISignal;
	Fmxtee::Canvas::TTeePen* __fastcall GetSignalPen();
	void __fastcall SetSignalPen(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TRVIFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRVIFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	__property Fmxtee::Series::TFastLineSeries* Signal = {read=ISignal};
	
__published:
	__property Fmxtee::Canvas::TTeePen* SignalPen = {read=GetSignalPen, write=SetSignalPen};
};


class PASCALIMPLEMENTATION TAOFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TAOFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TAOFunction() { }
	
};


class PASCALIMPLEMENTATION TACFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TACFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TACFunction() { }
	
};


class PASCALIMPLEMENTATION TAlligatorFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
private:
	Fmxtee::Series::TFastLineSeries* ILips;
	Fmxtee::Series::TFastLineSeries* ITeeth;
	Fmxtee::Canvas::TTeePen* __fastcall GetLipsPen();
	Fmxtee::Canvas::TTeePen* __fastcall GetTeethPen();
	void __fastcall SetLipsPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetTeethPen(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TAlligatorFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TAlligatorFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	__property Fmxtee::Series::TFastLineSeries* Teeth = {read=ITeeth};
	__property Fmxtee::Series::TFastLineSeries* Lips = {read=ILips};
	
__published:
	__property Fmxtee::Canvas::TTeePen* TeethPen = {read=GetTeethPen, write=SetTeethPen};
	__property Fmxtee::Canvas::TTeePen* LipsPen = {read=GetLipsPen, write=SetLipsPen};
};


class PASCALIMPLEMENTATION TGatorFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
private:
	Fmxtee::Series::Candle::TVolumeSeries* IBottom;
	
protected:
	DYNAMIC void __fastcall Clear();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TGatorFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGatorFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	__property Fmxtee::Series::Candle::TVolumeSeries* Bottom = {read=IBottom};
};


class PASCALIMPLEMENTATION TBollingerFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	bool FExponential;
	double FDeviation;
	Fmxtee::Engine::TChartSeries* IOther;
	void __fastcall SetDeviation(const double Value);
	void __fastcall SetExponential(const bool Value);
	Fmxtee::Canvas::TTeePen* __fastcall GetLowBandPen();
	void __fastcall SetLowBandPen(Fmxtee::Canvas::TTeePen* const Value);
	Fmxtee::Canvas::TTeePen* __fastcall GetUpperBandPen();
	void __fastcall SetUpperBandPen(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TBollingerFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBollingerFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	__property Fmxtee::Engine::TChartSeries* LowBand = {read=IOther};
	
__published:
	__property double Deviation = {read=FDeviation, write=SetDeviation};
	__property bool Exponential = {read=FExponential, write=SetExponential, default=1};
	__property Fmxtee::Canvas::TTeePen* LowBandPen = {read=GetLowBandPen, write=SetLowBandPen};
	__property Fmxtee::Canvas::TTeePen* UpperBandPen = {read=GetUpperBandPen, write=SetUpperBandPen};
};


class PASCALIMPLEMENTATION TCrossPointsFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCrossPointsFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCrossPointsFunction() { }
	
};


class PASCALIMPLEMENTATION TPerformanceFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TPerformanceFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TPerformanceFunction() { }
	
};


class PASCALIMPLEMENTATION TVarianceFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
protected:
	virtual double __fastcall CalculateValue(const Fmxtee::Engine::TChartValues Values);
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TVarianceFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TVarianceFunction() { }
	
};


class PASCALIMPLEMENTATION TPerimeterFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
public:
	__fastcall virtual TPerimeterFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TPerimeterFunction() { }
	
};


class PASCALIMPLEMENTATION TPercentChangeFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TPercentChangeFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TPercentChangeFunction() { }
	
};


class PASCALIMPLEMENTATION TSlopeFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TSlopeFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSlopeFunction() { }
	
};


class PASCALIMPLEMENTATION TPVOFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	TExpMovAveFunction* FExpMovAve1;
	TExpMovAveFunction* FExpMovAve2;
	Fmxtee::Engine::TChartSeries* FExpSeries1;
	Fmxtee::Engine::TChartSeries* FExpSeries2;
	bool FPercent;
	int __fastcall GetPeriod2();
	void __fastcall SetPercent(const bool Value);
	void __fastcall SetPeriod2(const int Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TPVOFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPVOFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property bool Percentage = {read=FPercent, write=SetPercent, default=1};
	__property int Period2 = {read=GetPeriod2, write=SetPeriod2, default=26};
};


class PASCALIMPLEMENTATION TCCIFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
private:
	Fmxtee::Engine::TChartSeries* FAveSeries;
	double FConstant;
	TMovingAverageFunction* FMovAve;
	Fmxtee::Engine::TChartSeries* FTypical;
	bool __fastcall IsConstStored();
	void __fastcall SetConstant(const double Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCCIFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCCIFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	
__published:
	__property double Constant = {read=FConstant, write=SetConstant, stored=IsConstStored};
};


class PASCALIMPLEMENTATION TCentroidTeeFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
protected:
	__classmethod virtual Fmxtee::Engine::TChartSeriesClass __fastcall GallerySource();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TCentroidTeeFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCentroidTeeFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Stats */
}	/* namespace Functions */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS_STATS)
using namespace Fmxtee::Functions::Stats;
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
#endif	// Fmxtee_Functions_StatsHPP
