// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTriSurface.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetrisurfaceHPP
#define Vcltee_TeetrisurfaceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeeTriangulate.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetrisurface
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
	System::Uitypes::TColor Color;
	TTriangle *Next;
	TTriangle *Prev;
	Vcltee::Tecanvas::TTrianglePoints P;
	double Z;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION ETriSurfaceException : public Vcltee::Teengine::ChartException
{
	typedef Vcltee::Teengine::ChartException inherited;
	
public:
	/* Exception.Create */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg) : Vcltee::Teengine::ChartException(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : Vcltee::Teengine::ChartException(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ETriSurfaceException(NativeUInt Ident)/* overload */ : Vcltee::Teengine::ChartException(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec)/* overload */ : Vcltee::Teengine::ChartException(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ETriSurfaceException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : Vcltee::Teengine::ChartException(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : Vcltee::Teengine::ChartException(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg, int AHelpContext) : Vcltee::Teengine::ChartException(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ETriSurfaceException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : Vcltee::Teengine::ChartException(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ETriSurfaceException(NativeUInt Ident, int AHelpContext)/* overload */ : Vcltee::Teengine::ChartException(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Vcltee::Teengine::ChartException(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ETriSurfaceException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Vcltee::Teengine::ChartException(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ETriSurfaceException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Vcltee::Teengine::ChartException(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ETriSurfaceException() { }
	
};


class PASCALIMPLEMENTATION TCustomTriSurfaceSeries : public Vcltee::Teesurfa::TCustom3DPaletteSeries
{
	typedef Vcltee::Teesurfa::TCustom3DPaletteSeries inherited;
	
private:
	Vcltee::Tecanvas::TTeeHiddenPen* FBorder;
	bool FFastBrush;
	bool FHide;
	bool IDirtyTriangles;
	TTriangle *Triangles;
	TTriangle *ILastTriangle;
	Vcltee::Teetriangulate::TTriangulator* ITriangulator;
	Vcltee::Tecanvas::TTeeCachedObject* ICachedSurface;
	HGDIOBJ DCBRUSH;
	HDC CanvasDC;
	Vcltee::Tecanvas::TPoint3D __fastcall CalcPointResult(int Index);
	void __fastcall CalcTriPoints(int Index, /* out */ Vcltee::Tecanvas::TTrianglePoints3D &Points, /* out */ Vcltee::Tecanvas::TTriangleColors3D &Colors, /* out */ Vcltee::Tecanvas::TTriangleIndexes &Indexes);
	void __fastcall ClearTriangles();
	void __fastcall FreeCached();
	double __fastcall GetX(int Index);
	double __fastcall GetZ(int Index);
	void __fastcall SetBorder(Vcltee::Tecanvas::TTeeHiddenPen* Value);
	void __fastcall SetFastBrush(const bool Value);
	void __fastcall SetHide(const bool Value);
	void __fastcall SetXYZ(int Dest, int Source);
	
protected:
	bool Reuse3D;
	bool Normals;
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	virtual void __fastcall ChangedAxisScale(Vcltee::Teengine::TChartAxis* const Axis);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall NotifyValue(Vcltee::Teengine::TValueEvent ValueEvent, int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
public:
	bool CacheTriangles;
	__fastcall virtual TCustomTriSurfaceSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomTriSurfaceSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	void __fastcall TrianglePoints(int TriangleIndex, /* out */ Vcltee::Tecanvas::TTrianglePoints3D &P);
	__property Vcltee::Tecanvas::TTeeHiddenPen* Border = {read=FBorder, write=SetBorder};
	__property Brush;
	__property bool FastBrush = {read=FFastBrush, write=SetFastBrush, default=0};
	__property bool HideTriangles = {read=FHide, write=SetHide, default=1};
	__property Pen;
	__property Transparency = {default=0};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
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
	__property EndColor = {default=16777215};
	__property FastBrush = {default=0};
	__property HideTriangles = {default=1};
	__property LegendEvery = {default=1};
	__property MidColor = {default=536870911};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property StartColor = {default=8388608};
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
}	/* namespace Teetrisurface */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETRISURFACE)
using namespace Vcltee::Teetrisurface;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetrisurfaceHPP
