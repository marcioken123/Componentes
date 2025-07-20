// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Polar.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_PolarHPP
#define Fmxtee_Series_PolarHPP

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
#include <System.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Polar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomCircledSeries;
class DELPHICLASS TPolarLabels;
class DELPHICLASS TCustomPolarSeries;
class DELPHICLASS TPolarSeries;
class DELPHICLASS TRadarSeries;
class DELPHICLASS TPolarBarSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomCircledSeries : public Fmxtee::Series::TCircledSeries
{
	typedef Fmxtee::Series::TCircledSeries inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FCirclePen;
	bool FColorEachLine;
	Fmxtee::Series::TCustomSeriesDrawStyle FDrawStyle;
	Fmxtee::Series::TOnGetPointerStyle FOnGetPointerStyle;
	Fmxtee::Engine::TSeriesPointer* FPointer;
	bool FPointerBehind;
	void __fastcall DoDrawAll();
	void __fastcall SetCirclePen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetColorEachLine(bool Value);
	void __fastcall SetDrawStyle(const Fmxtee::Series::TCustomSeriesDrawStyle Value);
	void __fastcall SetPointer(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetPointerBehind(const bool Value);
	
protected:
	int AxisXRadius;
	int AxisYRadius;
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcRadius();
	System::Uitypes::TAlphaColor __fastcall CalcValueColor(int ValueIndex);
	Fmxtee::Engine::TSeriesPointerStyle __fastcall DoGetPointerStyle(int ValueIndex);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual bool __fastcall ShouldCloseCircle();
	
public:
	__fastcall virtual TCustomCircledSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomCircledSeries();
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor(int LegendIndex);
	__property Fmxtee::Canvas::TTeePen* CirclePen = {read=FCirclePen, write=SetCirclePen};
	__property bool ColorEachLine = {read=FColorEachLine, write=SetColorEachLine, default=1};
	__property Fmxtee::Engine::TSeriesPointer* Pointer = {read=FPointer, write=SetPointer};
	__property bool PointerBehind = {read=FPointerBehind, write=SetPointerBehind, default=0};
	__property Fmxtee::Series::TCustomSeriesDrawStyle DrawStyle = {read=FDrawStyle, write=SetDrawStyle, default=0};
	__property Fmxtee::Series::TOnGetPointerStyle OnGetPointerStyle = {read=FOnGetPointerStyle, write=FOnGetPointerStyle};
};


class PASCALIMPLEMENTATION TPolarLabels : public Fmxtee::Procs::TTeeShape
{
	typedef Fmxtee::Procs::TTeeShape inherited;
	
private:
	bool FAntiOverlap;
	bool FClockWise;
	bool FCurved;
	bool FInside;
	int FMargin;
	bool FRotated;
	TCustomPolarSeries* IPolar;
	void __fastcall SetAntiOverlap(bool Value);
	void __fastcall SetInside(bool Value);
	void __fastcall SetClockWise(bool Value);
	void __fastcall SetCurved(bool Value);
	void __fastcall SetMargin(int Value);
	void __fastcall SetRotated(bool Value);
	
public:
	__fastcall TPolarLabels(TCustomPolarSeries* const Polar);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool AntiOverlap = {read=FAntiOverlap, write=SetAntiOverlap, default=1};
	__property Brush;
	__property bool ClockWise = {read=FClockWise, write=SetClockWise, default=0};
	__property bool Curved = {read=FCurved, write=SetCurved, default=0};
	__property bool Inside = {read=FInside, write=SetInside, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=3};
	__property Pen;
	__property bool Rotated = {read=FRotated, write=SetRotated, default=0};
	__property Transparent = {default=1};
public:
	/* TTeeCustomShape.Destroy */ inline __fastcall virtual ~TPolarLabels() { }
	
};


typedef void __fastcall (__closure *TOnGetPolarLabel)(TCustomPolarSeries* Sender, const double Angle, int Index, System::UnicodeString &Text);

class PASCALIMPLEMENTATION TCustomPolarSeries : public TCustomCircledSeries
{
	typedef TCustomCircledSeries inherited;
	
private:
	TPolarLabels* FAngleLabels;
	bool FCloseCircle;
	TOnGetPolarLabel FOnGetCircleLabel;
	int IMaxValuesCount;
	bool IShouldDrawLabels;
	void __fastcall CalcXYPos(int ValueIndex, int ARadius, /* out */ int &X, /* out */ int &Y);
	bool __fastcall DrawAxesBehind();
	void __fastcall DrawAxis();
	void __fastcall FillTriangle(const System::Types::TPointF &A, const System::Types::TPointF &B, int Z);
	double __fastcall GetAngleIncrement();
	double __fastcall GetRadiusIncrement();
	Fmxtee::Engine::TChartValueList* __fastcall GetRadiusValues();
	bool __fastcall IsRadiusStored();
	void __fastcall SetAngleIncrement(const double Value);
	void __fastcall SetAngleLabels(TPolarLabels* const Value);
	void __fastcall SetCloseCircle(bool Value);
	void __fastcall SetRadiusIncrement(const double Value);
	void __fastcall SetRadiusValues(Fmxtee::Engine::TChartValueList* const Value);
	bool __fastcall GetCircleLabels();
	void __fastcall SetCircleLabels(bool Value);
	Fmxtee::Canvas::TTeeFont* __fastcall GetCircleLabelsFont();
	void __fastcall SetCircleLabelsFont(Fmxtee::Canvas::TTeeFont* const Value);
	bool __fastcall GetCircleLabelsInside();
	void __fastcall SetCircleLabelsInside(bool Value);
	bool __fastcall GetCircleLabelsRot();
	void __fastcall SetLabelsRotated(bool Value);
	bool __fastcall GetClockWiseLabels();
	void __fastcall SetClockWiseLabels(bool Value);
	int __fastcall GetLabelsMargin();
	void __fastcall SetLabelsMargin(int Value);
	
protected:
	int OldX;
	int OldY;
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	void __fastcall CalcXYPosition(const double XValue, const double YValue, int ARadius, /* out */ int &X, /* out */ int &Y)/* overload */;
	void __fastcall CalcXYPosition(const double XValue, const double YValue, int ARadius, Fmxtee::Engine::TChartAxis* Axis, /* out */ int &X, /* out */ int &Y)/* overload */;
	void __fastcall CalcXYRadius(const double Value, /* out */ int &X, /* out */ int &Y);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoAfterDrawValues();
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawPolarCircle(int HalfWidth, int HalfHeight, int Z);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual double __fastcall GetAngleValue(int ValueIndex);
	virtual Fmxtee::Engine::TChartValueList* __fastcall GetAngleValues();
	virtual System::UnicodeString __fastcall GetCircleLabel(const double Angle, int Index);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall InternalDrawValue(int ValueIndex, int X, int Y);
	void __fastcall LinePrepareCanvas(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	void __fastcall ScreenToPoint(int X, int Y, int ValueIndex, bool ChangeX, bool ChangeY);
	virtual void __fastcall SetAngleValues(Fmxtee::Engine::TChartValueList* Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TAlphaColor AColor);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	virtual bool __fastcall ShouldCloseCircle();
	virtual void __fastcall SetAngleValue(int Index, const double Value);
	
public:
	__fastcall virtual TCustomPolarSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomPolarSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	void __fastcall DrawRing(const double Value, int Z);
	virtual bool __fastcall DrawValuesForward();
	void __fastcall DrawZone(const double Min, const double Max, int Z);
	__property double AngleIncrement = {read=GetAngleIncrement, write=SetAngleIncrement};
	__property Fmxtee::Engine::TChartValueList* AngleValues = {read=GetAngleValues, write=SetAngleValues};
	__property Brush;
	__property bool CircleLabels = {read=GetCircleLabels, write=SetCircleLabels, stored=false, nodefault};
	__property Fmxtee::Canvas::TTeeFont* CircleLabelsFont = {read=GetCircleLabelsFont, write=SetCircleLabelsFont, stored=false};
	__property bool CircleLabelsInside = {read=GetCircleLabelsInside, write=SetCircleLabelsInside, stored=false, nodefault};
	__property bool CircleLabelsRotated = {read=GetCircleLabelsRot, write=SetLabelsRotated, stored=false, nodefault};
	__property bool ClockWiseLabels = {read=GetClockWiseLabels, write=SetClockWiseLabels, stored=false, nodefault};
	__property int LabelsMargin = {read=GetLabelsMargin, write=SetLabelsMargin, stored=false, nodefault};
	__property TPolarLabels* AngleLabels = {read=FAngleLabels, write=SetAngleLabels};
	__property CirclePen;
	__property bool CloseCircle = {read=FCloseCircle, write=SetCloseCircle, default=1};
	__property ColorEachLine = {default=1};
	__property DrawStyle = {default=0};
	__property Pen;
	__property Pointer;
	__property PointerBehind = {default=0};
	__property double RadiusIncrement = {read=GetRadiusIncrement, write=SetRadiusIncrement};
	__property Fmxtee::Engine::TChartValueList* RadiusValues = {read=GetRadiusValues, write=SetRadiusValues, stored=IsRadiusStored};
	__property Transparency = {default=0};
	__property TreatNulls = {default=0};
	__property TOnGetPolarLabel OnGetCircleLabel = {read=FOnGetCircleLabel, write=FOnGetCircleLabel};
	__property OnGetPointerStyle;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
private:
	void *__ITeeScreenToPoint;	// Fmxtee::Engine::ITeeScreenToPoint 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FE1CD916-A647-4B27-8580-3842E4019919}
	operator Fmxtee::Engine::_di_ITeeScreenToPoint()
	{
		Fmxtee::Engine::_di_ITeeScreenToPoint intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Fmxtee::Engine::ITeeScreenToPoint*(void) { return (Fmxtee::Engine::ITeeScreenToPoint*)&__ITeeScreenToPoint; }
	#endif
	
};


class PASCALIMPLEMENTATION TPolarSeries : public TCustomPolarSeries
{
	typedef TCustomPolarSeries inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FAngleValues;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoAfterDrawValues();
	virtual void __fastcall DoBeforeDrawValues();
	virtual double __fastcall GetAngleValue(int ValueIndex);
	virtual Fmxtee::Engine::TChartValueList* __fastcall GetAngleValues();
	virtual void __fastcall SetAngleValue(int Index, const double Value);
	virtual void __fastcall SetAngleValues(Fmxtee::Engine::TChartValueList* Value);
	HIDESBASE void __fastcall ScreenToPoint(int X, int Y, int ValueIndex, bool ChangeX, bool ChangeY);
	
public:
	__fastcall virtual TPolarSeries(System::Classes::TComponent* AOwner);
	virtual int __fastcall AddNull(const System::UnicodeString ALabel = System::UnicodeString())/* overload */;
	virtual int __fastcall AddNullXY(const double X, const double Y, const System::UnicodeString ALabel = System::UnicodeString());
	virtual int __fastcall AddPolar(const double Angle, const double Value, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual bool __fastcall UseAxis();
	virtual bool __fastcall CanZoomScroll();
	virtual int __fastcall CalcYPosValue(const double Value);
	virtual double __fastcall XScreenToValue(int ScreenPos);
	virtual double __fastcall YScreenToValue(int ScreenPos);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall CalcXPos(int ValueIndex);
	__property double AngleValue[int Index] = {read=GetAngleValue, write=SetAngleValue};
	
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
	__property CircleBrush;
	__property CircleGradient;
	__property AngleLabels;
	__property CircleLabels;
	__property CircleLabelsFont;
	__property CircleLabelsInside;
	__property CircleLabelsRotated;
	__property ClockWiseLabels;
	__property LabelsMargin;
	__property Labels;
	__property CirclePen;
	__property CloseCircle = {default=1};
	__property DrawStyle = {default=0};
	__property Pen;
	__property Pointer;
	__property PointerBehind = {default=0};
	__property RadiusIncrement = {default=0};
	__property RadiusValues;
	__property RotationAngle = {default=0};
	__property Transparency = {default=0};
	__property TreatNulls = {default=0};
	__property OnGetCircleLabel;
	__property OnGetPointerStyle;
public:
	/* TCustomPolarSeries.Destroy */ inline __fastcall virtual ~TPolarSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  AddNull(const double Value){ return Fmxtee::Engine::TChartSeries::AddNull(Value); }
	
private:
	void *__ITeeScreenToPoint;	// Fmxtee::Engine::ITeeScreenToPoint 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FE1CD916-A647-4B27-8580-3842E4019919}
	operator Fmxtee::Engine::_di_ITeeScreenToPoint()
	{
		Fmxtee::Engine::_di_ITeeScreenToPoint intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Fmxtee::Engine::ITeeScreenToPoint*(void) { return (Fmxtee::Engine::ITeeScreenToPoint*)&__ITeeScreenToPoint; }
	#endif
	
};


class PASCALIMPLEMENTATION TRadarSeries : public TCustomPolarSeries
{
	typedef TCustomPolarSeries inherited;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoBeforeDrawChart();
	virtual System::UnicodeString __fastcall GetCircleLabel(const double Angle, int Index);
	virtual double __fastcall GetxValue(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
	__property HorizAxis = {default=1};
	__property SeriesColor;
	__property VertAxis = {default=0};
	__property Brush;
	__property CircleBackColor = {default=16777215};
	__property CircleGradient;
	__property AngleLabels;
	__property CircleLabels;
	__property CircleLabelsFont;
	__property CircleLabelsRotated;
	__property DrawStyle = {default=0};
	__property LabelsMargin;
	__property CirclePen;
	__property CloseCircle = {default=1};
	__property Labels;
	__property Pen;
	__property Pointer;
	__property PointerBehind = {default=0};
	__property RadiusIncrement = {default=0};
	__property RadiusValues;
	__property Transparency = {default=0};
	__property TreatNulls = {default=0};
	__property OnGetCircleLabel;
	__property OnGetPointerStyle;
public:
	/* TCustomPolarSeries.Create */ inline __fastcall virtual TRadarSeries(System::Classes::TComponent* AOwner) : TCustomPolarSeries(AOwner) { }
	/* TCustomPolarSeries.Destroy */ inline __fastcall virtual ~TRadarSeries() { }
	
private:
	void *__ITeeScreenToPoint;	// Fmxtee::Engine::ITeeScreenToPoint 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FE1CD916-A647-4B27-8580-3842E4019919}
	operator Fmxtee::Engine::_di_ITeeScreenToPoint()
	{
		Fmxtee::Engine::_di_ITeeScreenToPoint intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Fmxtee::Engine::ITeeScreenToPoint*(void) { return (Fmxtee::Engine::ITeeScreenToPoint*)&__ITeeScreenToPoint; }
	#endif
	
};


class PASCALIMPLEMENTATION TPolarBarSeries : public TPolarSeries
{
	typedef TPolarSeries inherited;
	
protected:
	virtual void __fastcall InternalDrawValue(int ValueIndex, int X, int Y);
public:
	/* TPolarSeries.Create */ inline __fastcall virtual TPolarBarSeries(System::Classes::TComponent* AOwner) : TPolarSeries(AOwner) { }
	
public:
	/* TCustomPolarSeries.Destroy */ inline __fastcall virtual ~TPolarBarSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Polar */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_POLAR)
using namespace Fmxtee::Series::Polar;
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
#endif	// Fmxtee_Series_PolarHPP
