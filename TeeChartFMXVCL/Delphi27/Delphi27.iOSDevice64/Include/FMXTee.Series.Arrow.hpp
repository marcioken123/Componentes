// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Arrow.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_ArrowHPP
#define Fmxtee_Series_ArrowHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <System.Classes.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Arrow
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TArrowSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TArrowSeries : public Fmxtee::Series::TPointSeries
{
	typedef Fmxtee::Series::TPointSeries inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FEndXValues;
	Fmxtee::Engine::TChartValueList* FEndYValues;
	bool FFill2D;
	int FPercent;
	int __fastcall GetArrowHeight();
	int __fastcall GetArrowWidth();
	void __fastcall GetArrowPoints(int ValueIndex, /* out */ System::Types::TPointF &P0, /* out */ System::Types::TPointF &P1);
	Fmxtee::Engine::TChartValueList* __fastcall GetStartXValues();
	Fmxtee::Engine::TChartValueList* __fastcall GetStartYValues();
	void __fastcall SetArrowHeight(int Value);
	void __fastcall SetArrowWidth(int Value);
	void __fastcall SetEndXValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetEndYValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetFill2D(bool Value);
	void __fastcall SetPercent(const int Value);
	void __fastcall SetStartXValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetStartYValues(Fmxtee::Engine::TChartValueList* Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	__classmethod virtual bool __fastcall CanDoExtra();
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TArrowSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddArrow(const double X0, const double Y0, const double X1, const double Y1, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	
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
	__property int ArrowHeight = {read=GetArrowHeight, write=SetArrowHeight, stored=false, nodefault};
	__property int ArrowPercent = {read=FPercent, write=SetPercent, default=50};
	__property int ArrowWidth = {read=GetArrowWidth, write=SetArrowWidth, stored=false, nodefault};
	__property Fmxtee::Engine::TChartValueList* EndXValues = {read=FEndXValues, write=SetEndXValues};
	__property Fmxtee::Engine::TChartValueList* EndYValues = {read=FEndYValues, write=SetEndYValues};
	__property bool Fill2D = {read=FFill2D, write=SetFill2D, default=0};
	__property Fmxtee::Engine::TChartValueList* StartXValues = {read=GetStartXValues, write=SetStartXValues};
	__property Fmxtee::Engine::TChartValueList* StartYValues = {read=GetStartYValues, write=SetStartYValues};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TArrowSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Arrow */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_ARROW)
using namespace Fmxtee::Series::Arrow;
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
#endif	// Fmxtee_Series_ArrowHPP
