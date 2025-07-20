// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSurfa.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesurfaHPP
#define Vcltee_TeesurfaHPP

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
#include <System.Generics.Collections.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeFilters.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesurfa
{
//-- forward type declarations -----------------------------------------------
struct TLevelPoint;
struct TLevelPoint3D;
struct TLevelSegment;
struct TLevelLine;
struct TGridPalette;
struct TCellsOrientation;
class DELPHICLASS TCustom3DSeries;
class DELPHICLASS TCustom3DPaletteSeries;
class DELPHICLASS TCustom3DGridSeries;
class DELPHICLASS TSurfaceSeries;
class DELPHICLASS TContourLevel;
class DELPHICLASS TContourLevels;
class DELPHICLASS TSmoothPoints;
class DELPHICLASS TContourMarks;
class DELPHICLASS TContourSeries;
class DELPHICLASS TWaterFallSeries;
class DELPHICLASS TColorGridSeries;
class DELPHICLASS TVector3DSeries;
struct TTowerPosition;
class DELPHICLASS TTowerSeries;
class DELPHICLASS TSurfaceSides;
class DELPHICLASS TIsoSurfaceSeries;
class DELPHICLASS TSeriesColorPalette;
class DELPHICLASS TBubbleCloudSeries;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<Vcltee::Teengine::TChartValues> TArrayGrid;

struct DECLSPEC_DRECORD TLevelPoint
{
public:
	double X;
	double Y;
};


struct DECLSPEC_DRECORD TLevelPoint3D
{
public:
	double X;
	double Y;
	double Z;
};


typedef System::DynamicArray<TLevelPoint> TLevelPoints;

struct DECLSPEC_DRECORD TLevelSegment
{
public:
	int Count;
	TLevelPoints Points;
};


struct DECLSPEC_DRECORD TLevelLine
{
public:
	TLevelPoint A;
	TLevelPoint B;
};


typedef System::DynamicArray<TLevelSegment> TLevelSegments;

struct DECLSPEC_DRECORD TGridPalette
{
public:
	double UpToValue;
	System::Uitypes::TColor Color;
	System::UnicodeString Text;
};


typedef System::DynamicArray<TGridPalette> TCustom3DPalette;

struct DECLSPEC_DRECORD TCellsOrientation
{
public:
	int InitX;
	int EndX;
	int IncX;
	int InitZ;
	int EndZ;
	int IncZ;
};


typedef Vcltee::Tecanvas::TRGBArray TTee3DRGBArray;

class PASCALIMPLEMENTATION TCustom3DSeries : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
private:
	int FTimesZOrder;
	Vcltee::Teengine::TChartValueList* FZValues;
	System::Types::TRect IOldChartRect;
	int IOldStartZ;
	int IOldEndZ;
	bool __fastcall BackFaced();
	double __fastcall GetZValue(int Index);
	void __fastcall SetTimesZOrder(const int Value);
	void __fastcall SetZValue(int Index, const double Value);
	void __fastcall SetZValues(Vcltee::Teengine::TChartValueList* const Value);
	
protected:
	bool __fastcall AxisRectChanged();
	virtual void __fastcall CalcZOrder();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual void __fastcall Load(int NumX, int NumY, const Vcltee::Tecanvas::TRGBArray RGBs, bool Inverted = false)/* overload */;
	virtual void __fastcall PrepareLegendCanvas(int ValueIndex, System::Uitypes::TColor &BackColor, Vcl::Graphics::TBrushStyle &BrushStyle);
	void __fastcall SaveChartRect();
	virtual Vcltee::Teengine::TChartValueList* __fastcall ValueListOfAxis(Vcltee::Teengine::TChartAxis* const Axis);
	
public:
	__fastcall virtual TCustom3DSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE void __fastcall AddArray(const TArrayGrid Values)/* overload */;
	int __fastcall AddXYZ(const double AX, const double AY, const double AZ)/* overload */;
	virtual int __fastcall AddXYZ(const double AX, const double AY, const double AZ, const System::UnicodeString AXLabel, System::Uitypes::TColor AColor)/* overload */;
	virtual bool __fastcall AssociatedToAxis(Vcltee::Teengine::TChartAxis* const Axis);
	int __fastcall CalcZPos(int ValueIndex);
	DYNAMIC bool __fastcall IsValidSourceOf(Vcltee::Teengine::TChartSeries* Value);
	void __fastcall Load(Vcl::Graphics::TGraphic* const Graphic, bool Inverted = false)/* overload */;
	virtual double __fastcall MaxZValue();
	virtual double __fastcall MinZValue();
	__property double ZValue[int Index] = {read=GetZValue, write=SetZValue};
	__property int TimesZOrder = {read=FTimesZOrder, write=SetTimesZOrder, default=3};
	__property Vcltee::Teengine::TChartValueList* ZValues = {read=FZValues, write=SetZValues};
public:
	/* TChartSeries.Destroy */ inline __fastcall virtual ~TCustom3DSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  AddArray(const int *Values, const int Values_High){ return Vcltee::Teengine::TChartSeries::AddArray(Values, Values_High); }
	inline int __fastcall  AddArray(const double *Values, const int Values_High){ return Vcltee::Teengine::TChartSeries::AddArray(Values, Values_High); }
	inline int __fastcall  AddArray(const double *XValues, const int XValues_High, const double *YValues, const int YValues_High){ return Vcltee::Teengine::TChartSeries::AddArray(XValues, XValues_High, YValues, YValues_High); }
	
};


enum DECLSPEC_DENUM TTeePaletteStyle : unsigned char { psPale, psStrong, psGrayScale, psInvGray, psRainbow, psCustom };

typedef void __fastcall (__closure *TChartSurfaceGetColor)(Vcltee::Teengine::TChartSeries* Sender, int ValueIndex, System::Uitypes::TColor &Color);

