// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Ternary.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_TernaryHPP
#define Fmxtee_Series_TernaryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <System.UIConsts.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Constants.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Series.Point3D.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMXTee.ProConstants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Ternary
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTernarySeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TTernaryStyle : unsigned char { tsPoint, tsBubble };

enum DECLSPEC_DENUM TTernaryAxisScale : unsigned char { tlasUnit, tlasPercent };

enum DECLSPEC_DENUM TTernaryFormat : unsigned char { tlfTernary, tlfPiper };

enum DECLSPEC_DENUM TTernaryLegendStyle : unsigned char { tlsValues, tlsValuesBubble, tlsValuesBubbleWeight, tlsBubble, tlsBubbleWeight, tlsWeight };

typedef System::DynamicArray<System::Classes::TStringList*> TTernaryVertexTitles;

enum DECLSPEC_DENUM TTernaryMarkStyle : unsigned char { tmsShort, tmsLong, tmsLongLabelled };

typedef void __fastcall (__closure *TSeriesClickPointer3DEvent)(TTernarySeries* Sender, int ValueIndex, int X, int Y);

class PASCALIMPLEMENTATION TTernarySeries : public Fmxtee::Series::Surface::TCustom3DPaletteSeries
{
	typedef Fmxtee::Series::Surface::TCustom3DPaletteSeries inherited;
	
private:
	TTernaryAxisScale FAxisScale;
	Fmxtee::Engine::TChartValueList* FRadiusValues;
	Fmxtee::Engine::TChartValueList* FWeightValues;
	Fmxtee::Canvas::TTrianglePoints IPolyList;
	TTernaryFormat FPlotFormat;
	Fmxtee::Canvas::TTeePen* FLinesPen;
	Fmxtee::Canvas::TPointArray FLeftPoints;
	Fmxtee::Canvas::TPointArray FRightPoints;
	Fmxtee::Canvas::TPointArray FBottomPoints;
	Fmxtee::Canvas::TPointArray FPlotPoints;
	System::Types::TPointF FVertexA;
	System::Types::TPointF FVertexB;
	System::Types::TPointF FVertexC;
	bool FDeriveZ;
	Fmxtee::Engine::TSeriesPointer* FPointer;
	bool FRotateLabels;
	double FPercentCoeff;
	TTernaryStyle FTernaryStyle;
	TTernaryLegendStyle FLegendStyle;
	TTernaryMarkStyle FMarkStyle;
	Fmxtee::Chart::TTextShape* FVertexTitle;
	TTernaryVertexTitles FVertexTitles;
	TSeriesClickPointer3DEvent FOnClickPointer;
	Fmxtee::Series::TOnGetPointerStyle FOnGetPointerStyle;
	Fmxtee::Canvas::TTrianglePoints boundingPoly;
	void __fastcall ClearTitles();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetAxisScale(const TTernaryAxisScale Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetLinesPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetRotateLabels(const bool Value);
	void __fastcall SetRadiusValues(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetWeightValues(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetTernaryStyle(const TTernaryStyle Value);
	void __fastcall SetTernaryLegendStyle(const TTernaryLegendStyle Value);
	void __fastcall SetPointer(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetTernaryMarkStyle(const TTernaryMarkStyle Value);
	void __fastcall SetVertexTitle(Fmxtee::Chart::TTextShape* const Value);
	void __fastcall SetVertexTitles(const TTernaryVertexTitles Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DoBeforeDrawValues();
	Fmxtee::Engine::TSeriesPointerStyle __fastcall DoGetPointerStyle(int ValueIndex);
	virtual void __fastcall DrawAllValues();
	void __fastcall DrawAxes();
	void __fastcall DrawAxis(Fmxtee::Engine::TChartAxis* const aAxis, const System::Types::TPointF &StartPoint, const System::Types::TPointF &EndPoint);
	void __fastcall DrawGrids(const Fmxtee::Canvas::TTrianglePoints &Element);
	void __fastcall DrawLabels(const Fmxtee::Canvas::TTrianglePoints &Element);
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	void __fastcall DrawTicks(const Fmxtee::Canvas::TTrianglePoints &Element);
	void __fastcall DrawVertexTitles();
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	HIDESBASE void __fastcall GetMarkText(Fmxtee::Engine::TChartSeries* Sender, int ValueIndex, System::UnicodeString &MarkText);
	System::Types::TPointF __fastcall GetSideOffset(const float Hypoteneuse);
	System::Types::TPointF __fastcall GetVectorLocation(const System::Types::TPointF &StartPoint, const System::Types::TPointF &EndPoint, const float PercentOffset);
	void __fastcall HomogeniseValues(double &x, double &y, double &z);
	virtual void __fastcall MouseDown(int ValueIndex, bool AtPointer, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall PrepareForGallery();
	void __fastcall PreparePointer(int ValueIndex);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual bool __fastcall RaiseClicked();
	
public:
	__fastcall virtual TTernarySeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTernarySeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TPointF __fastcall CalcPointFromValues(const double a, const double b, const double c)/* overload */;
	System::Types::TPointF __fastcall CalcPointFromValues(const int ValueIndex)/* overload */;
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	virtual int __fastcall CountLegendItems();
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Fmxtee::Engine::TLegendTextStyle LegendTextStyle);
	DYNAMIC int __fastcall NumSampleValues();
	virtual bool __fastcall UseAxis();
	__property TTernaryVertexTitles VertexTitles = {read=FVertexTitles, write=SetVertexTitles};
	int __fastcall AddXYPoint(const double AX, const double AY, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	int __fastcall AddBubbleXY(const double AX, const double AY, const double ARadius, System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff))/* overload */;
	int __fastcall AddBubbleXY(const double AX, const double AY, const double ARadius, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff))/* overload */;
	int __fastcall AddBubbleXYWeight(const double AX, const double AY, const double ARadius, const double AWeight, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	int __fastcall AddBubbleXYZ(const double AX, const double AY, const double AZ, const double ARadius, System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff))/* overload */;
	int __fastcall AddBubbleXYZ(const double AX, const double AY, const double AZ, const double ARadius, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff))/* overload */;
	int __fastcall AddBubbleXYZWeight(const double AX, const double AY, const double AZ, const double ARadius, const double AWeight, System::Uitypes::TAlphaColor AColor)/* overload */;
	int __fastcall AddBubbleXYZWeight(const double AX, const double AY, const double AZ, const double ARadius, const double AWeight, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff))/* overload */;
	__property System::Types::TPointF VertexA = {read=FVertexA};
	__property System::Types::TPointF VertexB = {read=FVertexB};
	__property System::Types::TPointF VertexC = {read=FVertexC};
	
__published:
	__property Active = {default=1};
	__property TTernaryAxisScale AxisScale = {read=FAxisScale, write=SetAxisScale, nodefault};
	__property Brush;
	__property Color;
	__property ColorEachPoint = {default=1};
	__property ColorSource = {default=0};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Fmxtee::Canvas::TTeePen* LinesPen = {read=FLinesPen, write=SetLinesPen};
	__property Fmxtee::Engine::TChartValueList* RadiusValues = {read=FRadiusValues, write=SetRadiusValues};
	__property bool RotateLabels = {read=FRotateLabels, write=SetRotateLabels, default=1};
	__property bool DeriveZ = {read=FDeriveZ, write=FDeriveZ, default=1};
	__property TTernaryLegendStyle TernaryLegendStyle = {read=FLegendStyle, write=SetTernaryLegendStyle, default=0};
	__property TTernaryMarkStyle TernaryMarkStyle = {read=FMarkStyle, write=SetTernaryMarkStyle, default=0};
	__property TTernaryStyle TernaryStyle = {read=FTernaryStyle, write=SetTernaryStyle, nodefault};
	__property Fmxtee::Chart::TTextShape* VertexTitle = {read=FVertexTitle, write=SetVertexTitle};
	__property Fmxtee::Engine::TChartValueList* WeightValues = {read=FWeightValues, write=SetWeightValues};
	__property EndColor = {default=-1};
	__property MidColor = {default=0};
	__property LegendEvery = {default=1};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property StartColor = {default=-16777088};
	__property UseColorRange = {default=1};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property XLabelsSource = {default=0};
	__property Fmxtee::Engine::TSeriesPointer* Pointer = {read=FPointer, write=SetPointer};
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
	__property OnGetColor;
	__property TSeriesClickPointer3DEvent OnClickPointer = {read=FOnClickPointer, write=FOnClickPointer};
	__property Fmxtee::Series::TOnGetPointerStyle OnGetPointerStyle = {read=FOnGetPointerStyle, write=FOnGetPointerStyle};
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Ternary */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_TERNARY)
using namespace Fmxtee::Series::Ternary;
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
#endif	// Fmxtee_Series_TernaryHPP
