// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.LegendPalette.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_LegendpaletteHPP
#define Fmxtee_Tools_LegendpaletteHPP

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
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Series.Surface.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Legendpalette
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLegendPointer;
class DELPHICLASS TLegendPaletteTool;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLegendPointer : public Fmxtee::Engine::TSeriesPointer
{
	typedef Fmxtee::Engine::TSeriesPointer inherited;
	
private:
	double FValue;
	void __fastcall SetValue(const double AValue);
	
__published:
	__property double Value = {read=FValue, write=SetValue};
public:
	/* TSeriesPointer.Create */ inline __fastcall TLegendPointer(Fmxtee::Engine::TChartSeries* const AOwner) : Fmxtee::Engine::TSeriesPointer(AOwner) { }
	/* TSeriesPointer.Destroy */ inline __fastcall virtual ~TLegendPointer() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLegendPaletteAxis : unsigned char { laDefault, laOther, laBoth };

class PASCALIMPLEMENTATION TLegendPaletteTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	Fmxtee::Chart::TCustomChart* FChart;
	int FHeight;
	int FLeft;
	TLegendPointer* FPointer;
	Fmxtee::Procs::TTeeUnits FPositionUnits;
	bool FSmooth;
	int FTop;
	bool FVertical;
	int FWidth;
	TLegendPaletteAxis __fastcall GetAxis();
	Fmxtee::Canvas::TTeeHiddenPen* __fastcall GetBorder();
	System::Uitypes::TAlphaColor __fastcall GetColor();
	Fmxtee::Canvas::TTeeEmboss* __fastcall GetEmboss();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	bool __fastcall GetInverted();
	Fmxtee::Canvas::TTeeShadow* __fastcall GetShadow();
	Fmxtee::Chart::TChartTitle* __fastcall GetTitle();
	bool __fastcall GetTransp();
	void __fastcall SetAxis(const TLegendPaletteAxis Value);
	void __fastcall SetBorder(Fmxtee::Canvas::TTeeHiddenPen* const Value);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetEmboss(Fmxtee::Canvas::TTeeEmboss* const Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetInverted(const bool Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetPositionUnits(const Fmxtee::Procs::TTeeUnits Value);
	void __fastcall SetShadow(Fmxtee::Canvas::TTeeShadow* const Value);
	void __fastcall SetSmooth(const bool Value);
	void __fastcall SetTitle(Fmxtee::Chart::TChartTitle* const Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetTransp(const bool Value);
	void __fastcall SetVertical(const bool Value);
	void __fastcall SetWidth(const int Value);
	TLegendPointer* __fastcall GetPointer();
	Fmxtee::Chart::TChartTitle* __fastcall GetFoot();
	Fmxtee::Chart::TChartTitle* __fastcall GetSubFoot();
	Fmxtee::Chart::TChartTitle* __fastcall GetSubTitle();
	void __fastcall SetFoot(Fmxtee::Chart::TChartTitle* const Value);
	void __fastcall SetSubFoot(Fmxtee::Chart::TChartTitle* const Value);
	void __fastcall SetSubTitle(Fmxtee::Chart::TChartTitle* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
public:
	__fastcall virtual TLegendPaletteTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLegendPaletteTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Fmxtee::Chart::TCustomChart* Chart = {read=FChart};
	__property TLegendPointer* Pointer = {read=GetPointer};
	
__published:
	__property Active = {default=1};
	__property TLegendPaletteAxis Axis = {read=GetAxis, write=SetAxis, default=2};
	__property Fmxtee::Canvas::TTeeHiddenPen* Border = {read=GetBorder, write=SetBorder};
	__property System::Uitypes::TAlphaColor Color = {read=GetColor, write=SetColor, default=-1};
	__property Fmxtee::Canvas::TTeeEmboss* Emboss = {read=GetEmboss, write=SetEmboss};
	__property Fmxtee::Chart::TChartTitle* Foot = {read=GetFoot, write=SetFoot};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property int Height = {read=FHeight, write=SetHeight, default=200};
	__property bool Inverted = {read=GetInverted, write=SetInverted, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=10};
	__property Pen;
	__property Fmxtee::Procs::TTeeUnits PositionUnits = {read=FPositionUnits, write=SetPositionUnits, default=1};
	__property Series;
	__property Fmxtee::Canvas::TTeeShadow* Shadow = {read=GetShadow, write=SetShadow};
	__property bool Smooth = {read=FSmooth, write=SetSmooth, default=0};
	__property Fmxtee::Chart::TChartTitle* SubFoot = {read=GetSubFoot, write=SetSubFoot};
	__property Fmxtee::Chart::TChartTitle* SubTitle = {read=GetSubTitle, write=SetSubTitle};
	__property Fmxtee::Chart::TChartTitle* Title = {read=GetTitle, write=SetTitle};
	__property int Top = {read=FTop, write=SetTop, default=10};
	__property bool Transparent = {read=GetTransp, write=SetTransp, default=0};
	__property bool Vertical = {read=FVertical, write=SetVertical, default=1};
	__property int Width = {read=FWidth, write=SetWidth, default=100};
};


//-- var, const, procedure ---------------------------------------------------
static constexpr unsigned DefaultPanelColor = unsigned(0xffffffff);
}	/* namespace Legendpalette */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_LEGENDPALETTE)
using namespace Fmxtee::Tools::Legendpalette;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_LegendpaletteHPP