class PASCALIMPLEMENTATION TCustom3DPaletteSeries : public TCustom3DSeries
{
	typedef TCustom3DSeries inherited;
	
private:
	System::Uitypes::TColor FEndColor;
	System::Uitypes::TColor FMidColor;
	TCustom3DPalette FPalette;
	int FLegendEvery;
	double FPaletteMin;
	double FPaletteStep;
	int FPaletteSteps;
	TTeePaletteStyle FPaletteStyle;
	System::Uitypes::TColor FStartColor;
	bool FUseColorRange;
	bool FUsePalette;
	bool FUsePaletteMin;
	TChartSurfaceGetColor FOnGetColor;
	int IRangeRed;
	int IEndRed;
	int IMidRed;
	int IRangeMidRed;
	int IRangeGreen;
	int IEndGreen;
	int IMidGreen;
	int IRangeMidGreen;
	int IRangeBlue;
	int IEndBlue;
	int IMidBlue;
	int IRangeMidBlue;
	int IRangeAlpha;
	int IEndAlpha;
	int IMidAlpha;
	int IRangeMidAlpha;
	double IValueRangeInv;
	bool ICustomPalette;
	bool IDirtyPalette;
	void __fastcall CalcColorRange();
	void __fastcall CalcValueRange();
	void __fastcall CheckPaletteEmpty();
	int __fastcall DoAddPalette(const double AValue, System::Uitypes::TColor AColor);
	System::Uitypes::TColor __fastcall RangePercent(const double Percent);
	void __fastcall ReadPalette(System::Classes::TStream* Stream);
	void __fastcall SetEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetGalleryPalette();
	void __fastcall SetLegendEvery(const int Value);
	void __fastcall SetMidColor(const System::Uitypes::TColor Value);
	void __fastcall SetPaletteMin(const double Value);
	void __fastcall SetPaletteStep(const double Value);
	void __fastcall SetPaletteSteps(const int Value);
	void __fastcall SetPaletteStyle(const TTeePaletteStyle Value);
	void __fastcall SetRangeColor(System::Uitypes::TColor &Variable, const System::Uitypes::TColor Value);
	void __fastcall SetStartColor(const System::Uitypes::TColor Value);
	void __fastcall SetUseColorRange(const bool Value);
	void __fastcall SetUsePalette(const bool Value);
	void __fastcall SetUsePaletteMin(const bool Value);
	void __fastcall WritePalette(System::Classes::TStream* Stream);
	
protected:
	bool DefaultLegend;
	double PaletteRange;
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual int __fastcall CalcLegendIndex(int LegendIndex);
	System::UnicodeString __fastcall CalcLegendString(Vcltee::Teengine::TLegendTextStyle AStyle, const System::UnicodeString AText, const double AValue, int AIndex);
	virtual void __fastcall ChangedColors();
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	void __fastcall GeneratePalette();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall GetPaletteBounds(/* out */ double &AMin, /* out */ double &ARange);
	virtual System::Uitypes::TColor __fastcall GetValueColor(int ValueIndex);
	System::Uitypes::TColor __fastcall GetValueColorValue(const double AValue);
	virtual void __fastcall NotifyColorChange(int ValueIndex);
	virtual void __fastcall NotifyValue(Vcltee::Teengine::TValueEvent ValueEvent, int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetPalette(const TCustom3DPalette Value);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
public:
	double RedFactor;
	double GreenFactor;
	double BlueFactor;
	__fastcall virtual TCustom3DPaletteSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustom3DPaletteSeries();
	int __fastcall AddPalette(const double AValue, System::Uitypes::TColor AColor)/* overload */;
	void __fastcall AddPalette(const Vcltee::Teeprocs::TColorArray APalette)/* overload */;
	void __fastcall AddPalette(const System::Uitypes::TColor *APalette, const int APalette_High)/* overload */;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Clear();
	void __fastcall ClearPalette();
	virtual int __fastcall CountLegendItems();
	void __fastcall CreateDefaultPalette(int NumSteps = 0x0);
	void __fastcall CreateRangePalette();
	System::Uitypes::TColor __fastcall GetSurfacePaletteColor(const double Y);
	void __fastcall InvertPalette();
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	void __fastcall LoadPaletteFromFile(const System::UnicodeString FileName);
	void __fastcall SavePaletteToFile(const System::UnicodeString FileName);
	__property System::Uitypes::TColor EndColor = {read=FEndColor, write=SetEndColor, default=16777215};
	__property System::Uitypes::TColor MidColor = {read=FMidColor, write=SetMidColor, default=536870911};
	__property int LegendEvery = {read=FLegendEvery, write=SetLegendEvery, default=1};
	__property TCustom3DPalette Palette = {read=FPalette, write=SetPalette};
	__property double PaletteMin = {read=FPaletteMin, write=SetPaletteMin};
	__property double PaletteStep = {read=FPaletteStep, write=SetPaletteStep};
	__property int PaletteSteps = {read=FPaletteSteps, write=SetPaletteSteps, default=32};
	__property TTeePaletteStyle PaletteStyle = {read=FPaletteStyle, write=SetPaletteStyle, default=0};
	__property System::Uitypes::TColor StartColor = {read=FStartColor, write=SetStartColor, default=8388608};
	__property bool UseColorRange = {read=FUseColorRange, write=SetUseColorRange, default=1};
	__property bool UsePalette = {read=FUsePalette, write=SetUsePalette, default=0};
	__property bool UsePaletteMin = {read=FUsePaletteMin, write=SetUsePaletteMin, default=0};
	__property TChartSurfaceGetColor OnGetColor = {read=FOnGetColor, write=FOnGetColor};
};


typedef double __fastcall (__closure *TChartSurfaceGetY)(Vcltee::Teengine::TChartSeries* Sender, int X, int Z);

class PASCALIMPLEMENTATION TCustom3DGridSeries : public TCustom3DPaletteSeries
{
	typedef TCustom3DPaletteSeries inherited;
	
	
private:
	typedef System::DynamicArray<int> _TCustom3DGridSeries__1;
	
