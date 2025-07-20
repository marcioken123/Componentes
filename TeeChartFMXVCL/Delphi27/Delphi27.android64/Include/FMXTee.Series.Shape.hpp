// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Shape.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Series_ShapeHPP
#define Fmxtee_Series_ShapeHPP

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
namespace Shape
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartShape;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TChartShapeXYStyle : unsigned char { xysPixels, xysAxis, xysAxisOrigin };

enum DECLSPEC_DENUM TChartShapeStyle : unsigned char { chasRectangle, chasCircle, chasVertLine, chasHorizLine, chasTriangle, chasInvertTriangle, chasLine, chasDiamond, chasCube, chasCross, chasDiagCross, chasStar, chasPyramid, chasInvertPyramid };

enum DECLSPEC_DENUM TTeeVertAlign : unsigned char { vaTop, vaCenter, vaBottom };

class PASCALIMPLEMENTATION TChartShape : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
private:
	System::Classes::TAlignment FAlignment;
	Fmxtee::Canvas::TTeeFont* FFont;
	bool FRoundRectangle;
	TChartShapeStyle FStyle;
	System::Classes::TStrings* FText;
	bool FTransparent;
	TTeeVertAlign FVertAlign;
	TChartShapeXYStyle FXYStyle;
	void __fastcall AddDefaultPoints();
	void __fastcall ChangeToManual();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	double __fastcall GetX0();
	double __fastcall GetX1();
	double __fastcall GetY0();
	double __fastcall GetY1();
	void __fastcall SetAlignment(System::Classes::TAlignment Value);
	void __fastcall SetFont(Fmxtee::Canvas::TTeeFont* Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetRoundRectangle(bool Value);
	void __fastcall SetShapeRectangle(const System::Types::TRectF &ARect);
	void __fastcall SetStyle(TChartShapeStyle Value);
	void __fastcall SetTransparent(bool Value);
	void __fastcall SetVertAlign(TTeeVertAlign Value);
	void __fastcall SetX0(const double Value);
	void __fastcall SetX1(const double Value);
	void __fastcall SetXYStyle(TChartShapeXYStyle Value);
	void __fastcall SetY0(const double Value);
	void __fastcall SetY1(const double Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcZOrder();
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	void __fastcall DrawShape(int ValueIndex, bool Is3D, const System::Types::TRectF &R);
	void __fastcall DrawText(const System::Types::TRectF &R);
	virtual void __fastcall DrawValue(int ValueIndex);
	System::Types::TRectF __fastcall GetAdjustedRectangle();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::Types::TRectF __fastcall GetShapeRectangle();
	virtual bool __fastcall MoreSameZOrder();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetSeriesColor(System::Uitypes::TAlphaColor AColor);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	virtual void __fastcall SetText(System::Classes::TStrings* Value);
	
public:
	__fastcall virtual TChartShape(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TChartShape();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	virtual bool __fastcall UseAxis();
	__property System::Types::TRectF Bounds = {read=GetShapeRectangle, write=SetShapeRectangle};
	
__published:
	__property Active = {default=1};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property VertAxis = {default=0};
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property OnClick;
	__property OnDblClick;
	__property OnGetMarkText;
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property Brush;
	__property Fmxtee::Canvas::TTeeFont* Font = {read=FFont, write=SetFont};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property System::Classes::TStrings* Text = {read=FText, write=SetText};
	__property Pen;
	__property bool RoundRectangle = {read=FRoundRectangle, write=SetRoundRectangle, default=0};
	__property TChartShapeStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property Transparency = {default=0};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property TTeeVertAlign VertAlign = {read=FVertAlign, write=SetVertAlign, default=1};
	__property TChartShapeXYStyle XYStyle = {read=FXYStyle, write=SetXYStyle, default=1};
	__property double X0 = {read=GetX0, write=SetX0};
	__property double X1 = {read=GetX1, write=SetX1};
	__property double Y0 = {read=GetY0, write=SetY0};
	__property double Y1 = {read=GetY1, write=SetY1};
	__property XValues;
	__property YValues;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Shape */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_SHAPE)
using namespace Fmxtee::Series::Shape;
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
#endif	// Fmxtee_Series_ShapeHPP
