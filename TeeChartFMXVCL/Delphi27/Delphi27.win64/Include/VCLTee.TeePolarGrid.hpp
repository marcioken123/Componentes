// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePolarGrid.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepolargridHPP
#define Vcltee_TeepolargridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeePolar.hpp>
#include <VCLTee.TeeSurfa.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepolargrid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarGridSeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TPolarGridStyle : unsigned char { gsSquared, gsCircled };

class PASCALIMPLEMENTATION TPolarGridSeries : public Vcltee::Teepolar::TCustomPolarSeries
{
	typedef Vcltee::Teepolar::TCustomPolarSeries inherited;
	
private:
	bool FCentered;
	TPolarGridStyle FGridStyle;
	int FNumSectors;
	int FNumTracks;
	Vcltee::Teesurfa::TSeriesColorPalette* FPalette;
	Vcltee::Teengine::TChartValueList* FValues;
	void __fastcall DrawCell(int ValueIndex, const bool UsePen);
	double __fastcall InternalX(const double Value);
	void __fastcall SetCentered(const bool Value);
	void __fastcall SetGridStyle(const TPolarGridStyle Value);
	void __fastcall SetPalette(Vcltee::Teesurfa::TSeriesColorPalette* const Value);
	void __fastcall SetValues(Vcltee::Teengine::TChartValueList* const Value);
	double __fastcall GetCell(int Sector, int Track);
	void __fastcall SetCell(int Sector, int Track, const double Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	void __fastcall CellPolygon(int ValueIndex, /* out */ Vcltee::Tecanvas::TFourPoints &P);
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
	System::Uitypes::TColor __fastcall GetCellColor(const double Value);
	DYNAMIC bool __fastcall IsValidSourceOf(Vcltee::Teengine::TChartSeries* Value);
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	void __fastcall PositionOf(const int ValueIndex, /* out */ int &Sector, /* out */ int &Track);
	__property double Cell[int Sector][int Track] = {read=GetCell, write=SetCell};
	
__published:
	__property Vcltee::Teengine::TChartValueList* CellValues = {read=FValues, write=SetValues};
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
	__property CircleBackColor = {default=536870912};
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
	__property Vcltee::Teesurfa::TSeriesColorPalette* Palette = {read=FPalette, write=SetPalette};
	__property Pen;
	__property RadiusIncrement = {default=0};
	__property RadiusValues;
	__property RotationAngle = {default=90};
	__property Transparency = {default=0};
	__property TreatNulls = {default=0};
	__property OnGetCircleLabel;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepolargrid */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOLARGRID)
using namespace Vcltee::Teepolargrid;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepolargridHPP
