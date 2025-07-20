// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.CandleCh.pas' rev: 34.00 (Windows)

#ifndef Vcltee_CandlechHPP
#define Vcltee_CandlechHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.OHLChart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Candlech
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

class PASCALIMPLEMENTATION TCandleSeries : public Vcltee::Ohlchart::TOHLCSeries
{
	typedef Vcltee::Ohlchart::TOHLCSeries inherited;
	
	
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
	Vcltee::Tecanvas::TTeeGradient* FDownClose;
	TCandleBorderColor FHighLowColor;
	Vcltee::Tecanvas::TTeePen* FHighLowPen;
	bool FRemoveGaps;
	bool FShowCloseTick;
	bool FShowOpenTick;
	Vcltee::Tecanvas::TTeeGradient* FUpClose;
	System::Uitypes::TColor FOpenTickColor;
	System::Uitypes::TColor FCloseTickColor;
	int ISize;
	System::Types::TPoint OldP;
	void __fastcall CalcItem(int ValueIndex, /* out */ TCandleItem &AItem);
	int __fastcall GetCandleDepth();
	bool __fastcall GetDark3D();
	System::Uitypes::TColor __fastcall GetDownColor();
	bool __fastcall GetDraw3D();
	Vcltee::Tecanvas::TTeePen* __fastcall GetPen();
	System::Uitypes::TColor __fastcall GetUpColor();
	void __fastcall SetAutoSize(const bool Value);
	void __fastcall SetBorderColor(const TCandleBorderColor Value);
	void __fastcall SetCandleDepth(const int Value);
	void __fastcall SetCandlePen(Vcltee::Tecanvas::TTeePen* Value);
	void __fastcall SetCandleStyle(TCandleStyle Value);
	void __fastcall SetCandleWidth(int Value);
	void __fastcall SetColorStyle(const TCandleColorStyle Value);
	HIDESBASE void __fastcall SetDark3D(bool Value);
	void __fastcall SetDownColor(const System::Uitypes::TColor Value);
	void __fastcall SetDownGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetDraw3D(bool Value);
	void __fastcall SetHighLowColor(const TCandleBorderColor Value);
	void __fastcall SetHighLowPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetRemoveGaps(const bool Value);
	void __fastcall SetShowCloseTick(bool Value);
	void __fastcall SetShowOpenTick(bool Value);
	void __fastcall SetUpColor(const System::Uitypes::TColor Value);
	void __fastcall SetUpGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetOpenTickColor(const System::Uitypes::TColor Value);
	void __fastcall SetCloseTickColor(const System::Uitypes::TColor Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	System::Uitypes::TColor __fastcall CalculateColor(int ValueIndex);
	Vcltee::Tecanvas::TCustomTeeGradient* __fastcall CalculateGradient(int ValueIndex);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	virtual void __fastcall DrawValue(int ValueIndex);
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual bool __fastcall HasPointLabels();
	virtual bool __fastcall IsPointInChartRect(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	DYNAMIC void __fastcall RecalcAxisMargins(Vcltee::Teengine::TChartAxis* const Axis, System::Types::TRect &R);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TCandleSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCandleSeries();
	HIDESBASE int __fastcall Add(const System::TDateTime ADate, const double AOpen, const double AHigh, const double ALow, const double AClose)/* overload */;
	int __fastcall AddCandle(const System::TDateTime ADate, const double AOpen, const double AHigh, const double ALow, const double AClose, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	bool __fastcall ClickedCandle(int ValueIndex, const System::Types::TPoint &P);
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
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
	__property System::Uitypes::TColor DownCloseColor = {read=GetDownColor, write=SetDownColor, default=255};
	__property Vcltee::Tecanvas::TTeeGradient* DownCloseGradient = {read=FDownClose, write=SetDownGradient};
	__property TCandleBorderColor HighLowColor = {read=FHighLowColor, write=SetHighLowColor, default=0};
	__property Vcltee::Tecanvas::TTeePen* HighLowPen = {read=FHighLowPen, write=SetHighLowPen};
	__property System::Uitypes::TColor OpenTickColor = {read=FOpenTickColor, write=SetOpenTickColor, default=536870911};
	__property System::Uitypes::TColor CloseTickColor = {read=FCloseTickColor, write=SetCloseTickColor, default=536870911};
	__property bool ShowCloseTick = {read=FShowCloseTick, write=SetShowCloseTick, default=1};
	__property bool ShowOpenTick = {read=FShowOpenTick, write=SetShowOpenTick, default=1};
	__property System::Uitypes::TColor UpCloseColor = {read=GetUpColor, write=SetUpColor, default=16777215};
	__property Vcltee::Tecanvas::TTeeGradient* UpCloseGradient = {read=FUpClose, write=SetUpGradient};
	__property Vcltee::Tecanvas::TTeePen* Pen = {read=GetPen, write=SetCandlePen};
	__property bool RemoveGaps = {read=FRemoveGaps, write=SetRemoveGaps, default=0};
	__property Transparency = {default=0};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Add(const double AValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000)){ return Vcltee::Teengine::TChartSeries::Add(AValue, ALabel, AColor); }
	inline int __fastcall  Add(const double *ADetail, const int ADetail_High, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000)){ return Vcltee::Teengine::TChartSeries::Add(ADetail, ADetail_High, ALabel, AColor); }
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TVolumeSeries : public Vcltee::Series::TCustomSeries
{
	typedef Vcltee::Series::TCustomSeries inherited;
	
private:
	bool FUseYOrigin;
	double FOrigin;
	System::Uitypes::TColor IColor;
	Vcltee::Teengine::TChartValueList* __fastcall GetVolumeValues();
	void __fastcall PrepareCanvas(bool Forced, System::Uitypes::TColor AColor);
	void __fastcall SetOrigin(const double Value);
	void __fastcall SetUseOrigin(const bool Value);
	void __fastcall SetVolumeValues(Vcltee::Teengine::TChartValueList* Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	int __fastcall OriginPosition();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall PrepareLegendCanvas(int ValueIndex, System::Uitypes::TColor &BackColor, Vcl::Graphics::TBrushStyle &BrushStyle);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TColor AColor);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
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
	__property Vcltee::Teengine::TChartValueList* VolumeValues = {read=GetVolumeValues, write=SetVolumeValues};
	__property XValues;
	__property double YOrigin = {read=FOrigin, write=SetOrigin};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TVolumeSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TADXFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
private:
	Vcltee::Series::TFastLineSeries* IDMDown;
	Vcltee::Series::TFastLineSeries* IDMUp;
	Vcltee::Tecanvas::TTeePen* __fastcall GetDownPen();
	Vcltee::Tecanvas::TTeePen* __fastcall GetUpPen();
	void __fastcall SetDownPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetUpPen(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TADXFunction(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TADXFunction();
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	__property Vcltee::Series::TFastLineSeries* DMDown = {read=IDMDown};
	__property Vcltee::Series::TFastLineSeries* DMUp = {read=IDMUp};
	
__published:
	__property Vcltee::Tecanvas::TTeePen* DownLinePen = {read=GetDownPen, write=SetDownPen};
	__property Vcltee::Tecanvas::TTeePen* UpLinePen = {read=GetUpPen, write=SetUpPen};
};


class PASCALIMPLEMENTATION TATRFunction : public Vcltee::Ohlchart::TFinancialFunction
{
	typedef Vcltee::Ohlchart::TFinancialFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TATRFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TATRFunction() { }
	
};


enum DECLSPEC_DENUM TRSIStyle : unsigned char { rsiOpenClose, rsiClose };

class PASCALIMPLEMENTATION TRSIFunction : public Vcltee::Teengine::TTeeMovingFunction
{
	typedef Vcltee::Teengine::TTeeMovingFunction inherited;
	
private:
	TRSIStyle FStyle;
	Vcltee::Teengine::TChartSeries* ISeries;
	Vcltee::Teengine::TChartValueList* Opens;
	Vcltee::Teengine::TChartValueList* Closes;
	void __fastcall SetStyle(const TRSIStyle Value);
	
protected:
	__classmethod virtual Vcltee::Teengine::TChartSeriesClass __fastcall GallerySource();
	DYNAMIC bool __fastcall IsValidSource(Vcltee::Teengine::TChartSeries* const Value);
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TRSIFunction(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int FirstIndex, int LastIndex);
	
__published:
	__property TRSIStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TRSIFunction() { }
	
};


class PASCALIMPLEMENTATION TDarvasSeries : public TCandleSeries
{
	typedef TCandleSeries inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRect> _TDarvasSeries__1;
	
	typedef System::DynamicArray<System::Types::TRect> _TDarvasSeries__2;
	
	
private:
	Vcltee::Tecanvas::TTeeBrush* FBoxBrush;
	Vcltee::Tecanvas::TTeePen* FBoxPen;
	Vcltee::Tecanvas::TTeeTransparency FBoxTransp;
	int FNumBoxes;
	void __fastcall SetBoxBrush(Vcltee::Tecanvas::TTeeBrush* const Value);
	void __fastcall SetBoxPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetBoxTransp(const Vcltee::Tecanvas::TTeeTransparency Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
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
	__property Vcltee::Tecanvas::TTeeBrush* BoxBrush = {read=FBoxBrush, write=SetBoxBrush};
	__property Vcltee::Tecanvas::TTeePen* BoxPen = {read=FBoxPen, write=SetBoxPen};
	__property Vcltee::Tecanvas::TTeeTransparency BoxTransparency = {read=FBoxTransp, write=SetBoxTransp, default=70};
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

typedef void __fastcall (__closure *TCompressGetDate)(Vcltee::Teengine::TTeeFunction* Sender, Vcltee::Teengine::TChartSeries* Source, int ValueIndex, System::TDateTime &Date);

class PASCALIMPLEMENTATION TCompressFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
private:
	TCompressionPeriod FCompress;
	TCompressGetDate FOnGetDate;
	void __fastcall SetCompress(const TCompressionPeriod Value);
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCompressFunction(System::Classes::TComponent* AOwner);
	DYNAMIC void __fastcall AddPoints(Vcltee::Teengine::TChartSeries* Source);
	void __fastcall CompressSeries(Vcltee::Teengine::TChartSeries* Source, Vcltee::Ohlchart::TOHLCSeries* DestOHLC, Vcltee::Teengine::TChartSeries* Volume = (Vcltee::Teengine::TChartSeries*)(0x0), Vcltee::Teengine::TChartSeries* DestVolume = (Vcltee::Teengine::TChartSeries*)(0x0));
	
__published:
	__property TCompressionPeriod Compress = {read=FCompress, write=SetCompress, default=1};
	__property TCompressGetDate OnGetDate = {read=FOnGetDate, write=FOnGetDate};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCompressFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 DefCandleWidth = System::Int8(0x4);
}	/* namespace Candlech */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_CANDLECH)
using namespace Vcltee::Candlech;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_CandlechHPP
