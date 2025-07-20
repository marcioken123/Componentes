// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Pyramid.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_PyramidHPP
#define Fmxtee_Series_PyramidHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Pyramid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPyramidSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPyramidSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
private:
	int FSize;
	double __fastcall AcumUpTo(int UpToIndex);
	void __fastcall SetSize(const int Value);
	
protected:
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	System::Types::TRectF __fastcall CalcSector(int ValueIndex, /* out */ float &tmpZ, /* out */ float &tmpX, /* out */ float &tmpZ2);
	virtual void __fastcall CalcZOrder();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	virtual bool __fastcall DrawSeriesAscending();
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual bool __fastcall InvertedLegend();
	virtual bool __fastcall MoreSameZOrder();
	
public:
	__fastcall virtual TPyramidSeries(System::Classes::TComponent* AOwner);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual bool __fastcall DrawValuesForward();
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	
__published:
	__property Active = {default=1};
	__property Brush;
	__property ColorEachPoint = {default=1};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property Pen;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property int SizePercent = {read=FSize, write=SetSize, default=50};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property XValues;
	__property YValues;
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
public:
	/* TChartSeries.Destroy */ inline __fastcall virtual ~TPyramidSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Pyramid */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_PYRAMID)
using namespace Fmxtee::Series::Pyramid;
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
#endif	// Fmxtee_Series_PyramidHPP
