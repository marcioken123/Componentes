// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTernary.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeternaryHPP
#define Vcltee_TeeternaryHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeePoin3.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeeProCo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeternary
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

class PASCALIMPLEMENTATION TTernarySeries : public Vcltee::Teesurfa::TCustom3DPaletteSeries
{
	typedef Vcltee::Teesurfa::TCustom3DPaletteSeries inherited;
	
private:
	TTernaryAxisScale FAxisScale;
	Vcltee::Teengine::TChartValueList* FRadiusValues;
	Vcltee::Teengine::TChartValueList* FWeightValues;
	Vcltee::Tecanvas::TTrianglePoints IPolyList;
	TTernaryFormat FPlotFormat;
	Vcltee::Tecanvas::TTeePen* FLinesPen;
	Vcltee::Tecanvas::TPointArray FLeftPoints;
	Vcltee::Tecanvas::TPointArray FRightPoints;
	Vcltee::Tecanvas::TPointArray FBottomPoints;
	Vcltee::Tecanvas::TPointArray FPlotPoints;
	System::Types::TPoint FVertexA;
	System::Types::TPoint FVertexB;
	System::Types::TPoint FVertexC;
	bool FDeriveZ;
	Vcltee::Teengine::TSeriesPointer* FPointer;
	bool FRotateLabels;
	double FPercentCoeff;
	TTernaryStyle FTernaryStyle;
	TTernaryLegendStyle FLegendStyle;
	TTernaryMarkStyle FMarkStyle;
	Vcltee::Chart::TTextShape* FVertexTitle;
	TTernaryVertexTitles FVertexTitles;
	TSeriesClickPointer3DEvent FOnClickPointer;
	Vcltee::Series::TOnGetPointerStyle FOnGetPointerStyle;
	Vcltee::Tecanvas::TTrianglePoints boundingPoly;
	void __fastcall ClearTitles();
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetAxisScale(const TTernaryAxisScale Value);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetLinesPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetRotateLabels(const bool Value);
	void __fastcall SetRadiusValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetWeightValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetTernaryStyle(const TTernaryStyle Value);
	void __fastcall SetTernaryLegendStyle(const TTernaryLegendStyle Value);
	void __fastcall SetPointer(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetTernaryMarkStyle(const TTernaryMarkStyle Value);
	void __fastcall SetVertexTitle(Vcltee::Chart::TTextShape* const Value);
	void __fastcall SetVertexTitles(const TTernaryVertexTitles Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DoBeforeDrawValues();
	Vcltee::Teengine::TSeriesPointerStyle __fastcall DoGetPointerStyle(int ValueIndex);
	virtual void __fastcall DrawAllValues();
	void __fastcall DrawAxes();
	void __fastcall DrawAxis(Vcltee::Teengine::TChartAxis* const aAxis, const System::Types::TPoint &StartPoint, const System::Types::TPoint &EndPoint);
	void __fastcall DrawGrids(const Vcltee::Tecanvas::TTrianglePoints &Element);
	void __fastcall DrawLabels(const Vcltee::Tecanvas::TTrianglePoints &Element);
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	void __fastcall DrawTicks(const Vcltee::Tecanvas::TTrianglePoints &Element);
	void __fastcall DrawVertexTitles();
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	HIDESBASE void __fastcall GetMarkText(Vcltee::Teengine::TChartSeries* Sender, int ValueIndex, System::UnicodeString &MarkText);
	System::Types::TPoint __fastcall GetSideOffset(const int Hypoteneuse);
	System::Types::TPoint __fastcall GetVectorLocation(const System::Types::TPoint &StartPoint, const System::Types::TPoint &EndPoint, const int PercentOffset);
	void __fastcall HomogeniseValues(double &x, double &y, double &z);
	virtual void __fastcall MouseDown(int ValueIndex, bool AtPointer, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall PrepareForGallery();
	void __fastcall PreparePointer(int ValueIndex);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual bool __fastcall RaiseClicked();
	
public:
	__fastcall virtual TTernarySeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTernarySeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TPoint __fastcall CalcPointFromValues(const double a, const double b, const double c)/* overload */;
	System::Types::TPoint __fastcall CalcPointFromValues(const int ValueIndex)/* overload */;
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	virtual int __fastcall CountLegendItems();
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	DYNAMIC int __fastcall NumSampleValues();
	virtual bool __fastcall UseAxis();
	__property TTernaryVertexTitles VertexTitles = {read=FVertexTitles, write=SetVertexTitles};
	int __fastcall AddXYPoint(const double AX, const double AY, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	int __fastcall AddBubbleXY(const double AX, const double AY, const double ARadius, System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	int __fastcall AddBubbleXY(const double AX, const double AY, const double ARadius, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	int __fastcall AddBubbleXYWeight(const double AX, const double AY, const double ARadius, const double AWeight, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	int __fastcall AddBubbleXYZ(const double AX, const double AY, const double AZ, const double ARadius, System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	int __fastcall AddBubbleXYZ(const double AX, const double AY, const double AZ, const double ARadius, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	int __fastcall AddBubbleXYZWeight(const double AX, const double AY, const double AZ, const double ARadius, const double AWeight, System::Uitypes::TColor AColor)/* overload */;
	int __fastcall AddBubbleXYZWeight(const double AX, const double AY, const double AZ, const double ARadius, const double AWeight, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	__property System::Types::TPoint VertexA = {read=FVertexA};
	__property System::Types::TPoint VertexB = {read=FVertexB};
	__property System::Types::TPoint VertexC = {read=FVertexC};
	
__published:
	__property Active = {default=1};
	__property TTernaryAxisScale AxisScale = {read=FAxisScale, write=SetAxisScale, nodefault};
	__property Brush;
	__property Color;
	__property ColorEachPoint = {default=1};
	__property ColorSource = {default=0};
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Vcltee::Tecanvas::TTeePen* LinesPen = {read=FLinesPen, write=SetLinesPen};
	__property Vcltee::Teengine::TChartValueList* RadiusValues = {read=FRadiusValues, write=SetRadiusValues};
	__property bool RotateLabels = {read=FRotateLabels, write=SetRotateLabels, default=1};
	__property bool DeriveZ = {read=FDeriveZ, write=FDeriveZ, default=1};
	__property TTernaryLegendStyle TernaryLegendStyle = {read=FLegendStyle, write=SetTernaryLegendStyle, default=0};
	__property TTernaryMarkStyle TernaryMarkStyle = {read=FMarkStyle, write=SetTernaryMarkStyle, default=0};
	__property TTernaryStyle TernaryStyle = {read=FTernaryStyle, write=SetTernaryStyle, nodefault};
	__property Vcltee::Chart::TTextShape* VertexTitle = {read=FVertexTitle, write=SetVertexTitle};
	__property Vcltee::Teengine::TChartValueList* WeightValues = {read=FWeightValues, write=SetWeightValues};
	__property EndColor = {default=16777215};
	__property MidColor = {default=536870911};
	__property LegendEvery = {default=1};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property StartColor = {default=8388608};
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
	__property Vcltee::Teengine::TSeriesPointer* Pointer = {read=FPointer, write=SetPointer};
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
	__property Vcltee::Series::TOnGetPointerStyle OnGetPointerStyle = {read=FOnGetPointerStyle, write=FOnGetPointerStyle};
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeternary */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETERNARY)
using namespace Vcltee::Teeternary;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeternaryHPP
