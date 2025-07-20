// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.StatChar.pas' rev: 34.00 (Windows)

#ifndef Vcltee_StatcharHPP
#define Vcltee_StatcharHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.CandleCh.hpp>
#include <VCLTee.OHLChart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Statchar
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
class PASCALIMPLEMENTATION TMovingAverageFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
private:
	bool FWeighted;
	bool FWeightedIndex;
	void __fastcall SetWeighted(bool Value);
	void __fastcall SetWeightedIndex(const bool Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	
__published:
	__property bool Weighted = {read=FWeighted, write=SetWeighted, default=0};
	__property bool WeightedIndex = {read=FWeightedIndex, write=SetWeightedIndex, default=0};
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TMovingAverageFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TMovingAverageFunction() { }
	
};


class PASCALIMPLEMENTATION TExpMovAveFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	bool FIgnoreNulls;
	void __fastcall SetIgnoreNulls(const bool Value);
	
public:
	__fastcall virtual TExpMovAveFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property bool IgnoreNulls = {read=FIgnoreNulls, write=SetIgnoreNulls, default=1};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TExpMovAveFunction() { }
	
};


class PASCALIMPLEMENTATION TExpAverageFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
private:
	double FWeight;
	void __fastcall SetWeight(const double Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TExpAverageFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	
__published:
	__property double Weight = {read=FWeight, write=SetWeight};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TExpAverageFunction() { }
	
};


class PASCALIMPLEMENTATION TSmoothedMovAvgFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
private:
	double IFirstMovAvg;
	
protected:
	virtual void __fastcall DoCalculation(Vcltee::Teengine::TChartSeries* Source, Vcltee::Teengine::TChartValueList* NotMandatorySource);
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TSmoothedMovAvgFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSmoothedMovAvgFunction() { }
	
};


class PASCALIMPLEMENTATION TMomentumFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
public:
	__fastcall virtual TMomentumFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int FirstIndex, int LastIndex);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TMomentumFunction() { }
	
};


class PASCALIMPLEMENTATION TMomentumDivFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TMomentumDivFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int FirstIndex, int LastIndex);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TMomentumDivFunction() { }
	
};


typedef System::DynamicArray<Vcltee::Tecanvas::TFloatPoint> TFloatPointArray;

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

class PASCALIMPLEMENTATION TKDEFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	Vcltee::Teengine::TChartValueList* FSourceValues;
	TFloatPointArray FKDEPoints;
	TKDEOptions* FOptions;
	double FPosition;
	double FClampMin;
	double FClampMax;
	
protected:
	TFloatPointArray __fastcall KernelDensityEstimator(double *x, const int x_High, Vcltee::Teengine::TChartValueList* vals);
	void __fastcall SetPosition(double aPos);
	void __fastcall SetClampMax(double aVal);
	void __fastcall SetClampMin(double aVal);
	TKDEOptions* __fastcall GetOptions();
	
public:
	__fastcall virtual TKDEFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall Clear();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source)/* overload */;
	void __fastcall AddListPoints(Vcltee::Teengine::TChartValueList* Source)/* overload */;
	
__published:
	__property double Position = {read=FPosition, write=SetPosition};
	__property double ClampMax = {read=FClampMax, write=SetClampMax};
	__property double ClampMin = {read=FClampMin, write=SetClampMin};
	__property TKDEOptions* Options = {read=GetOptions, write=FOptions};
	__property TFloatPointArray KDEPoints = {read=FKDEPoints, write=FKDEPoints};
	void __fastcall CalculateKDE();
	void __fastcall CalcClampRange();
	void __fastcall CalculateValues(Vcltee::Teengine::TChartValueList* aValues);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TKDEFunction() { }
	
};


class PASCALIMPLEMENTATION TRMSFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	bool FComplete;
	void __fastcall SetComplete(const bool Value);
	
protected:
	virtual double __fastcall CalculateValue(const Vcltee::Teengine::TChartValues Values);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
__published:
	__property bool Complete = {read=FComplete, write=SetComplete, default=0};
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TRMSFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TRMSFunction() { }
	
};


class PASCALIMPLEMENTATION TStdDeviationFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	bool FComplete;
	void __fastcall SetComplete(bool Value);
	
