// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Rose.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Series_RoseHPP
#define Fmxtee_Series_RoseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Polar.hpp>
#include <System.Math.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Rose
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRoseSeries;
class DELPHICLASS TCustom2DPolarSeries;
class DELPHICLASS TWindRoseSeries;
class DELPHICLASS TClockHand;
class DELPHICLASS TClockSeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TMultiRose : unsigned char { mrNone, mrStacked };

class PASCALIMPLEMENTATION TRoseSeries : public Fmxtee::Series::Polar::TPolarSeries
{
	typedef Fmxtee::Series::Polar::TPolarSeries inherited;
	
private:
	TMultiRose FMultiRose;
	int IFirst;
	Fmxtee::Canvas::TFourPoints Points;
	void __fastcall CalcPolygon(int ValueIndex);
	double __fastcall InheritedMaxXValue();
	double __fastcall InheritedMaxYValue();
	void __fastcall SetMultiRose(const TMultiRose Value);
	void __fastcall SetOtherRoses(bool SetOthers);
	
protected:
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TRoseSeries(System::Classes::TComponent* AOwner);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MinYValue();
	int __fastcall PointOrigin(int ValueIndex, bool IsX)/* overload */;
	int __fastcall PointOrigin(int ValueIndexX, int ValueIndexY, bool IsX, bool IncludeSelf = true)/* overload */;
	
__published:
	__property TMultiRose MultiRose = {read=FMultiRose, write=SetMultiRose, default=0};
public:
	/* TCustomPolarSeries.Destroy */ inline __fastcall virtual ~TRoseSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TCustom2DPolarSeries : public Fmxtee::Series::Polar::TCustomPolarSeries
{
	typedef Fmxtee::Series::Polar::TCustomPolarSeries inherited;
	
protected:
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	DYNAMIC void __fastcall PrepareForGallery();
public:
	/* TCustomPolarSeries.Create */ inline __fastcall virtual TCustom2DPolarSeries(System::Classes::TComponent* AOwner) : Fmxtee::Series::Polar::TCustomPolarSeries(AOwner) { }
	/* TCustomPolarSeries.Destroy */ inline __fastcall virtual ~TCustom2DPolarSeries() { }
	
};


class PASCALIMPLEMENTATION TWindRoseSeries : public TCustom2DPolarSeries
{
	typedef TCustom2DPolarSeries inherited;
	
private:
	bool FMirrorAngles;
	bool FMirrorLabels;
	void __fastcall SetMirrorAngles(const bool Value);
	void __fastcall SetMirrorLabels(const bool Value);
	
protected:
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual System::UnicodeString __fastcall GetCircleLabel(const double Angle, int Index);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual double __fastcall GetxValue(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TWindRoseSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
	__property HorizAxis = {default=1};
	__property SeriesColor;
	__property VertAxis = {default=0};
	__property AngleIncrement = {default=0};
	__property AngleValues;
	__property Brush;
	__property CircleBackColor = {default=16777215};
	__property CircleGradient;
	__property AngleLabels;
	__property CircleLabels;
	__property CircleLabelsFont;
	__property CircleLabelsInside;
	__property CircleLabelsRotated;
	__property CirclePen;
	__property CloseCircle = {default=1};
	__property Labels;
	__property bool MirrorAngles = {read=FMirrorAngles, write=SetMirrorAngles, default=0};
	__property bool MirrorLabels = {read=FMirrorLabels, write=SetMirrorLabels, default=0};
	__property Pen;
	__property Pointer;
	__property RadiusIncrement = {default=0};
	__property RadiusValues;
	__property RotationAngle = {default=90};
	__property Transparency = {default=0};
	__property TreatNulls = {default=0};
	__property OnGetCircleLabel;
	__property OnGetPointerStyle;
public:
	/* TCustomPolarSeries.Destroy */ inline __fastcall virtual ~TWindRoseSeries() { }
	
};


enum DECLSPEC_DENUM TClockSeriesStyle : unsigned char { cssDecimal, cssRoman };

typedef void __fastcall (__closure *TClockSeriesGetTimeEvent)(TClockSeries* Sender, System::TDateTime &ATime);

class PASCALIMPLEMENTATION TClockHand : public Fmxtee::Procs::TTeeCustomShapeBrushPen
{
	typedef Fmxtee::Procs::TTeeCustomShapeBrushPen inherited;
	
private:
	int FArrow;
	int FHeight;
	int FSize;
	int FWidth;
	TClockSeries* ISeries;
	void __fastcall SetArrow(int Value);
	void __fastcall SetHeight(int Value);
	void __fastcall SetSize(int Value);
	void __fastcall SetWidth(int Value);
	
public:
	__fastcall TClockHand(TClockSeries* const AClock);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property int Arrow = {read=FArrow, write=SetArrow, default=50};
	__property Brush;
	__property int Height = {read=FHeight, write=SetHeight, nodefault};
	__property Pen;
	__property int Size = {read=FSize, write=SetSize, nodefault};
	__property Visible;
	__property int Width = {read=FWidth, write=SetWidth, nodefault};
public:
	/* TTeeCustomShapeBrushPen.Destroy */ inline __fastcall virtual ~TClockHand() { }
	
};


class PASCALIMPLEMENTATION TClockSeries _DEPRECATED_ATTRIBUTE1("Use TClockGauge series")  : public TCustom2DPolarSeries
{
	typedef TCustom2DPolarSeries inherited;
	
private:
	Fmxtee::Engine::TSeriesPointer* FCenter _DEPRECATED_ATTRIBUTE0 ;
	bool FCustomTime _DEPRECATED_ATTRIBUTE0 ;
	TClockHand* FHours _DEPRECATED_ATTRIBUTE0 ;
	TClockHand* FMinutes _DEPRECATED_ATTRIBUTE0 ;
	TClockSeriesGetTimeEvent FOnGetTime _DEPRECATED_ATTRIBUTE0 ;
	TClockHand* FSeconds _DEPRECATED_ATTRIBUTE0 ;
	TClockSeriesStyle FStyle _DEPRECATED_ATTRIBUTE0 ;
	System::TDateTime FTime _DEPRECATED_ATTRIBUTE0 ;
	bool OldAxesVisible _DEPRECATED_ATTRIBUTE0 ;
	Fmx::Types::TTimer* ITimer _DEPRECATED_ATTRIBUTE0 ;
	void __fastcall CustomizeChart _DEPRECATED_ATTRIBUTE0 ();
	Fmxtee::Canvas::TTeePen* __fastcall GetPenHours _DEPRECATED_ATTRIBUTE0 ();
	Fmxtee::Canvas::TTeePen* __fastcall GetPenMinutes _DEPRECATED_ATTRIBUTE0 ();
	Fmxtee::Canvas::TTeePen* __fastcall GetPenSeconds _DEPRECATED_ATTRIBUTE0 ();
	void __fastcall ResetAxes _DEPRECATED_ATTRIBUTE0 ();
	void __fastcall SetCenter _DEPRECATED_ATTRIBUTE0 (Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetHours _DEPRECATED_ATTRIBUTE0 (TClockHand* const Value);
	void __fastcall SetMinutes _DEPRECATED_ATTRIBUTE0 (TClockHand* const Value);
	void __fastcall SetPenHours _DEPRECATED_ATTRIBUTE0 (Fmxtee::Canvas::TTeePen* Value);
	void __fastcall SetPenMinutes _DEPRECATED_ATTRIBUTE0 (Fmxtee::Canvas::TTeePen* Value);
	void __fastcall SetPenSeconds _DEPRECATED_ATTRIBUTE0 (Fmxtee::Canvas::TTeePen* Value);
	void __fastcall SetSeconds _DEPRECATED_ATTRIBUTE0 (TClockHand* const Value);
	void __fastcall SetStyle _DEPRECATED_ATTRIBUTE0 (TClockSeriesStyle Value);
	void __fastcall TimerExpired _DEPRECATED_ATTRIBUTE0 (System::TObject* Sender);
	bool __fastcall IsTimeStored _DEPRECATED_ATTRIBUTE0 ();
	void __fastcall SetCustomTime _DEPRECATED_ATTRIBUTE0 (const bool Value);
	void __fastcall SetTime _DEPRECATED_ATTRIBUTE0 (const System::TDateTime Value);
	
protected:
	virtual void __fastcall AssignFormatting _DEPRECATED_ATTRIBUTE0 (Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall DoBeforeDrawValues _DEPRECATED_ATTRIBUTE0 ();
	virtual void __fastcall DrawAllValues _DEPRECATED_ATTRIBUTE0 ();
	virtual System::UnicodeString __fastcall GetCircleLabel _DEPRECATED_ATTRIBUTE0 (const double Angle, int Index);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass _DEPRECATED_ATTRIBUTE0 ();
	DYNAMIC void __fastcall PrepareForGallery _DEPRECATED_ATTRIBUTE0 ();
	virtual void __fastcall SetActive _DEPRECATED_ATTRIBUTE0 (bool Value);
	virtual void __fastcall SetParentChart _DEPRECATED_ATTRIBUTE0 (Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TClockSeries _DEPRECATED_ATTRIBUTE0 (System::Classes::TComponent* AOwner);
	__fastcall virtual ~TClockSeries _DEPRECATED_ATTRIBUTE0 ();
	System::TDateTime __fastcall ClockTime _DEPRECATED_ATTRIBUTE0 ();
	virtual int __fastcall CountLegendItems _DEPRECATED_ATTRIBUTE0 ();
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor _DEPRECATED_ATTRIBUTE0 (int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString _DEPRECATED_ATTRIBUTE0 (int LegendIndex, Fmxtee::Engine::TLegendTextStyle LegendTextStyle);
	DYNAMIC int __fastcall NumSampleValues _DEPRECATED_ATTRIBUTE0 ();
	__property Fmx::Types::TTimer* Timer = {read=ITimer};
	
__published:
	__property Active _DEPRECATED_ATTRIBUTE0  = {default=1};
	__property Brush _DEPRECATED_ATTRIBUTE0 ;
	__property Fmxtee::Engine::TSeriesPointer* Center = {read=FCenter, write=SetCenter};
	__property CircleBackColor _DEPRECATED_ATTRIBUTE0  = {default=16777215};
	__property CircleGradient _DEPRECATED_ATTRIBUTE0 ;
	__property Circled _DEPRECATED_ATTRIBUTE0  = {default=1};
	__property CircleLabels _DEPRECATED_ATTRIBUTE0 ;
	__property CircleLabelsFont _DEPRECATED_ATTRIBUTE0 ;
	__property CircleLabelsInside _DEPRECATED_ATTRIBUTE0 ;
	__property CircleLabelsRotated _DEPRECATED_ATTRIBUTE0 ;
	__property AngleLabels _DEPRECATED_ATTRIBUTE0 ;
	__property CirclePen _DEPRECATED_ATTRIBUTE0 ;
	__property bool CustomTime = {read=FCustomTime, write=SetCustomTime, default=0};
	__property Labels _DEPRECATED_ATTRIBUTE0 ;
	__property TClockHand* Hours = {read=FHours, write=SetHours};
	__property TClockHand* Minutes = {read=FMinutes, write=SetMinutes};
	__property TClockHand* Seconds = {read=FSeconds, write=SetSeconds};
	__property Fmxtee::Canvas::TTeePen* PenHours = {read=GetPenHours, write=SetPenHours};
	__property Fmxtee::Canvas::TTeePen* PenMinutes = {read=GetPenMinutes, write=SetPenMinutes};
	__property Fmxtee::Canvas::TTeePen* PenSeconds = {read=GetPenSeconds, write=SetPenSeconds};
	__property RotationAngle _DEPRECATED_ATTRIBUTE0  = {default=90};
	__property ShowInLegend _DEPRECATED_ATTRIBUTE0  = {default=0};
	__property TClockSeriesStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property System::TDateTime Time = {read=ClockTime, write=SetTime, stored=IsTimeStored};
	__property Transparency _DEPRECATED_ATTRIBUTE0  = {default=0};
	__property OnGetCircleLabel _DEPRECATED_ATTRIBUTE0 ;
	__property TClockSeriesGetTimeEvent OnGetTime = {read=FOnGetTime, write=FOnGetTime};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Rose */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_ROSE)
using namespace Fmxtee::Series::Rose;
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
#endif	// Fmxtee_Series_RoseHPP
