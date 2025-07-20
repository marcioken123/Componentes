// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLegendPalette.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelegendpaletteHPP
#define Vcltee_TeelegendpaletteHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeSurfa.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelegendpalette
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLegendPointer;
class DELPHICLASS TLegendPaletteTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLegendPointer : public Vcltee::Teengine::TSeriesPointer
{
	typedef Vcltee::Teengine::TSeriesPointer inherited;
	
private:
	double FValue;
	void __fastcall SetValue(const double AValue);
	
__published:
	__property double Value = {read=FValue, write=SetValue};
public:
	/* TSeriesPointer.Create */ inline __fastcall TLegendPointer(Vcltee::Teengine::TChartSeries* const AOwner) : Vcltee::Teengine::TSeriesPointer(AOwner) { }
	/* TSeriesPointer.Destroy */ inline __fastcall virtual ~TLegendPointer() { }
	
};


enum DECLSPEC_DENUM TLegendPaletteAxis : unsigned char { laDefault, laOther, laBoth };

class PASCALIMPLEMENTATION TLegendPaletteTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	Vcltee::Chart::TCustomChart* FChart;
	int FHeight;
	int FLeft;
	TLegendPointer* FPointer;
	Vcltee::Teeprocs::TTeeUnits FPositionUnits;
	bool FSmooth;
	int FTop;
	bool FVertical;
	int FWidth;
	TLegendPaletteAxis __fastcall GetAxis();
	Vcltee::Tecanvas::TTeeHiddenPen* __fastcall GetBorder();
	System::Uitypes::TColor __fastcall GetColor();
	Vcltee::Tecanvas::TTeeEmboss* __fastcall GetEmboss();
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	bool __fastcall GetInverted();
	Vcltee::Tecanvas::TTeeShadow* __fastcall GetShadow();
	Vcltee::Chart::TChartTitle* __fastcall GetTitle();
	bool __fastcall GetTransp();
	void __fastcall SetAxis(const TLegendPaletteAxis Value);
	void __fastcall SetBorder(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetEmboss(Vcltee::Tecanvas::TTeeEmboss* const Value);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetInverted(const bool Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetPositionUnits(const Vcltee::Teeprocs::TTeeUnits Value);
	void __fastcall SetShadow(Vcltee::Tecanvas::TTeeShadow* const Value);
	void __fastcall SetSmooth(const bool Value);
	void __fastcall SetTitle(Vcltee::Chart::TChartTitle* const Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetTransp(const bool Value);
	void __fastcall SetVertical(const bool Value);
	void __fastcall SetWidth(const int Value);
	TLegendPointer* __fastcall GetPointer();
	Vcltee::Chart::TChartTitle* __fastcall GetFoot();
	Vcltee::Chart::TChartTitle* __fastcall GetSubFoot();
	Vcltee::Chart::TChartTitle* __fastcall GetSubTitle();
	void __fastcall SetFoot(Vcltee::Chart::TChartTitle* const Value);
	void __fastcall SetSubFoot(Vcltee::Chart::TChartTitle* const Value);
	void __fastcall SetSubTitle(Vcltee::Chart::TChartTitle* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	
public:
	__fastcall virtual TLegendPaletteTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLegendPaletteTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Vcltee::Chart::TCustomChart* Chart = {read=FChart};
	__property TLegendPointer* Pointer = {read=GetPointer};
	
__published:
	__property Active = {default=1};
	__property TLegendPaletteAxis Axis = {read=GetAxis, write=SetAxis, default=2};
	__property Vcltee::Tecanvas::TTeeHiddenPen* Border = {read=GetBorder, write=SetBorder};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=16777215};
	__property Vcltee::Tecanvas::TTeeEmboss* Emboss = {read=GetEmboss, write=SetEmboss};
	__property Vcltee::Chart::TChartTitle* Foot = {read=GetFoot, write=SetFoot};
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property int Height = {read=FHeight, write=SetHeight, default=200};
	__property bool Inverted = {read=GetInverted, write=SetInverted, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=10};
	__property Pen;
	__property Vcltee::Teeprocs::TTeeUnits PositionUnits = {read=FPositionUnits, write=SetPositionUnits, default=1};
	__property Series;
	__property Vcltee::Tecanvas::TTeeShadow* Shadow = {read=GetShadow, write=SetShadow};
	__property bool Smooth = {read=FSmooth, write=SetSmooth, default=0};
	__property Vcltee::Chart::TChartTitle* SubFoot = {read=GetSubFoot, write=SetSubFoot};
	__property Vcltee::Chart::TChartTitle* SubTitle = {read=GetSubTitle, write=SetSubTitle};
	__property Vcltee::Chart::TChartTitle* Title = {read=GetTitle, write=SetTitle};
	__property int Top = {read=FTop, write=SetTop, default=10};
	__property bool Transparent = {read=GetTransp, write=SetTransp, default=0};
	__property bool Vertical = {read=FVertical, write=SetVertical, default=1};
	__property int Width = {read=FWidth, write=SetWidth, default=100};
};


//-- var, const, procedure ---------------------------------------------------
static const int DefaultPanelColor = int(16777215);
}	/* namespace Teelegendpalette */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELEGENDPALETTE)
using namespace Vcltee::Teelegendpalette;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelegendpaletteHPP
