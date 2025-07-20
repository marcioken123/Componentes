// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Error.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_ErrorHPP
#define Fmxtee_Series_ErrorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Error
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomErrorSeries;
class DELPHICLASS TErrorSeries;
class DELPHICLASS TErrorBarSeries;
class DELPHICLASS TBaseHighLowSeries;
class DELPHICLASS THighLowPolygon;
class DELPHICLASS TTeeHighLowPolygon;
class DELPHICLASS THighLowSeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TErrorSeriesStyle : unsigned char { essLeft, essRight, essLeftRight, essTop, essBottom, essTopBottom };

enum DECLSPEC_DENUM TErrorWidthUnits : unsigned char { ewuPercent, ewuPixels };

class PASCALIMPLEMENTATION TCustomErrorSeries : public Fmxtee::Series::TBarSeries
{
	typedef Fmxtee::Series::TBarSeries inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FErrorPen;
	TErrorSeriesStyle FErrorStyle;
	Fmxtee::Engine::TChartValueList* FErrorValues;
	int FErrorWidth;
	TErrorWidthUnits FErrorWidthUnits;
	bool IDrawBar;
	double __fastcall GetErrorValue(int Index);
	void __fastcall PrepareErrorPen(int ValueIndex);
	void __fastcall SetErrorStyle(TErrorSeriesStyle Value);
	void __fastcall SetErrorValue(int Index, const double Value);
	void __fastcall SetErrorValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetErrorWidthUnits(TErrorWidthUnits Value);
	void __fastcall SetErrorWidth(int Value);
	void __fastcall SetErrorPen(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	void __fastcall DrawError(const float X, const float Y, const float AWidth, const float AHeight, const float AHeight2, bool Draw3D);
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall PrepareLegendCanvas(int ValueIndex, System::Uitypes::TAlphaColor &BackColor, Fmx::Graphics::TBrushKind &BrushStyle);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TAlphaColor AColor);
	__classmethod virtual bool __fastcall SubGalleryStack();
	
public:
	__fastcall virtual TCustomErrorSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomErrorSeries();
	int __fastcall AddErrorBar(const double AX, const double AY, const double AError, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual void __fastcall DrawBar(int BarIndex, int StartPos, int EndPos);
	virtual double __fastcall MinYValue();
	virtual double __fastcall MaxYValue();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	__property double ErrorValue[int Index] = {read=GetErrorValue, write=SetErrorValue};
	__property Fmxtee::Canvas::TTeePen* ErrorPen = {read=FErrorPen, write=SetErrorPen};
	__property TErrorSeriesStyle ErrorStyle = {read=FErrorStyle, write=SetErrorStyle, default=5};
	__property Fmxtee::Engine::TChartValueList* ErrorValues = {read=FErrorValues, write=SetErrorValues};
	__property int ErrorWidth = {read=FErrorWidth, write=SetErrorWidth, default=100};
	__property TErrorWidthUnits ErrorWidthUnits = {read=FErrorWidthUnits, write=SetErrorWidthUnits, default=0};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TErrorSeries : public TCustomErrorSeries
{
	typedef TCustomErrorSeries inherited;
	
__published:
	__property ErrorPen;
	__property ErrorStyle = {default=5};
	__property ErrorValues;
	__property ErrorWidth = {default=100};
	__property ErrorWidthUnits = {default=0};
public:
	/* TCustomErrorSeries.Create */ inline __fastcall virtual TErrorSeries(System::Classes::TComponent* AOwner) : TCustomErrorSeries(AOwner) { }
	/* TCustomErrorSeries.Destroy */ inline __fastcall virtual ~TErrorSeries() { }
	
};


class PASCALIMPLEMENTATION TErrorBarSeries : public TCustomErrorSeries
{
	typedef TCustomErrorSeries inherited;
	
protected:
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TErrorBarSeries(System::Classes::TComponent* AOwner);
	
__published:
	__property ErrorPen;
	__property ErrorValues;
	__property ErrorWidth = {default=100};
	__property ErrorWidthUnits = {default=0};
public:
	/* TCustomErrorSeries.Destroy */ inline __fastcall virtual ~TErrorBarSeries() { }
	
};


class PASCALIMPLEMENTATION TBaseHighLowSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FLow;
	Fmxtee::Engine::TChartValueList* __fastcall GetHigh();
	void __fastcall SetHigh(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetLow(Fmxtee::Engine::TChartValueList* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	
public:
	__fastcall virtual TBaseHighLowSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddHighLow(const double AX, const double AHigh, const double ALow, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	
__published:
	__property Fmxtee::Engine::TChartValueList* HighValues = {read=GetHigh, write=SetHigh};
	__property Fmxtee::Engine::TChartValueList* LowValues = {read=FLow, write=SetLow};
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
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
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property XValues;
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
	/* TChartSeries.Destroy */ inline __fastcall virtual ~TBaseHighLowSeries() { }
	
};


typedef System::DynamicArray<System::Types::TPointF> THighLowPoints;

#pragma pack(push,4)
class PASCALIMPLEMENTATION THighLowPolygon : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	THighLowPoints IPoints;
	int FIndex;
	bool FIsUpValue;
	
public:
	__property THighLowPoints Polygon = {read=IPoints, write=IPoints};
	__property int RegionIndex = {read=FIndex, write=FIndex, nodefault};
	__property bool IsUpValue = {read=FIsUpValue, write=FIsUpValue, nodefault};
public:
	/* TObject.Create */ inline __fastcall THighLowPolygon() : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~THighLowPolygon() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TTeeHighLowPolygon : public System::Generics::Collections::TList__1<THighLowPolygon*>
{
	typedef System::Generics::Collections::TList__1<THighLowPolygon*> inherited;
	
public:
	HIDESBASE void __fastcall Clear();
public:
	/* {System_Generics_Collections}TList<FMXTee_Series_Error_THighLowPolygon>.Create */ inline __fastcall TTeeHighLowPolygon()/* overload */ : System::Generics::Collections::TList__1<THighLowPolygon*>() { }
	/* {System_Generics_Collections}TList<FMXTee_Series_Error_THighLowPolygon>.Create */ inline __fastcall TTeeHighLowPolygon(const System::DelphiInterface<System::Generics::Defaults::IComparer__1<THighLowPolygon*> > AComparer)/* overload */ : System::Generics::Collections::TList__1<THighLowPolygon*>(AComparer) { }
	/* {System_Generics_Collections}TList<FMXTee_Series_Error_THighLowPolygon>.Create */ inline __fastcall TTeeHighLowPolygon(System::Generics::Collections::TEnumerable__1<THighLowPolygon*>* const Collection)/* overload */ : System::Generics::Collections::TList__1<THighLowPolygon*>(Collection) { }
	/* {System_Generics_Collections}TList<FMXTee_Series_Error_THighLowPolygon>.Destroy */ inline __fastcall virtual ~TTeeHighLowPolygon() { }
	
};


class PASCALIMPLEMENTATION THighLowSeries : public TBaseHighLowSeries
{
	typedef TBaseHighLowSeries inherited;
	
private:
	Fmxtee::Canvas::TTeePen* FHighPen;
	Fmxtee::Canvas::TTeePen* FLowPen;
	Fmxtee::Canvas::TTeeBrush* FLowBrush;
	TTeeHighLowPolygon* FPHighLow;
	int OldX;
	int OldY0;
	int OldY1;
	Fmxtee::Canvas::TTeeBrush* __fastcall GetHighBrush();
	void __fastcall SetHighBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetHighPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetLowBrush(Fmxtee::Canvas::TTeeBrush* const Value);
	void __fastcall SetLowPen(Fmxtee::Canvas::TTeePen* const Value);
	double __fastcall InterpolateLines(int vList, double xVal);
	
protected:
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual void __fastcall DoBeforeDrawValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual THighLowSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~THighLowSeries();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	
__published:
	__property Fmxtee::Canvas::TTeeBrush* HighBrush = {read=GetHighBrush, write=SetHighBrush};
	__property Fmxtee::Canvas::TTeePen* HighPen = {read=FHighPen, write=SetHighPen};
	__property Fmxtee::Canvas::TTeeBrush* LowBrush = {read=FLowBrush, write=SetLowBrush};
	__property Fmxtee::Canvas::TTeePen* LowPen = {read=FLowPen, write=SetLowPen};
	__property TTeeHighLowPolygon* Polygons = {read=FPHighLow, write=FPHighLow};
	__property Transparency = {default=0};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Error */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_ERROR)
using namespace Fmxtee::Series::Error;
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
#endif	// Fmxtee_Series_ErrorHPP
