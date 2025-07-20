// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.TriSurface.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Series_TrisurfaceHPP
#define Fmxtee_Series_TrisurfaceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMXTee.Functions.Triangulate.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Trisurface
{
//-- forward type declarations -----------------------------------------------
struct TTriangle;
class DELPHICLASS ETriSurfaceException;
class DELPHICLASS TCustomTriSurfaceSeries;
class DELPHICLASS TTriSurfaceSeries;
//-- type declarations -------------------------------------------------------
typedef TTriangle *PTriangle;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TTriangle
{
public:
	int Index;
	System::Uitypes::TAlphaColor Color;
	TTriangle *Next;
	TTriangle *Prev;
	Fmxtee::Canvas::TTrianglePoints P;
	double Z;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION ETriSurfaceException : public Fmxtee::Engine::ChartException
{
	typedef Fmxtee::Engine::ChartException inherited;
	
public:
	/* Exception.Create */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg) : Fmxtee::Engine::ChartException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : Fmxtee::Engine::ChartException(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ETriSurfaceException(NativeUInt Ident)/* overload */ : Fmxtee::Engine::ChartException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec)/* overload */ : Fmxtee::Engine::ChartException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ETriSurfaceException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : Fmxtee::Engine::ChartException(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : Fmxtee::Engine::ChartException(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg, int AHelpContext) : Fmxtee::Engine::ChartException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : Fmxtee::Engine::ChartException(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ETriSurfaceException(NativeUInt Ident, int AHelpContext)/* overload */ : Fmxtee::Engine::ChartException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Fmxtee::Engine::ChartException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Fmxtee::Engine::ChartException(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ETriSurfaceException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Fmxtee::Engine::ChartException(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ETriSurfaceException() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCustomTriSurfaceSeries : public Fmxtee::Series::Surface::TCustom3DPaletteSeries
{
	typedef Fmxtee::Series::Surface::TCustom3DPaletteSeries inherited;
	
private:
	Fmxtee::Canvas::TTeeHiddenPen* FBorder;
	bool FFastBrush;
	bool FHide;
	bool IDirtyTriangles;
	TTriangle *Triangles;
	TTriangle *ILastTriangle;
	Fmxtee::Functions::Triangulate::TTriangulator* ITriangulator;
	Fmxtee::Canvas::TTeeCachedObject* ICachedSurface;
	Fmxtee::Canvas::TPoint3D __fastcall CalcPointResult(int Index);
	void __fastcall CalcTriPoints(int Index, /* out */ Fmxtee::Canvas::TTrianglePoints3D &Points, /* out */ Fmxtee::Canvas::TTriangleColors3D &Colors, /* out */ Fmxtee::Canvas::TTriangleIndexes &Indexes);
	void __fastcall ClearTriangles();
	void __fastcall FreeCached();
	double __fastcall GetX(int Index);
	double __fastcall GetZ(int Index);
	void __fastcall SetBorder(Fmxtee::Canvas::TTeeHiddenPen* Value);
	void __fastcall SetFastBrush(const bool Value);
	void __fastcall SetHide(const bool Value);
	void __fastcall SetXYZ(int Dest, int Source);
	
protected:
	bool Reuse3D;
	bool Normals;
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	virtual void __fastcall ChangedAxisScale(Fmxtee::Engine::TChartAxis* const Axis);
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall NotifyValue(Fmxtee::Engine::TValueEvent ValueEvent, int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	bool CacheTriangles;
	__fastcall virtual TCustomTriSurfaceSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomTriSurfaceSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	void __fastcall TrianglePoints(int TriangleIndex, /* out */ Fmxtee::Canvas::TTrianglePoints3D &P);
	__property Fmxtee::Canvas::TTeeHiddenPen* Border = {read=FBorder, write=SetBorder};
	__property Brush;
	__property bool FastBrush = {read=FFastBrush, write=SetFastBrush, default=0};
	__property bool HideTriangles = {read=FHide, write=SetHide, default=1};
	__property Pen;
	__property Transparency = {default=0};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TTriSurfaceSeries : public TCustomTriSurfaceSeries
{
	typedef TCustomTriSurfaceSeries inherited;
	
__published:
	__property Active = {default=1};
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
	__property Border;
	__property Brush;
	__property EndColor = {default=-1};
	__property FastBrush = {default=0};
	__property HideTriangles = {default=1};
	__property LegendEvery = {default=1};
	__property MidColor = {default=0};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property StartColor = {default=-16777088};
	__property UseColorRange = {default=1};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property TimesZOrder = {default=3};
	__property Transparency = {default=0};
	__property XValues;
	__property YValues;
	__property ZValues;
	__property OnGetColor;
public:
	/* TCustomTriSurfaceSeries.Create */ inline __fastcall virtual TTriSurfaceSeries(System::Classes::TComponent* AOwner) : TCustomTriSurfaceSeries(AOwner) { }
	/* TCustomTriSurfaceSeries.Destroy */ inline __fastcall virtual ~TTriSurfaceSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Trisurface */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_TRISURFACE)
using namespace Fmxtee::Series::Trisurface;
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
#endif	// Fmxtee_Series_TrisurfaceHPP
