// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Point3D.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Series_Point3dHPP
#define Fmxtee_Series_Point3dHPP

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
#include <System.UIConsts.hpp>
#include <System.Types.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Point3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPoint3DSeries;
class DELPHICLASS TBubble3DSeries;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TSeriesClickPointer3DEvent)(TPoint3DSeries* Sender, int ValueIndex, int X, int Y);

class PASCALIMPLEMENTATION TPoint3DSeries : public Fmxtee::Series::Surface::TCustom3DPaletteSeries
{
	typedef Fmxtee::Series::Surface::TCustom3DPaletteSeries inherited;
	
private:
	Fmxtee::Canvas::TTeeHiddenPen* FBaseLine;
	double FDepthSize;
	Fmxtee::Engine::TSeriesPointer* FPointer;
	Fmxtee::Canvas::TTeeTransparency FLineTransparency;
	TSeriesClickPointer3DEvent FOnClickPointer;
	Fmxtee::Series::TOnGetPointerStyle FOnGetPointerStyle;
	int IOldX;
	int IOldY;
	int IOldZ;
	Fmxtee::Canvas::TTeePen* __fastcall GetLinePen();
	void __fastcall SetLineTransparency(Fmxtee::Canvas::TTeeTransparency Value);
	void __fastcall SetBaseLine(Fmxtee::Canvas::TTeeHiddenPen* const Value);
	void __fastcall SetDepthSize(const double Value);
	void __fastcall SetPointer(Fmxtee::Engine::TSeriesPointer* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual void __fastcall CalcZPositions(int ValueIndex);
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual int __fastcall GetDepthSize(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall MouseDown(int ValueIndex, bool AtPointer, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual bool __fastcall RaiseClicked();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	__classmethod virtual bool __fastcall SubGalleryStyles();
	
public:
	__fastcall virtual TPoint3DSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPoint3DSeries();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual double __fastcall MaxZValue();
	
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
	__property Fmxtee::Canvas::TTeeHiddenPen* BaseLine = {read=FBaseLine, write=SetBaseLine};
	__property double DepthSize = {read=FDepthSize, write=SetDepthSize};
	__property Fmxtee::Canvas::TTeePen* LinePen = {read=GetLinePen, write=SetPen};
	__property Fmxtee::Canvas::TTeeTransparency LineTransparency = {read=FLineTransparency, write=SetLineTransparency, default=0};
	__property Fmxtee::Engine::TSeriesPointer* Pointer = {read=FPointer, write=SetPointer};
	__property TimesZOrder = {default=3};
	__property XValues;
	__property YValues;
	__property ZValues;
	__property TSeriesClickPointer3DEvent OnClickPointer = {read=FOnClickPointer, write=FOnClickPointer};
	__property Fmxtee::Series::TOnGetPointerStyle OnGetPointerStyle = {read=FOnGetPointerStyle, write=FOnGetPointerStyle};
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TBubble3DSeries : public TPoint3DSeries
{
	typedef TPoint3DSeries inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FRadiusValues;
	double __fastcall ApplyRadius(const double Value, Fmxtee::Engine::TChartValueList* AList, bool Increment);
	void __fastcall SetRadiusValues(Fmxtee::Engine::TChartValueList* Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall CalcZPositions(int ValueIndex);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual int __fastcall GetDepthSize(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	__classmethod virtual bool __fastcall SubGalleryStyles();
	
public:
	__fastcall virtual TBubble3DSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddBubble(const double AX, const double AY, const double AZ, const double ARadius, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall MaxZValue();
	virtual double __fastcall MinZValue();
	
__published:
	__property ColorEachPoint = {default=1};
	__property Fmxtee::Engine::TChartValueList* RadiusValues = {read=FRadiusValues, write=SetRadiusValues};
public:
	/* TPoint3DSeries.Destroy */ inline __fastcall virtual ~TBubble3DSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Point3d */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_POINT3D)
using namespace Fmxtee::Series::Point3d;
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
#endif	// Fmxtee_Series_Point3dHPP