	typedef System::DynamicArray<System::DynamicArray<int> > _TCustom3DGridSeries__2;
	
	
private:
	bool FIrregularGrid;
	int FNumXValues;
	int FNumZValues;
	bool FReuseGrid;
	TChartSurfaceGetY FOnGetYValue;
	int FXStartIndex;
	int FZStartIndex;
	bool IDirtyGrid;
	int INextXCell;
	int INextZCell;
	bool INoRandom;
	bool __fastcall ExistFourGridIndex(int X, int Z);
	void __fastcall SetIrregularGrid(const bool Value);
	void __fastcall SetNumXValues(int Value);
	void __fastcall SetNumZValues(int Value);
	double __fastcall GetValue(int X, int Z);
	void __fastcall SetValue(int X, int Z, const double Value);
	
protected:
	int ValueIndex0;
	int ValueIndex1;
	int ValueIndex2;
	int ValueIndex3;
	int ISampleFormula;
	bool IInGallery;
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall Load(int NumX, int NumY, const Vcltee::Tecanvas::TRGBArray RGBs, bool Inverted = false)/* overload */;
	virtual void __fastcall NotifyValue(Vcltee::Teengine::TValueEvent ValueEvent, int ValueIndex);
	bool __fastcall CanCreateValues();
	
public:
	_TCustom3DGridSeries__2 GridIndex;
	__fastcall virtual TCustom3DGridSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Clear();
	virtual void __fastcall CreateValues(int NumX, int NumZ);
	void __fastcall FillGridIndex()/* overload */;
	void __fastcall FillGridIndex(int StartIndex)/* overload */;
	virtual double __fastcall GetXZValue(int X, int Z);
	DYNAMIC bool __fastcall IsValidSeriesSource(Vcltee::Teengine::TChartSeries* Value);
	DYNAMIC int __fastcall NumSampleValues();
	void __fastcall ReCreateValues();
	__property bool IrregularGrid = {read=FIrregularGrid, write=SetIrregularGrid, default=0};
	__property int NumXValues = {read=FNumXValues, write=SetNumXValues, default=10};
	__property int NumZValues = {read=FNumZValues, write=SetNumZValues, default=10};
	__property bool ReuseGridIndex = {read=FReuseGrid, write=FReuseGrid, default=1};
	__property double Value[int X][int Z] = {read=GetValue, write=SetValue};
	__property TChartSurfaceGetY OnGetYValue = {read=FOnGetYValue, write=FOnGetYValue};
public:
	/* TCustom3DPaletteSeries.Destroy */ inline __fastcall virtual ~TCustom3DGridSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Load(Vcl::Graphics::TGraphic* const Graphic, bool Inverted = false){ TCustom3DSeries::Load(Graphic, Inverted); }
	
};


class PASCALIMPLEMENTATION TSurfaceSeries : public TCustom3DGridSeries
{
	typedef TCustom3DGridSeries inherited;
	
private:
	bool FDotFrame;
	bool FFastBrush;
	bool FHideCells;
	Vcltee::Tecanvas::TTeeBrush* FSideBrush;
	Vcltee::Tecanvas::TTeeHiddenPen* FSideLines;
	bool FSmoothPalette;
	bool FWaterFall;
	Vcltee::Tecanvas::TTeePen* FWaterLines;
	bool FWireFrame;
	bool FNormals;
	bool FReuse3D;
	bool FSameBrush;
	Vcltee::Tecanvas::TTeeCachedObject* ICachedSurface;
	void __fastcall FreeCached();
	void __fastcall SetDotFrame(bool Value);
	void __fastcall SetFastBrush(const bool Value);
	void __fastcall SetHideCells(const bool Value);
	void __fastcall SetSideBrush(Vcltee::Tecanvas::TTeeBrush* const Value);
	void __fastcall SetSideLines(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	void __fastcall SetSmoothPalette(bool Value);
	void __fastcall SetWaterFall(bool Value);
	void __fastcall SetWireFrame(bool Value);
	void __fastcall SetWaterLines(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	Vcltee::Tecanvas::TFourPoints Points;
	bool IsFastBrush;
	HDC CanvasDC;
	Vcltee::Tecanvas::TTeeBlend* IBlender;
	Vcltee::Teengine::TAxisCalcPos ICalcX;
	Vcltee::Teengine::TAxisCalcPos ICalcY;
	Vcltee::Teengine::TAxisCalcPos ICalcZ;
	Vcltee::Teengine::TChartValues IXValue;
	Vcltee::Teengine::TChartValues IYValue;
	Vcltee::Teengine::TChartValues IZValue;
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	System::Types::TPoint __fastcall CalcPointPos(const int Index);
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	virtual void __fastcall ChangedAxisScale(Vcltee::Teengine::TChartAxis* const Axis);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawCell(int x, int z);
	virtual void __fastcall DrawSidePortion(Vcltee::Tecanvas::TFourPoints &P, int z0, int z1);
	virtual void __fastcall DrawValue(int ValueIndex);
	void __fastcall FastCalcPoints(int x, int z, bool CalcColors, /* out */ Vcltee::Tecanvas::TSurfaceVertex &V);
	bool __fastcall FourGridIndex(int x, int z);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall NotifyValue(Vcltee::Teengine::TValueEvent ValueEvent, int ValueIndex);
	void __fastcall PointsTo2D(int Z0, int Z1, /* out */ Vcltee::Tecanvas::TFourPoints &P);
	virtual void __fastcall PrepareCalcPos();
	void __fastcall PrepareFastBrush();
	DYNAMIC void __fastcall PrepareForGallery();
	void __fastcall SetBrushColor(const System::Uitypes::TColor AColor);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	virtual bool __fastcall ShouldDrawFast();
	virtual bool __fastcall ShouldDrawSides();
	__property bool Normals = {read=FNormals, write=FNormals, nodefault};
	__property bool Reuse3D = {read=FReuse3D, write=FReuse3D, nodefault};
	
public:
	__fastcall virtual TSurfaceSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSurfaceSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	TCellsOrientation __fastcall CellsOrientation();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	int __fastcall ClickedCell(int x, int y);
	virtual bool __fastcall MoreSameZOrder();
	__property bool WaterFall = {read=FWaterFall, write=SetWaterFall, default=0};
	__property Vcltee::Tecanvas::TTeePen* WaterLines = {read=FWaterLines, write=SetWaterLines};
	
__published:
	__property Active = {default=1};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property bool FastBrush = {read=FFastBrush, write=SetFastBrush, default=0};
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
	__property Brush;
	__property bool DotFrame = {read=FDotFrame, write=SetDotFrame, default=0};
	__property EndColor = {default=16777215};
	__property bool HideCells = {read=FHideCells, write=SetHideCells, default=1};
	__property IrregularGrid = {default=0};
	__property MidColor = {default=536870911};
	__property NumXValues = {default=10};
	__property NumZValues = {default=10};
	__property LegendEvery = {default=1};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property Vcltee::Tecanvas::TTeeBrush* SideBrush = {read=FSideBrush, write=SetSideBrush};
	__property Vcltee::Tecanvas::TTeeHiddenPen* SideLines = {read=FSideLines, write=SetSideLines};
	__property bool SmoothPalette = {read=FSmoothPalette, write=SetSmoothPalette, default=0};
	__property StartColor = {default=8388608};
	__property UseColorRange = {default=1};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property bool WireFrame = {read=FWireFrame, write=SetWireFrame, default=0};
	__property TimesZOrder = {default=3};
	__property Transparency = {default=0};
	__property XValues;
	__property YValues;
	__property ZValues;
	__property OnGetYValue;
	__property OnGetColor;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


typedef void __fastcall (__closure *TOnBeforeDrawLevelEvent)(TContourSeries* Sender, int LevelIndex);

typedef void __fastcall (__closure *TOnGetLevelEvent)(TContourSeries* Sender, int LevelIndex, double &Value, System::Uitypes::TColor &Color);

class PASCALIMPLEMENTATION TContourLevel : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Uitypes::TColor FColor;
	Vcltee::Tecanvas::TTeePen* FPen;
	System::UnicodeString FText;
	double FUpTo;
	int FSegmentCount;
	TLevelSegments FSegments;
	TContourSeries* ISeries;
	void __fastcall AddSegment(const TLevelPoint &A, const TLevelPoint &B);
	void __fastcall CheckAuto();
	Vcltee::Tecanvas::TTeePen* __fastcall GetPen();
	bool __fastcall IsPenStored();
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetUpTo(const double Value);
	
protected:
	System::Uitypes::TColor __fastcall InternalColor();
	Vcltee::Tecanvas::TTeePen* __fastcall InternalPen();
	
public:
	__fastcall virtual TContourLevel(System::Classes::TCollection* Collection);
	__fastcall virtual ~TContourLevel();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall ClearSegments();
	bool __fastcall Clicked(int x, int y, /* out */ int &SegmentIndex, /* out */ int &PointIndex);
	bool __fastcall ClickedSegment(int x, int y, int SegmentIndex, /* out */ int &PointIndex);
	void __fastcall DeleteSegment(const int Index);
	Vcltee::Tecanvas::TPointArray __fastcall GetSegmentPoints(int SegmentIndex);
	Vcltee::Tecanvas::TPointFloatArray __fastcall GetSegmentPointsFloat(int SegmentIndex);
	bool __fastcall DefaultPen();
	int __fastcall SegmentCount();
	__property TLevelSegments Segments = {read=FSegments};
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, nodefault};
	__property Vcltee::Tecanvas::TTeePen* Pen = {read=GetPen, write=SetPen, stored=IsPenStored};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property double UpToValue = {read=FUpTo, write=SetUpTo};
};


class PASCALIMPLEMENTATION TContourLevels : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TContourLevel* operator[](int Index) { return this->Items[Index]; }
	
private:
	TContourLevel* __fastcall Get(int Index);
	void __fastcall Put(int Index, TContourLevel* const Value);
	
public:
	TContourLevel* __fastcall AddLevel(const double Value, const System::Uitypes::TColor Color = (System::Uitypes::TColor)(0x20000000));
	int __fastcall Clicked(int x, int y, /* out */ int &SegmentIndex, /* out */ int &PointIndex);
	TContourSeries* __fastcall Contour();
	TContourLevel* __fastcall Last();
	__property TContourLevel* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TContourLevels(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TContourLevels() { }
	
};


class PASCALIMPLEMENTATION TSmoothPoints : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FActive;
	Vcltee::Teengine::TChartSeries* ISeries;
	bool FInterpolate;
	void __fastcall SetActive(const bool Value);
	void __fastcall SetInterpolate(const bool Value);
	
public:
	int Factor;
	__fastcall TSmoothPoints(Vcltee::Teengine::TChartSeries* const Parent);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Vcltee::Tecanvas::TPointArray __fastcall Calculate(const System::Types::TPoint *P, const int P_High);
	Vcltee::Tecanvas::TPointFloatArray __fastcall CalculateFloat(const _POINTFLOAT *P, const int P_High);
	
__published:
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property bool Interpolate = {read=FInterpolate, write=SetInterpolate, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TSmoothPoints() { }
	
};


class PASCALIMPLEMENTATION TContourMarks : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FAntiOverlap;
	bool FAtSegments;
	bool FColorLevel;
	int FDensity;
	int FMargin;
	Vcltee::Teengine::TChartSeries* IContour;
	bool __fastcall GetVisible();
	void __fastcall SetAntiOverlap(const bool Value);
	void __fastcall SetAtSegments(const bool Value);
	void __fastcall SetColorLevel(const bool Value);
	void __fastcall SetDensity(const int Value);
	void __fastcall SetMargin(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TContourMarks();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool AntiOverlap = {read=FAntiOverlap, write=SetAntiOverlap, default=0};
	__property bool AtSegments = {read=FAtSegments, write=SetAtSegments, default=1};
	__property bool ColorLevel = {read=FColorLevel, write=SetColorLevel, default=0};
	__property int Margin = {read=FMargin, write=SetMargin, default=0};
	__property int Density = {read=FDensity, write=SetDensity, default=4};
	__property bool Visible = {read=GetVisible, write=SetVisible, stored=false, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TContourMarks() { }
	
};


class PASCALIMPLEMENTATION TContourSeries : public TCustom3DGridSeries
{
	typedef TCustom3DGridSeries inherited;
	
private:
	bool FAutomaticLevels;
	Vcltee::Tecanvas::TTeeHiddenPen* FCellPen;
	TContourMarks* FContourMarks;
	Vcltee::Tecanvas::TTeeHiddenPen* FFrame;
	bool FLegendLines;
	TContourLevels* FLevels;
	System::Uitypes::TColor FLinesColor;
	int FNumLevels;
	Vcltee::Teengine::TSeriesPointer* FPointer;
	TSmoothPoints* FSmoothing;
	double FYPosition;
	bool FYPositionLevel;
	TOnBeforeDrawLevelEvent FOnBeforeDrawLevel;
	TOnGetLevelEvent FOnGetLevel;
	bool IDirtySegments;
	TIsoSurfaceSeries* IFillSeries;
	bool IModifyingLevels;
	TContourLevel* TheLevel;
	void __fastcall AddSegmentLine(const TLevelPoint &A, const TLevelPoint &B);
	void __fastcall ClearAutoLevels();
	void __fastcall DrawFrame(const int YPos);
	Vcltee::Tecanvas::TTeeHiddenPen* __fastcall GetCellPen();
	bool __fastcall GetFilled();
	int __fastcall GetNumLevels();
	bool __fastcall IsLevelsStored();
	bool __fastcall MarkOverlaps(const System::Types::TRect &ABounds);
	void __fastcall SetAutomaticLevels(const bool Value);
	void __fastcall SetCellPen(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	void __fastcall SetContourMarks(TContourMarks* const Value);
	void __fastcall SetFilled(const bool Value);
	void __fastcall SetFrame(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	void __fastcall SetLegendLines(const bool Value);
	void __fastcall SetLevels(TContourLevels* const Value);
	void __fastcall SetLinesColor(const System::Uitypes::TColor Value);
	void __fastcall SetNumLevels(int Value);
	void __fastcall SetPointer(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetSmoothing(TSmoothPoints* const Value);
	void __fastcall SetYPosition(const double Value);
	void __fastcall SetYPositionLevel(bool Value);
	void __fastcall TryCreateLevels();
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual int __fastcall CalcLegendIndex(int LegendIndex);
	virtual System::Types::TPoint __fastcall CalcXYPoint(const TLevelPoint &P);
	virtual _POINTFLOAT __fastcall CalcXYPointFloat(const TLevelPoint &P);
	virtual void __fastcall ChangedColors();
	virtual TIsoSurfaceSeries* __fastcall CreateIso();
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawMarks();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall GetPaletteBounds(/* out */ double &AMin, /* out */ double &ARange);
	virtual void __fastcall NotifyColorChange(int ValueIndex);
	virtual void __fastcall NotifyValue(Vcltee::Teengine::TValueEvent ValueEvent, int ValueIndex);
	virtual void __fastcall SetPalette(const TCustom3DPalette Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	virtual int __fastcall ValueIndexToLegend(int ValueIndex);
	
public:
	__fastcall virtual TContourSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TContourSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual int __fastcall CountLegendItems();
	void __fastcall CreateAutoLevels();
	virtual double __fastcall GetMarkValue(int ValueIndex);
	Vcltee::Teengine::TChartAxis* __fastcall GetZAxis();
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	virtual int __fastcall LegendToValueIndex(int LegendIndex);
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	
__published:
	__property Active = {default=1};
	__property bool AutomaticLevels = {read=FAutomaticLevels, write=SetAutomaticLevels, default=1};
	__property Brush;
	__property Vcltee::Tecanvas::TTeeHiddenPen* CellPen = {read=GetCellPen, write=SetCellPen};
	__property ColorEachPoint = {default=1};
	__property ColorSource = {default=0};
	__property TContourMarks* ContourMarks = {read=FContourMarks, write=SetContourMarks};
	__property Cursor = {default=0};
	__property bool Filled = {read=GetFilled, write=SetFilled, default=0};
	__property Vcltee::Tecanvas::TTeeHiddenPen* Frame = {read=FFrame, write=SetFrame};
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
	__property EndColor = {default=16777215};
	__property IrregularGrid = {default=0};
	__property LegendEvery = {default=1};
	__property bool LegendLines = {read=FLegendLines, write=SetLegendLines, default=0};
	__property TContourLevels* Levels = {read=FLevels, write=SetLevels, stored=IsLevelsStored};
	__property System::Uitypes::TColor LinesColor = {read=FLinesColor, write=SetLinesColor, default=0};
	__property MidColor = {default=536870911};
	__property int NumLevels = {read=GetNumLevels, write=SetNumLevels, default=10};
	__property NumXValues = {default=10};
	__property NumZValues = {default=10};
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property Pen;
	__property Vcltee::Teengine::TSeriesPointer* Pointer = {read=FPointer, write=SetPointer};
	__property TSmoothPoints* Smoothing = {read=FSmoothing, write=SetSmoothing};
	__property StartColor = {default=8388608};
	__property TimesZOrder = {default=3};
	__property Transparency = {default=0};
	__property UseColorRange = {default=0};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property XValues;
	__property double YPosition = {read=FYPosition, write=SetYPosition};
	__property bool YPositionLevel = {read=FYPositionLevel, write=SetYPositionLevel, default=0};
	__property YValues;
	__property ZValues;
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
	__property TOnBeforeDrawLevelEvent OnBeforeDrawLevel = {read=FOnBeforeDrawLevel, write=FOnBeforeDrawLevel};
	__property OnGetYValue;
	__property TOnGetLevelEvent OnGetLevel = {read=FOnGetLevel, write=FOnGetLevel};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TWaterFallSeries : public TSurfaceSeries
{
	typedef TSurfaceSeries inherited;
	
protected:
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TWaterFallSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property WaterFall = {default=1};
	__property WaterLines;
public:
	/* TSurfaceSeries.Destroy */ inline __fastcall virtual ~TWaterFallSeries() { }
	
};


class PASCALIMPLEMENTATION TColorGridSeries : public TCustom3DGridSeries
{
	typedef TCustom3DGridSeries inherited;
	
private:
	Vcl::Graphics::TBitmap* FBitmap;
	bool FCentered;
	Vcltee::Tecanvas::TCanvas3DPlane FPlane3D;
	Vcltee::Tecanvas::TTeeHiddenPen* FFrame;
	int FPosition;
	bool FSmoothBitmap;
	int FXGridEvery;
	int FZGridEvery;
	bool FXRegularSteps;
	bool FZRegularSteps;
	double FXRegularStep;
	double FZRegularStep;
	bool IDirtyBitmap;
	System::Types::TRect IOldBounds;
	double __fastcall CalcMaxValue(const double Value);
	double __fastcall CalcMinValue(const double Value);
	void __fastcall DoCreateBitmap(int AWidth, int AHeight);
	void __fastcall SetBitmap(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetCentered(const bool Value);
	void __fastcall SetPlane3D(const Vcltee::Tecanvas::TCanvas3DPlane Value);
	void __fastcall SetFrame(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetSmoothBitmap(const bool Value);
	void __fastcall SetXGridEvery(const int Value);
	void __fastcall SetZGridEvery(const int Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall ChangedColors();
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall NotifyValue(Vcltee::Teengine::TValueEvent ValueEvent, int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TColorGridSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TColorGridSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TRect __fastcall CellBounds(int ValueIndex)/* overload */;
	System::Types::TRect __fastcall CellBounds(int x, int z)/* overload */;
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall MinZValue();
	virtual double __fastcall MaxZValue();
	__property Vcl::Graphics::TBitmap* Bitmap = {read=FBitmap, write=SetBitmap};
	
__published:
	__property Active = {default=1};
	__property bool CenteredPoints = {read=FCentered, write=SetCentered, default=0};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Vcltee::Tecanvas::TCanvas3DPlane DrawPlane3D = {read=FPlane3D, write=SetPlane3D, default=2};
	__property int DrawPosition = {read=FPosition, write=SetPosition, default=0};
	__property Vcltee::Tecanvas::TTeeHiddenPen* Frame = {read=FFrame, write=SetFrame};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property bool SmoothBitmap = {read=FSmoothBitmap, write=SetSmoothBitmap, default=0};
	__property Title = {default=0};
	__property Transparency = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property int XGridEvery = {read=FXGridEvery, write=SetXGridEvery, default=1};
	__property XLabelsSource = {default=0};
	__property int ZGridEvery = {read=FZGridEvery, write=SetZGridEvery, default=1};
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
	__property Brush;
	__property EndColor = {default=16777215};
	__property IrregularGrid = {default=0};
	__property MidColor = {default=536870911};
	__property NumXValues = {default=10};
	__property NumZValues = {default=10};
	__property LegendEvery = {default=1};
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
	__property XValues;
	__property YValues;
	__property ZValues;
	__property OnGetYValue;
	__property OnGetColor;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TVector3DSeries : public TCustom3DPaletteSeries
{
	typedef TCustom3DPaletteSeries inherited;
	
private:
	int FArrowHeight;
	int FArrowWidth;
	Vcltee::Tecanvas::TTeeHiddenPen* FStartArrow;
	Vcltee::Tecanvas::TTeePen* FEndArrow;
	Vcltee::Teengine::TChartValueList* FEndXValues;
	Vcltee::Teengine::TChartValueList* FEndYValues;
	Vcltee::Teengine::TChartValueList* FEndZValues;
	void __fastcall SetArrowHeight(const int Value);
	void __fastcall SetArrowWidth(const int Value);
	void __fastcall SetEndXValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetEndYValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetEndZValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetEndArrow(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetStartArrow(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TVector3DSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TVector3DSeries();
	int __fastcall AddVector(const double X0, const double Y0, const double Z0, const double X1, const double Y1, const double Z1, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	DYNAMIC bool __fastcall IsValidSourceOf(Vcltee::Teengine::TChartSeries* Value);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall MaxZValue();
	virtual double __fastcall MinZValue();
	DYNAMIC int __fastcall NumSampleValues();
	
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
	__property Brush;
	__property EndColor = {default=16777215};
	__property MidColor = {default=536870911};
	__property LegendEvery = {default=1};
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
	__property XValues;
	__property YValues;
	__property ZValues;
	__property OnGetColor;
	__property int ArrowHeight = {read=FArrowHeight, write=SetArrowHeight, default=4};
	__property int ArrowWidth = {read=FArrowWidth, write=SetArrowWidth, default=4};
	__property Vcltee::Tecanvas::TTeePen* EndArrow = {read=FEndArrow, write=SetEndArrow};
	__property Vcltee::Teengine::TChartValueList* EndXValues = {read=FEndXValues, write=SetEndXValues};
	__property Vcltee::Teengine::TChartValueList* EndYValues = {read=FEndYValues, write=SetEndYValues};
	__property Vcltee::Teengine::TChartValueList* EndZValues = {read=FEndZValues, write=SetEndZValues};
	__property Vcltee::Tecanvas::TTeeHiddenPen* StartArrow = {read=FStartArrow, write=SetStartArrow};
};


enum DECLSPEC_DENUM TTowerStyle : unsigned char { tsCube, tsRectangle, tsCover, tsCylinder, tsArrow, tsCone, tsPyramid, tsSlantCube, tsVisual };

enum DECLSPEC_DENUM TTowerStacked : unsigned char { tsNone, tsStacked, tsStacked100 };

struct DECLSPEC_DRECORD TTowerPosition
{
public:
	int Y;
	Vcltee::Teengine::TChartSeries* Tower;
};


typedef System::DynamicArray<TTowerPosition> TTowerPositions;

class PASCALIMPLEMENTATION TTowerSeries : public TCustom3DGridSeries
{
	typedef TCustom3DGridSeries inherited;
	
private:
	bool FDark3D;
	double FOrigin;
	int FPercDepth;
	int FPercWidth;
	TTowerStacked FStacked;
	TTowerStyle FTowerStyle;
	bool FUseOrigin;
	double IOffW;
	double IOffD;
	Vcltee::Tecanvas::TTeeBlend* IBlend;
	bool IChangeBrush;
	bool IFirstIndex;
	TTowerPositions ISorted;
	System::Types::TRect __fastcall CalcCell(int AIndex, /* out */ int &ATop, /* out */ int &ABottom, /* out */ int &Z0, /* out */ int &Z1);
	int __fastcall DoCompare(int a, int b);
	void __fastcall DoDrawCell(int x, int z);
	void __fastcall DoSwap(int a, int b);
	int __fastcall GetOriginPos(int ValueIndex);
	double __fastcall MaxMandatoryValue(const double Value);
	double __fastcall MinMandatoryValue(const double Value);
	double __fastcall PointOrigin(int ValueIndex, bool SumAll);
	void __fastcall SetDark3D(const bool Value);
	void __fastcall SetOrigin(const double Value);
	void __fastcall SetOtherTowers();
	void __fastcall SetPercDepth(const int Value);
	void __fastcall SetPercWidth(const int Value);
	void __fastcall SetStacked(const TTowerStacked Value);
	void __fastcall SetTowerStyle(const TTowerStyle Value);
	void __fastcall SetUseOrigin(bool Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TTowerSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall MinZValue();
	virtual double __fastcall MaxZValue();
	
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
	__property bool Dark3D = {read=FDark3D, write=SetDark3D, default=1};
	__property int PercentDepth = {read=FPercDepth, write=SetPercDepth, default=100};
	__property double Origin = {read=FOrigin, write=SetOrigin};
	__property TTowerStacked Stacked = {read=FStacked, write=SetStacked, default=0};
	__property TTowerStyle TowerStyle = {read=FTowerStyle, write=SetTowerStyle, default=0};
	__property Transparency = {default=0};
	__property int PercentWidth = {read=FPercWidth, write=SetPercWidth, default=100};
	__property bool UseOrigin = {read=FUseOrigin, write=SetUseOrigin, default=0};
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
	__property Brush;
	__property EndColor = {default=16777215};
	__property IrregularGrid = {default=0};
	__property MidColor = {default=536870911};
	__property NumXValues = {default=10};
	__property NumZValues = {default=10};
	__property LegendEvery = {default=1};
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
	__property XValues;
	__property YValues;
	__property ZValues;
	__property OnGetYValue;
	__property OnGetColor;
public:
	/* TCustom3DPaletteSeries.Destroy */ inline __fastcall virtual ~TTowerSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TSurfaceSides : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FLevels;
	Vcltee::Tecanvas::TTeeHiddenPen* FPen;
	TSurfaceSeries* ISeries;
	void __fastcall CanvasChanged(System::TObject* Sender);
	Vcltee::Tecanvas::TTeeBrush* __fastcall GetBrush();
	void __fastcall SetBrush(Vcltee::Tecanvas::TTeeBrush* const Value);
	void __fastcall SetLevels(const bool Value);
	void __fastcall SetPen(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	
public:
	__fastcall TSurfaceSides(TSurfaceSeries* const Series);
	__fastcall virtual ~TSurfaceSides();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Tecanvas::TTeeBrush* Brush = {read=GetBrush, write=SetBrush};
	__property bool Levels = {read=FLevels, write=SetLevels, default=1};
	__property Vcltee::Tecanvas::TTeeHiddenPen* Pen = {read=FPen, write=SetPen};
};


class PASCALIMPLEMENTATION TIsoSurfaceSeries : public TSurfaceSeries
{
	typedef TSurfaceSeries inherited;
	
private:
	Vcltee::Tecanvas::TTeePen* FBandPen;
	TSurfaceSides* FSides;
	bool FUseY;
	double FYPosition;
	Vcltee::Teengine::TChartValues xv;
	Vcltee::Teengine::TChartValues zv;
	Vcltee::Teengine::TChartValues v;
	bool HasImage;
	bool ITransp;
	int PaletteLength;
	Vcltee::Tecanvas::TPointArray IPoints2D;
	int ICalcYPos;
	bool INoFixAlign;
	System::TObject* IDifs;
	double ILevelValue;
	void __fastcall DrawSegmentLine(const TLevelPoint &A, const TLevelPoint &B);
	void __fastcall FillSegment2D(const TLevelPoint3D *P, const int P_High);
	void __fastcall FillSegment3D(const TLevelPoint3D *P, const int P_High);
	void __fastcall SetBandPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetSides(TSurfaceSides* const Value);
	void __fastcall SetUseY(const bool Value);
	void __fastcall SetYPosition(const double Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual System::Types::TPoint __fastcall CalcXYPoint(const TLevelPoint3D &P);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawCell(int x, int z);
	virtual void __fastcall DrawSidePortion(Vcltee::Tecanvas::TFourPoints &P, int Z0, int Z1);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareCalcPos();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual bool __fastcall ShouldDrawFast();
	virtual bool __fastcall ShouldDrawSides();
	
public:
	__fastcall virtual TIsoSurfaceSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TIsoSurfaceSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual double __fastcall MinYValue();
	virtual double __fastcall MaxYValue();
	
__published:
	__property Vcltee::Tecanvas::TTeePen* BandPen = {read=FBandPen, write=SetBandPen};
	__property TSurfaceSides* Sides = {read=FSides, write=SetSides};
	__property UseColorRange = {default=0};
	__property UsePalette = {default=1};
	__property bool UseYPosition = {read=FUseY, write=SetUseY, default=0};
	__property double YPosition = {read=FYPosition, write=SetYPosition};
};


class PASCALIMPLEMENTATION TSeriesColorPalette : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Vcltee::Chart::TCustomChart* IChart;
	System::Uitypes::TColor __fastcall GetEndColor();
	int __fastcall GetLegendEvery();
	System::Uitypes::TColor __fastcall GetMidColor();
	TCustom3DPalette __fastcall GetPalette();
	double __fastcall GetPaletteMin();
	double __fastcall GetPaletteStep();
	int __fastcall GetPaletteSteps();
	TTeePaletteStyle __fastcall GetPaletteStyle();
	System::Uitypes::TColor __fastcall GetStartColor();
	bool __fastcall GetUseColorRange();
	bool __fastcall GetUsePalette();
	bool __fastcall GetUsePaletteMin();
	void __fastcall SetEndColor(const System::Uitypes::TColor Value);
	void __fastcall SetLegendEvery(const int Value);
	void __fastcall SetMidColor(const System::Uitypes::TColor Value);
	void __fastcall SetPalette(const TCustom3DPalette Value);
	void __fastcall SetPaletteMin(const double Value);
	void __fastcall SetPaletteStep(const double Value);
	void __fastcall SetPaletteSteps(const int Value);
	void __fastcall SetPaletteStyle(const TTeePaletteStyle Value);
	void __fastcall SetStartColor(const System::Uitypes::TColor Value);
	void __fastcall SetUseColorRange(const bool Value);
	void __fastcall SetUsePalette(const bool Value);
	void __fastcall SetUsePaletteMin(const bool Value);
	
public:
	TCustom3DPaletteSeries* Series;
	__fastcall TSeriesColorPalette(Vcltee::Teengine::TChartSeries* const AOwner);
	__fastcall virtual ~TSeriesColorPalette();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall InitColors(System::Uitypes::TColor Color, const double MinValue, const double MaxValue);
	__property TCustom3DPalette Palette = {read=GetPalette, write=SetPalette};
	
__published:
	__property System::Uitypes::TColor EndColor = {read=GetEndColor, write=SetEndColor, default=16777215};
	__property System::Uitypes::TColor MidColor = {read=GetMidColor, write=SetMidColor, default=536870911};
	__property int LegendEvery = {read=GetLegendEvery, write=SetLegendEvery, default=1};
	__property double PaletteMin = {read=GetPaletteMin, write=SetPaletteMin};
	__property double PaletteStep = {read=GetPaletteStep, write=SetPaletteStep};
	__property int PaletteSteps = {read=GetPaletteSteps, write=SetPaletteSteps, default=32};
	__property TTeePaletteStyle PaletteStyle = {read=GetPaletteStyle, write=SetPaletteStyle, default=0};
	__property System::Uitypes::TColor StartColor = {read=GetStartColor, write=SetStartColor, default=8388608};
	__property bool UseColorRange = {read=GetUseColorRange, write=SetUseColorRange, default=1};
	__property bool UsePalette = {read=GetUsePalette, write=SetUsePalette, default=0};
	__property bool UsePaletteMin = {read=GetUsePaletteMin, write=SetUsePaletteMin, default=0};
};


class PASCALIMPLEMENTATION TBubbleCloudSeries : public TCustom3DPaletteSeries
{
	typedef TCustom3DPaletteSeries inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TPoint> _TBubbleCloudSeries__1;
	
	typedef System::DynamicArray<int> _TBubbleCloudSeries__2;
	
	
private:
	int FRotation;
	int FSeparation;
	Vcltee::Teeprocs::TTeeUnits FSeparationUnits;
	double FSizeRatio;
	_TBubbleCloudSeries__1 ICenters;
	_TBubbleCloudSeries__2 ITangents;
	System::Types::TPoint IOffset;
	System::Types::TRect IBounds;
	System::Types::TRect IRect;
	float IScale;
	bool __fastcall IsSizeRatioStored();
	void __fastcall SetRotation(const int Value);
	void __fastcall SetSizeRatio(const double Value);
	void __fastcall SetSeparation(const int Value);
	void __fastcall SetSeparationUnits(const Vcltee::Teeprocs::TTeeUnits Value);
	
protected:
	System::Types::TRect __fastcall BubbleRect(int ValueIndex);
	double __fastcall Distance(int A, int B);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TBubbleCloudSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	virtual void __fastcall DrawValue(int ValueIndex);
	double __fastcall Radius(int ValueIndex);
	virtual bool __fastcall UseAxis();
	
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
	__property Brush;
	__property EndColor = {default=16777215};
	__property MidColor = {default=536870911};
	__property LegendEvery = {default=1};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property StartColor = {default=8388608};
	__property UseColorRange = {default=1};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property XValues;
	__property YValues;
	__property int Rotation = {read=FRotation, write=SetRotation, default=0};
	__property int Separation = {read=FSeparation, write=SetSeparation, default=0};
	__property Vcltee::Teeprocs::TTeeUnits SeparationUnits = {read=FSeparationUnits, write=SetSeparationUnits, default=0};
	__property double SizeRatio = {read=FSizeRatio, write=SetSizeRatio, stored=IsSizeRatioStored};
public:
	/* TCustom3DPaletteSeries.Destroy */ inline __fastcall virtual ~TBubbleCloudSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesurfa */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESURFA)
using namespace Vcltee::Teesurfa;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesurfaHPP
