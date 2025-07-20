// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.PolarGrid.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Series_PolargridHPP
#define Fmxtee_Series_PolargridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Polar.hpp>
#include <FMXTee.Series.Surface.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Polargrid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarGridSeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TPolarGridStyle : unsigned char { gsSquared, gsCircled };

class PASCALIMPLEMENTATION TPolarGridSeries : public Fmxtee::Series::Polar::TCustomPolarSeries
{
	typedef Fmxtee::Series::Polar::TCustomPolarSeries inherited;
	
private:
	bool FCentered;
	TPolarGridStyle FGridStyle;
	int FNumSectors;
	int FNumTracks;
	Fmxtee::Series::Surface::TSeriesColorPalette* FPalette;
	Fmxtee::Engine::TChartValueList* FValues;
	void __fastcall DrawCell(int ValueIndex, const bool UsePen);
	double __fastcall InternalX(const double Value);
	void __fastcall SetCentered(const bool Value);
	void __fastcall SetGridStyle(const TPolarGridStyle Value);
	void __fastcall SetPalette(Fmxtee::Series::Surface::TSeriesColorPalette* const Value);
	void __fastcall SetValues(Fmxtee::Engine::TChartValueList* const Value);
	double __fastcall GetCell(int Sector, int Track);
	void __fastcall SetCell(int Sector, int Track, const double Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	HIDESBASE void __fastcall CalcXYPosition(const double XValue, const double YValue, int ARadius, /* out */ float &X, /* out */ float &Y)/* overload */;
	void __fastcall CellPolygon(int ValueIndex, /* out */ Fmxtee::Canvas::TFourPoints &P);
	virtual void __fastcall DoAfterDrawValues();
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawPolarCircle(int HalfWidth, int HalfHeight, int Z);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual System::UnicodeString __fastcall GetCircleLabel(const double Angle, int Index);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TPolarGridSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPolarGridSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	int __fastcall AddCell(const int Sector, const int Track, const double Value);
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	virtual int __fastcall CountLegendItems();
	System::Uitypes::TAlphaColor __fastcall GetCellColor(const double Value);
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Fmxtee::Engine::TLegendTextStyle LegendTextStyle);
	void __fastcall PositionOf(const int ValueIndex, /* out */ int &Sector, /* out */ int &Track);
	__property double Cell[int Sector][int Track] = {read=GetCell, write=SetCell};
	
__published:
	__property Fmxtee::Engine::TChartValueList* CellValues = {read=FValues, write=SetValues};
	__property bool Centered = {read=FCentered, write=SetCentered, default=1};
	__property int NumSectors = {read=FNumSectors, write=FNumSectors, default=10};
	__property int NumTracks = {read=FNumTracks, write=FNumTracks, default=10};
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
	__property HorizAxis = {default=1};
	__property SeriesColor;
	__property VertAxis = {default=0};
	__property AngleIncrement = {default=0};
	__property AngleValues;
	__property Brush;
	__property CircleBackColor = {default=16777215};
	__property CircleGradient;
	__property AngleLabels;
	__property CircleLabels;
	__property CircleLabelsFont;
	__property CircleLabelsInside;
	__property CircleLabelsRotated;
	__property ClockWiseLabels;
	__property LabelsMargin;
	__property CirclePen;
	__property TPolarGridStyle GridStyle = {read=FGridStyle, write=SetGridStyle, default=0};
	__property Labels;
	__property Fmxtee::Series::Surface::TSeriesColorPalette* Palette = {read=FPalette, write=SetPalette};
	__property Pen;
	__property RadiusIncrement = {default=0};
	__property RadiusValues;
	__property RotationAngle = {default=90};
	__property Transparency = {default=0};
	__property TreatNulls = {default=0};
	__property OnGetCircleLabel;
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  CalcXYPosition(const double XValue, const double YValue, int ARadius, /* out */ int &X, /* out */ int &Y){ Fmxtee::Series::Polar::TCustomPolarSeries::CalcXYPosition(XValue, YValue, ARadius, X, Y); }
	inline void __fastcall  CalcXYPosition(const double XValue, const double YValue, int ARadius, Fmxtee::Engine::TChartAxis* Axis, /* out */ int &X, /* out */ int &Y){ Fmxtee::Series::Polar::TCustomPolarSeries::CalcXYPosition(XValue, YValue, ARadius, Axis, X, Y); }
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Polargrid */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_POLARGRID)
using namespace Fmxtee::Series::Polargrid;
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
#endif	// Fmxtee_Series_PolargridHPP