protected:
	virtual double __fastcall CalculateValue(const Vcltee::Teengine::TChartValues Values);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
__published:
	__property bool Complete = {read=FComplete, write=SetComplete, default=0};
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TStdDeviationFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TStdDeviationFunction() { }
	
};


class PASCALIMPLEMENTATION TMACDFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
private:
	Vcltee::Candlech::TVolumeSeries* IHisto;
	TExpMovAveFunction* IMoving1;
	TExpMovAveFunction* IMoving2;
	Vcltee::Series::TFastLineSeries* IOther;
	Vcltee::Teengine::TChartSeries* ISeries1;
	Vcltee::Teengine::TChartSeries* ISeries2;
	Vcltee::Tecanvas::TTeePen* __fastcall GetHistoPen();
	Vcltee::Tecanvas::TTeePen* __fastcall GetMACDExpPen();
	double __fastcall GetPeriod2();
	int __fastcall GetPeriod3();
	void __fastcall SetHistoPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetMACDExpPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetPeriod2(const double Value);
	void __fastcall SetPeriod3(const int Value);
	Vcltee::Tecanvas::TTeePen* __fastcall GetMACDPen();
	void __fastcall SetMACDPen(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TMACDFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMACDFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	__property Vcltee::Series::TFastLineSeries* MACDExp = {read=IOther};
	__property Vcltee::Candlech::TVolumeSeries* Histogram = {read=IHisto};
	
__published:
	__property Vcltee::Tecanvas::TTeePen* HistogramPen = {read=GetHistoPen, write=SetHistoPen};
	__property Vcltee::Tecanvas::TTeePen* MACDPen = {read=GetMACDPen, write=SetMACDPen};
	__property Vcltee::Tecanvas::TTeePen* MACDExpPen = {read=GetMACDExpPen, write=SetMACDExpPen};
	__property double Period2 = {read=GetPeriod2, write=SetPeriod2};
	__property int Period3 = {read=GetPeriod3, write=SetPeriod3, default=9};
};


class PASCALIMPLEMENTATION TStochasticFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
protected:
	Vcltee::Tecanvas::TDoubleArray FNums;
	Vcltee::Tecanvas::TDoubleArray FDens;
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TStochasticFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TStochasticFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	__classmethod virtual Vcltee::Teengine::TChartSeriesClass __fastcall GallerySource();
};


class PASCALIMPLEMENTATION THistogramSeries : public Vcltee::Series::TCustomLineSeries
{
	typedef Vcltee::Series::TCustomLineSeries inherited;
	
private:
	Vcltee::Tecanvas::TTeeHiddenPen* FLinesPen;
	double FOrigin;
	bool FUseOrigin;
	int IPrevious;
	void __fastcall InternalCalcHoriz(Vcltee::Teengine::TChartAxis* Axis, int &Min, int &Max);
	void __fastcall SetLinesPen(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	void __fastcall SetOrigin(const double Value);
	void __fastcall SetUseOrigin(bool Value);
	int __fastcall VisiblePoints();
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual System::Types::TRect __fastcall CalcRect(int ValueIndex);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	int __fastcall GetOriginPos(int ValueIndex);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
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
	__property Vcltee::Tecanvas::TTeeHiddenPen* LinesPen = {read=FLinesPen, write=SetLinesPen};
	__property Pen;
	__property Transparency = {default=0};
	__property XValues;
	__property bool UseYOrigin = {read=FUseOrigin, write=SetUseOrigin, default=0};
	__property YValues;
	__property double YOrigin = {read=FOrigin, write=SetOrigin};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION THorizHistogramSeries : public THistogramSeries
{
	typedef THistogramSeries inherited;
	
protected:
	virtual System::Types::TRect __fastcall CalcRect(int ValueIndex);
	
public:
	__fastcall virtual THorizHistogramSeries(System::Classes::TComponent* AOwner);
public:
	/* THistogramSeries.Destroy */ inline __fastcall virtual ~THorizHistogramSeries() { }
	
};


class PASCALIMPLEMENTATION TSkewnessFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	bool FComplete;
	double __fastcall Distrib(Vcltee::Teengine::TChartSeries* Series, int Exponent);
	void __fastcall SetComplete(bool Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
	
__published:
	__property bool Complete = {read=FComplete, write=SetComplete, default=0};
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TSkewnessFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSkewnessFunction() { }
	
};


class PASCALIMPLEMENTATION TKurtosisFunction : public TSkewnessFunction
{
	typedef TSkewnessFunction inherited;
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TKurtosisFunction(System::Classes::TComponent* AOwner) : TSkewnessFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TKurtosisFunction() { }
	
};


class PASCALIMPLEMENTATION TCLVFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
private:
	bool FAccumulate;
	Vcltee::Teengine::TChartSeries* FVolume;
	void __fastcall SetAccumulate(const bool Value);
	void __fastcall SetVolume(Vcltee::Teengine::TChartSeries* const Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCLVFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property bool Accumulate = {read=FAccumulate, write=SetAccumulate, default=1};
	__property Vcltee::Teengine::TChartSeries* Volume = {read=FVolume, write=SetVolume};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCLVFunction() { }
	
};


enum DECLSPEC_DENUM TCMFStyle : unsigned char { cmfLine, cmfArea, cmfVolume, cmfHistogram };

class PASCALIMPLEMENTATION TMoneyFlowFunction : public TCLVFunction
{
	typedef TCLVFunction inherited;
	
private:
	TCMFStyle FCMFStyle;
	System::Uitypes::TColor FDownColor;
	System::Uitypes::TColor FUpColor;
	Vcltee::Candlech::TVolumeSeries* IVolume;
	Vcltee::Series::TAreaSeries* IArea;
	THistogramSeries* IHistogram;
	Vcltee::Tecanvas::TTeePen* __fastcall GetAreaPen();
	Vcltee::Tecanvas::TTeePen* __fastcall GetHistoPen();
	void __fastcall SetAreaPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetCMFStyle(const TCMFStyle Value);
	void __fastcall SetDownColor(const System::Uitypes::TColor Value);
	void __fastcall SetHistoPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetUpColor(const System::Uitypes::TColor Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TMoneyFlowFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMoneyFlowFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	__property Vcltee::Series::TAreaSeries* Area = {read=IArea};
	__property THistogramSeries* Histogram = {read=IHistogram};
	
__published:
	__property Accumulate = {default=0};
	__property Vcltee::Tecanvas::TTeePen* AreaPen = {read=GetAreaPen, write=SetAreaPen};
	__property TCMFStyle CMFStyle = {read=FCMFStyle, write=SetCMFStyle, default=0};
	__property System::Uitypes::TColor DownColor = {read=FDownColor, write=SetDownColor, default=255};
	__property Vcltee::Tecanvas::TTeePen* HistogramPen = {read=GetHistoPen, write=SetHistoPen};
	__property System::Uitypes::TColor UpColor = {read=FUpColor, write=SetUpColor, default=32768};
};


class PASCALIMPLEMENTATION TRVIFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
private:
	Vcltee::Series::TFastLineSeries* ISignal;
	Vcltee::Tecanvas::TTeePen* __fastcall GetSignalPen();
	void __fastcall SetSignalPen(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TRVIFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TRVIFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	__property Vcltee::Series::TFastLineSeries* Signal = {read=ISignal};
	
__published:
	__property Vcltee::Tecanvas::TTeePen* SignalPen = {read=GetSignalPen, write=SetSignalPen};
};


class PASCALIMPLEMENTATION TAOFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TAOFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TAOFunction() { }
	
};


class PASCALIMPLEMENTATION TACFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TACFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TACFunction() { }
	
};


class PASCALIMPLEMENTATION TAlligatorFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
private:
	Vcltee::Series::TFastLineSeries* ILips;
	Vcltee::Series::TFastLineSeries* ITeeth;
	Vcltee::Tecanvas::TTeePen* __fastcall GetLipsPen();
	Vcltee::Tecanvas::TTeePen* __fastcall GetTeethPen();
	void __fastcall SetLipsPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetTeethPen(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TAlligatorFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TAlligatorFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	__property Vcltee::Series::TFastLineSeries* Teeth = {read=ITeeth};
	__property Vcltee::Series::TFastLineSeries* Lips = {read=ILips};
	
__published:
	__property Vcltee::Tecanvas::TTeePen* TeethPen = {read=GetTeethPen, write=SetTeethPen};
	__property Vcltee::Tecanvas::TTeePen* LipsPen = {read=GetLipsPen, write=SetLipsPen};
};


class PASCALIMPLEMENTATION TGatorFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
private:
	Vcltee::Candlech::TVolumeSeries* IBottom;
	
protected:
	DYNAMIC void __fastcall Clear();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TGatorFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGatorFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	__property Vcltee::Candlech::TVolumeSeries* Bottom = {read=IBottom};
};


class PASCALIMPLEMENTATION TBollingerFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	bool FExponential;
	double FDeviation;
	Vcltee::Teengine::TChartSeries* IOther;
	void __fastcall SetDeviation(const double Value);
	void __fastcall SetExponential(const bool Value);
	Vcltee::Tecanvas::TTeePen* __fastcall GetLowBandPen();
	void __fastcall SetLowBandPen(Vcltee::Tecanvas::TTeePen* const Value);
	Vcltee::Tecanvas::TTeePen* __fastcall GetUpperBandPen();
	void __fastcall SetUpperBandPen(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall Clear();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TBollingerFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TBollingerFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	__property Vcltee::Teengine::TChartSeries* LowBand = {read=IOther};
	
__published:
	__property double Deviation = {read=FDeviation, write=SetDeviation};
	__property bool Exponential = {read=FExponential, write=SetExponential, default=1};
	__property Vcltee::Tecanvas::TTeePen* LowBandPen = {read=GetLowBandPen, write=SetLowBandPen};
	__property Vcltee::Tecanvas::TTeePen* UpperBandPen = {read=GetUpperBandPen, write=SetUpperBandPen};
};


class PASCALIMPLEMENTATION TCrossPointsFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCrossPointsFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCrossPointsFunction() { }
	
};


class PASCALIMPLEMENTATION TPerformanceFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TPerformanceFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TPerformanceFunction() { }
	
};


class PASCALIMPLEMENTATION TVarianceFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
protected:
	virtual double __fastcall CalculateValue(const Vcltee::Teengine::TChartValues Values);
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TVarianceFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TVarianceFunction() { }
	
};


class PASCALIMPLEMENTATION TPerimeterFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
public:
	__fastcall virtual TPerimeterFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TPerimeterFunction() { }
	
};


class PASCALIMPLEMENTATION TPercentChangeFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TPercentChangeFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TPercentChangeFunction() { }
	
};


class PASCALIMPLEMENTATION TSlopeFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const SourceSeries, int FirstIndex, int LastIndex);
public:
	/* TTeeMovingFunction.Create */ inline __fastcall virtual TSlopeFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeMovingFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TSlopeFunction() { }
	
};


class PASCALIMPLEMENTATION TPVOFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	TExpMovAveFunction* FExpMovAve1;
	TExpMovAveFunction* FExpMovAve2;
	Vcltee::Teengine::TChartSeries* FExpSeries1;
	Vcltee::Teengine::TChartSeries* FExpSeries2;
	bool FPercent;
	int __fastcall GetPeriod2();
	void __fastcall SetPercent(const bool Value);
	void __fastcall SetPeriod2(const int Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TPVOFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPVOFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property bool Percentage = {read=FPercent, write=SetPercent, default=1};
	__property int Period2 = {read=GetPeriod2, write=SetPeriod2, default=26};
};


class PASCALIMPLEMENTATION TCCIFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
private:
	Vcltee::Teengine::TChartSeries* FAveSeries;
	double FConstant;
	TMovingAverageFunction* FMovAve;
	Vcltee::Teengine::TChartSeries* FTypical;
	bool __fastcall IsConstStored();
	void __fastcall SetConstant(const double Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCCIFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCCIFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	
__published:
	__property double Constant = {read=FConstant, write=SetConstant, stored=IsConstStored};
};


class PASCALIMPLEMENTATION TCentroidTeeFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
protected:
	__classmethod virtual Vcltee::Teengine::TChartSeriesClass __fastcall GallerySource();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TCentroidTeeFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCentroidTeeFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Statchar */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_STATCHAR)
using namespace Vcltee::Statchar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_StatcharHPP
