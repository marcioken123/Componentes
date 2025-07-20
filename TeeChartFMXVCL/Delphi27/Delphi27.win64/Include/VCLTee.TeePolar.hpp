// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePolar.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepolarHPP
#define Vcltee_TeepolarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepolar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomCircledSeries;
class DELPHICLASS TPolarLabels;
class DELPHICLASS TCustomPolarSeries;
class DELPHICLASS TPolarSeries;
class DELPHICLASS TRadarSeries;
class DELPHICLASS TPolarBarSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomCircledSeries : public Vcltee::Series::TCircledSeries
{
	typedef Vcltee::Series::TCircledSeries inherited;
	
private:
	Vcltee::Tecanvas::TTeePen* FCirclePen;
	bool FColorEachLine;
	Vcltee::Series::TCustomSeriesDrawStyle FDrawStyle;
	Vcltee::Series::TOnGetPointerStyle FOnGetPointerStyle;
	Vcltee::Teengine::TSeriesPointer* FPointer;
	bool FPointerBehind;
	void __fastcall DoDrawAll();
	void __fastcall SetCirclePen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetColorEachLine(bool Value);
	void __fastcall SetDrawStyle(const Vcltee::Series::TCustomSeriesDrawStyle Value);
	void __fastcall SetPointer(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetPointerBehind(const bool Value);
	
protected:
	int AxisXRadius;
	int AxisYRadius;
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall CalcRadius();
	System::Uitypes::TColor __fastcall CalcValueColor(int ValueIndex);
	Vcltee::Teengine::TSeriesPointerStyle __fastcall DoGetPointerStyle(int ValueIndex);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual bool __fastcall ShouldCloseCircle();
	
public:
	__fastcall virtual TCustomCircledSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomCircledSeries();
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	__property Vcltee::Tecanvas::TTeePen* CirclePen = {read=FCirclePen, write=SetCirclePen};
	__property bool ColorEachLine = {read=FColorEachLine, write=SetColorEachLine, default=1};
	__property Vcltee::Teengine::TSeriesPointer* Pointer = {read=FPointer, write=SetPointer};
	__property bool PointerBehind = {read=FPointerBehind, write=SetPointerBehind, default=0};
	__property Vcltee::Series::TCustomSeriesDrawStyle DrawStyle = {read=FDrawStyle, write=SetDrawStyle, default=0};
	__property Vcltee::Series::TOnGetPointerStyle OnGetPointerStyle = {read=FOnGetPointerStyle, write=FOnGetPointerStyle};
};


class PASCALIMPLEMENTATION TPolarLabels : public Vcltee::Teeprocs::TTeeShape
{
	typedef Vcltee::Teeprocs::TTeeShape inherited;
	
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
	void __fastcall FillTriangle(const System::Types::TPoint &A, const System::Types::TPoint &B, int Z);
	double __fastcall GetAngleIncrement();
	double __fastcall GetRadiusIncrement();
	Vcltee::Teengine::TChartValueList* __fastcall GetRadiusValues();
	bool __fastcall IsRadiusStored();
	void __fastcall SetAngleIncrement(const double Value);
	void __fastcall SetAngleLabels(TPolarLabels* const Value);
	void __fastcall SetCloseCircle(bool Value);
	void __fastcall SetRadiusIncrement(const double Value);
	void __fastcall SetRadiusValues(Vcltee::Teengine::TChartValueList* const Value);
	bool __fastcall GetCircleLabels();
	void __fastcall SetCircleLabels(bool Value);
	Vcltee::Tecanvas::TTeeFont* __fastcall GetCircleLabelsFont();
	void __fastcall SetCircleLabelsFont(Vcltee::Tecanvas::TTeeFont* const Value);
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
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	void __fastcall CalcXYPosition(const double XValue, const double YValue, int ARadius, /* out */ int &X, /* out */ int &Y)/* overload */;
	void __fastcall CalcXYPosition(const double XValue, const double YValue, int ARadius, Vcltee::Teengine::TChartAxis* Axis, /* out */ int &X, /* out */ int &Y)/* overload */;
	void __fastcall CalcXYRadius(const double Value, /* out */ int &X, /* out */ int &Y);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoAfterDrawValues();
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawPolarCircle(int HalfWidth, int HalfHeight, int Z);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual double __fastcall GetAngleValue(int ValueIndex);
	virtual Vcltee::Teengine::TChartValueList* __fastcall GetAngleValues();
	virtual System::UnicodeString __fastcall GetCircleLabel(const double Angle, int Index);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall InternalDrawValue(int ValueIndex, int X, int Y);
	void __fastcall LinePrepareCanvas(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	void __fastcall ScreenToPoint(int X, int Y, int ValueIndex, bool ChangeX, bool ChangeY);
	virtual void __fastcall SetAngleValues(Vcltee::Teengine::TChartValueList* Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TColor AColor);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
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
	__property Vcltee::Teengine::TChartValueList* AngleValues = {read=GetAngleValues, write=SetAngleValues};
	__property Brush;
	__property bool CircleLabels = {read=GetCircleLabels, write=SetCircleLabels, stored=false, nodefault};
	__property Vcltee::Tecanvas::TTeeFont* CircleLabelsFont = {read=GetCircleLabelsFont, write=SetCircleLabelsFont, stored=false};
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
	__property Vcltee::Teengine::TChartValueList* RadiusValues = {read=GetRadiusValues, write=SetRadiusValues, stored=IsRadiusStored};
	__property Transparency = {default=0};
	__property TreatNulls = {default=0};
	__property TOnGetPolarLabel OnGetCircleLabel = {read=FOnGetCircleLabel, write=FOnGetCircleLabel};
	__property OnGetPointerStyle;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
private:
	void *__ITeeScreenToPoint;	// Vcltee::Teengine::ITeeScreenToPoint 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FE1CD916-A647-4B27-8580-3842E4019919}
	operator Vcltee::Teengine::_di_ITeeScreenToPoint()
	{
		Vcltee::Teengine::_di_ITeeScreenToPoint intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcltee::Teengine::ITeeScreenToPoint*(void) { return (Vcltee::Teengine::ITeeScreenToPoint*)&__ITeeScreenToPoint; }
	#endif
	
};


class PASCALIMPLEMENTATION TPolarSeries : public TCustomPolarSeries
{
	typedef TCustomPolarSeries inherited;
	
private:
	Vcltee::Teengine::TChartValueList* FAngleValues;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoAfterDrawValues();
	virtual void __fastcall DoBeforeDrawValues();
	virtual double __fastcall GetAngleValue(int ValueIndex);
	virtual Vcltee::Teengine::TChartValueList* __fastcall GetAngleValues();
	virtual void __fastcall SetAngleValue(int Index, const double Value);
	virtual void __fastcall SetAngleValues(Vcltee::Teengine::TChartValueList* Value);
	HIDESBASE void __fastcall ScreenToPoint(int X, int Y, int ValueIndex, bool ChangeX, bool ChangeY);
	
public:
	__fastcall virtual TPolarSeries(System::Classes::TComponent* AOwner);
	virtual int __fastcall AddNull(const System::UnicodeString ALabel = System::UnicodeString())/* overload */;
	virtual int __fastcall AddNullXY(const double X, const double Y, const System::UnicodeString ALabel = System::UnicodeString());
	virtual int __fastcall AddPolar(const double Angle, const double Value, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
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
	__property CircleBackColor = {default=536870912};
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
	inline int __fastcall  AddNull(const double Value){ return Vcltee::Teengine::TChartSeries::AddNull(Value); }
	
private:
	void *__ITeeScreenToPoint;	// Vcltee::Teengine::ITeeScreenToPoint 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FE1CD916-A647-4B27-8580-3842E4019919}
	operator Vcltee::Teengine::_di_ITeeScreenToPoint()
	{
		Vcltee::Teengine::_di_ITeeScreenToPoint intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcltee::Teengine::ITeeScreenToPoint*(void) { return (Vcltee::Teengine::ITeeScreenToPoint*)&__ITeeScreenToPoint; }
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
	__property CircleBackColor = {default=536870912};
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
	void *__ITeeScreenToPoint;	// Vcltee::Teengine::ITeeScreenToPoint 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {FE1CD916-A647-4B27-8580-3842E4019919}
	operator Vcltee::Teengine::_di_ITeeScreenToPoint()
	{
		Vcltee::Teengine::_di_ITeeScreenToPoint intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Vcltee::Teengine::ITeeScreenToPoint*(void) { return (Vcltee::Teengine::ITeeScreenToPoint*)&__ITeeScreenToPoint; }
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
}	/* namespace Teepolar */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOLAR)
using namespace Vcltee::Teepolar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepolarHPP
