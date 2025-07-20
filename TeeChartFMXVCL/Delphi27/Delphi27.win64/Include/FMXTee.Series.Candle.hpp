// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Candle.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_CandleHPP
#define Fmxtee_Series_CandleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.OHLC.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Candle
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCandleSeries;
class DELPHICLASS TVolumeSeries;
class DELPHICLASS TADXFunction;
class DELPHICLASS TATRFunction;
class DELPHICLASS TRSIFunction;
class DELPHICLASS TDarvasSeries;
class DELPHICLASS TCompressFunction;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TCandleStyle : unsigned char { csCandleStick, csCandleBar, csOpenClose, csLine };

enum DECLSPEC_DENUM TCandleColorStyle : unsigned char { cssRelativeToOpen, cssRelativeToClose };

enum DECLSPEC_DENUM TCandleBorderColor : unsigned char { cbUseColor, cbSameAsCandle };

class PASCALIMPLEMENTATION TCandleSeries : public Fmxtee::Series::Ohlc::TOHLCSeries
{
	typedef Fmxtee::Series::Ohlc::TOHLCSeries inherited;
	
	
private:
	struct DECLSPEC_DRECORD TCandleItem
	{
	public:
		int yOpen;
		int yClose;
		int yHigh;
		int yLow;
		int tmpX;
		int Left;
		int Right;
	};
	
	
	
private:
	bool FAutoSize;
	TCandleBorderColor FBorderColor;
	TCandleStyle FCandleStyle;
	int FCandleWidth;
	TCandleColorStyle FColorStyle;
	Fmxtee::Canvas::TTeeGradient* FDownClose;
	TCandleBorderColor FHighLowColor;
	Fmxtee::Canvas::TTeePen* FHighLowPen;
	bool FRemoveGaps;
	bool FShowCloseTick;
	bool FShowOpenTick;
	Fmxtee::Canvas::TTeeGradient* FUpClose;
	System::Uitypes::TAlphaColor FOpenTickColor;
	System::Uitypes::TAlphaColor FCloseTickColor;
	int ISize;
	System::Types::TPointF OldP;
	void __fastcall CalcItem(int ValueIndex, /* out */ TCandleItem &AItem);
	int __fastcall GetCandleDepth();
	bool __fastcall GetDark3D();
	System::Uitypes::TAlphaColor __fastcall GetDownColor();
	bool __fastcall GetDraw3D();
	Fmxtee::Canvas::TTeePen* __fastcall GetPen();
	System::Uitypes::TAlphaColor __fastcall GetUpColor();
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetBorderColor(const TCandleBorderColor Value);
	void __fastcall SetCandleDepth(const int Value);
	void __fastcall SetCandlePen(Fmxtee::Canvas::TTeePen* Value);
	void __fastcall SetCandleStyle(TCandleStyle Value);
	void __fastcall SetCandleWidth(int Value);
	void __fastcall SetColorStyle(const TCandleColorStyle Value);
	HIDESBASE void __fastcall SetDark3D(bool Value);
	void __fastcall SetDownColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetDownGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetDraw3D(bool Value);
	void __fastcall SetHighLowColor(const TCandleBorderColor Value);
	void __fastcall SetHighLowPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetRemoveGaps(const bool Value);
	void __fastcall SetShowCloseTick(bool Value);
	void __fastcall SetShowOpenTick(bool Value);
	void __fastcall SetUpColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetUpGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetOpenTickColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetCloseTickColor(const System::Uitypes::TAlphaColor Value);
	
protected:
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	System::Uitypes::TAlphaColor __fastcall CalculateColor(int ValueIndex);
	Fmxtee::Canvas::TCustomTeeGradient* __fastcall CalculateGradient(int ValueIndex);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	virtual void __fastcall DrawValue(int ValueIndex);
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual bool __fastcall HasPointLabels();
	virtual bool __fastcall IsPointInChartRect(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	DYNAMIC void __fastcall RecalcAxisMargins(Fmxtee::Engine::TChartAxis* const Axis, System::Types::TRectF &R);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TCandleSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCandleSeries();
	HIDESBASE int __fastcall Add(const System::TDateTime ADate, const double AOpen, const double AHigh, const double ALow, const double AClose)/* overload */;
	int __fastcall AddCandle(const System::TDateTime ADate, const double AOpen, const double AHigh, const double ALow, const double AClose, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	bool __fastcall ClickedCandle(int ValueIndex, const System::Types::TPointF &P);
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor(int LegendIndex);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	__property int CandleDepth = {read=GetCandleDepth, write=SetCandleDepth, nodefault};
	
__published:
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
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
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property TCandleBorderColor BorderColor = {read=FBorderColor, write=SetBorderColor, default=0};
	__property TCandleStyle CandleStyle = {read=FCandleStyle, write=SetCandleStyle, default=0};
	__property int CandleWidth = {read=FCandleWidth, write=SetCandleWidth, default=4};
	__property TCandleColorStyle ColorStyle = {read=FColorStyle, write=SetColorStyle, default=0};
	__property bool Draw3D = {read=GetDraw3D, write=SetDraw3D, default=1};
	__property bool Dark3D = {read=GetDark3D, write=SetDark3D, default=1};
	__property System::Uitypes::TAlphaColor DownCloseColor = {read=GetDownColor, write=SetDownColor, default=-65536};
	__property Fmxtee::Canvas::TTeeGradient* DownCloseGradient = {read=FDownClose, write=SetDownGradient};
	__property TCandleBorderColor HighLowColor = {read=FHighLowColor, write=SetHighLowColor, default=0};
	__property Fmxtee::Canvas::TTeePen* HighLowPen = {read=FHighLowPen, write=SetHighLowPen};
	__property System::Uitypes::TAlphaColor OpenTickColor = {read=FOpenTickColor, write=SetOpenTickColor, default=0};
	__property System::Uitypes::TAlphaColor CloseTickColor = {read=FCloseTickColor, write=SetCloseTickColor, default=0};
	__property bool ShowCloseTick = {read=FShowCloseTick, write=SetShowCloseTick, default=1};
	__property bool ShowOpenTick = {read=FShowOpenTick, write=SetShowOpenTick, default=1};
	__property System::Uitypes::TAlphaColor UpCloseColor = {read=GetUpColor, write=SetUpColor, default=-1};
	__property Fmxtee::Canvas::TTeeGradient* UpCloseGradient = {read=FUpClose, write=SetUpGradient};
	__property Fmxtee::Canvas::TTeePen* Pen = {read=GetPen, write=SetCandlePen};
	__property bool RemoveGaps = {read=FRemoveGaps, write=SetRemoveGaps, default=0};
	__property Transparency = {default=0};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Add(const double AValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff)){ return Fmxtee::Engine::TChartSeries::Add(AValue, ALabel, AColor); }
	inline int __fastcall  Add(const double *ADetail, const int ADetail_High, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff)){ return Fmxtee::Engine::TChartSeries::Add(ADetail, ADetail_High, ALabel, AColor); }
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TVolumeSeries : public Fmxtee::Series::TCustomSeries
{
	typedef Fmxtee::Series::TCustomSeries inherited;
	
private:
	bool FUseYOrigin;
	double FOrigin;
	System::Uitypes::TAlphaColor IColor;
	Fmxtee::Engine::TChartValueList* __fastcall GetVolumeValues();
	void __fastcall PrepareCanvas(bool Forced, System::Uitypes::TAlphaColor AColor);
	void __fastcall SetOrigin(const double Value);
	void __fastcall SetUseOrigin(const bool Value);
	void __fastcall SetVolumeValues(Fmxtee::Engine::TChartValueList* Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	int __fastcall OriginPosition();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall PrepareLegendCanvas(int ValueIndex, System::Uitypes::TAlphaColor &BackColor, Fmx::Graphics::TBrushKind &BrushStyle);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TAlphaColor AColor);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TVolumeSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property Transparency = {default=0};
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
	__property LinePen;
	__property bool UseYOrigin = {read=FUseYOrigin, write=SetUseOrigin, default=0};
	__property Fmxtee::Engine::TChartValueList* VolumeValues = {read=GetVolumeValues, write=SetVolumeValues};
	__property XValues;
	__property double YOrigin = {read=FOrigin, write=SetOrigin};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TVolumeSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TADXFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
private:
	Fmxtee::Series::TFastLineSeries* IDMDown;
	Fmxtee::Series::TFastLineSeries* IDMUp;
	Fmxtee::Canvas::TTeePen* __fastcall GetDownPen();
	Fmxtee::Canvas::TTeePen* __fastcall GetUpPen();
	void __fastcall SetDownPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetUpPen(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TADXFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TADXFunction();
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	__property Fmxtee::Series::TFastLineSeries* DMDown = {read=IDMDown};
	__property Fmxtee::Series::TFastLineSeries* DMUp = {read=IDMUp};
	
__published:
	__property Fmxtee::Canvas::TTeePen* DownLinePen = {read=GetDownPen, write=SetDownPen};
	__property Fmxtee::Canvas::TTeePen* UpLinePen = {read=GetUpPen, write=SetUpPen};
};


class PASCALIMPLEMENTATION TATRFunction : public Fmxtee::Series::Ohlc::TFinancialFunction
{
	typedef Fmxtee::Series::Ohlc::TFinancialFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TATRFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TATRFunction() { }
	
};


enum DECLSPEC_DENUM TRSIStyle : unsigned char { rsiOpenClose, rsiClose };

class PASCALIMPLEMENTATION TRSIFunction : public Fmxtee::Engine::TTeeMovingFunction
{
	typedef Fmxtee::Engine::TTeeMovingFunction inherited;
	
private:
	TRSIStyle FStyle;
	Fmxtee::Engine::TChartSeries* ISeries;
	Fmxtee::Engine::TChartValueList* Opens;
	Fmxtee::Engine::TChartValueList* Closes;
	void __fastcall SetStyle(const TRSIStyle Value);
	
protected:
	__classmethod virtual Fmxtee::Engine::TChartSeriesClass __fastcall GallerySource();
	DYNAMIC bool __fastcall IsValidSource(Fmxtee::Engine::TChartSeries* const Value);
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TRSIFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	
__published:
	__property TRSIStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TRSIFunction() { }
	
};


class PASCALIMPLEMENTATION TDarvasSeries : public TCandleSeries
{
	typedef TCandleSeries inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRectF> _TDarvasSeries__1;
	
	typedef System::DynamicArray<System::Types::TRectF> _TDarvasSeries__2;
	
	
private:
	Fmxtee::Canvas::TTeeBrush* FBoxBrush;
	Fmxtee::Canvas::TTeePen* FBoxPen;
	Fmxtee::Canvas::TTeeTransparency FBoxTransp;
	int FNumBoxes;
	void __fastcall SetBoxBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetBoxPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetBoxTransp(const Fmxtee::Canvas::TTeeTransparency Value);
	
protected:
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	void __fastcall CalculateBoxes();
	virtual void __fastcall DrawAllValues();
	
public:
	_TDarvasSeries__1 Boxes;
	_TDarvasSeries__2 BoxesRect;
	__fastcall virtual TDarvasSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDarvasSeries();
	int __fastcall ClickedBox(int x, int y);
	__property int NumBoxes = {read=FNumBoxes, nodefault};
	
__published:
	__property Active = {default=1};
	__property Fmxtee::Canvas::TTeeBrush* BoxBrush = {read=FBoxBrush, write=SetBoxBrush};
	__property Fmxtee::Canvas::TTeePen* BoxPen = {read=FBoxPen, write=SetBoxPen};
	__property Fmxtee::Canvas::TTeeTransparency BoxTransparency = {read=FBoxTransp, write=SetBoxTransp, default=70};
	__property Brush;
	__property ColorEachPoint = {default=0};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property Transparency = {default=0};
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
};


enum DECLSPEC_DENUM TCompressionPeriod : unsigned char { ocDay, ocWeek, ocMonth, ocBiMonth, ocQuarter, ocYear, ocSecond, ocTenSecond, ocMinute, ocTwoMinutes, ocFiveMinutes, ocTenMinutes, ocFifteenMinutes, ocTwentyMinutes, ocHalfHour, ocHour, ocTwoHours, ocThreeHour, ocSixHour, ocTwelveHour };

typedef void __fastcall (__closure *TCompressGetDate)(Fmxtee::Engine::TTeeFunction* Sender, Fmxtee::Engine::TChartSeries* Source, int ValueIndex, System::TDateTime &Date);

class PASCALIMPLEMENTATION TCompressFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
private:
	TCompressionPeriod FCompress;
	TCompressGetDate FOnGetDate;
	void __fastcall SetCompress(const TCompressionPeriod Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCompressFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Fmxtee::Engine::TChartSeries* Source);
	void __fastcall CompressSeries(Fmxtee::Engine::TChartSeries* Source, Fmxtee::Series::Ohlc::TOHLCSeries* DestOHLC, Fmxtee::Engine::TChartSeries* Volume = (Fmxtee::Engine::TChartSeries*)(0x0), Fmxtee::Engine::TChartSeries* DestVolume = (Fmxtee::Engine::TChartSeries*)(0x0));
	
__published:
	__property TCompressionPeriod Compress = {read=FCompress, write=SetCompress, default=1};
	__property TCompressGetDate OnGetDate = {read=FOnGetDate, write=FOnGetDate};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCompressFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 DefCandleWidth = System::Int8(0x4);
}	/* namespace Candle */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_CANDLE)
using namespace Fmxtee::Series::Candle;
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
#endif	// Fmxtee_Series_CandleHPP
