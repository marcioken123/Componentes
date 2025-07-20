// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.ScrollPager.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_ScrollpagerHPP
#define Fmxtee_Tools_ScrollpagerHPP

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
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMXTee.Tools.SubChart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Scrollpager
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeSubChartAccess;
class DELPHICLASS TTeeColorLineAccess;
class DELPHICLASS TScrollPagerPointer;
class DELPHICLASS TScrollPagerTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeSubChartAccess : public Fmxtee::Tools::Subchart::TSubChartTool
{
	typedef Fmxtee::Tools::Subchart::TSubChartTool inherited;
	
public:
	/* TSubChartTool.Create */ inline __fastcall virtual TTeeSubChartAccess(System::Classes::TComponent* AOwner) : Fmxtee::Tools::Subchart::TSubChartTool(AOwner) { }
	/* TSubChartTool.Destroy */ inline __fastcall virtual ~TTeeSubChartAccess() { }
	
};


class PASCALIMPLEMENTATION TTeeColorLineAccess : public Fmxtee::Tools::TColorLineTool
{
	typedef Fmxtee::Tools::TColorLineTool inherited;
	
public:
	/* TColorLineTool.Create */ inline __fastcall virtual TTeeColorLineAccess(System::Classes::TComponent* AOwner) : Fmxtee::Tools::TColorLineTool(AOwner) { }
	
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TTeeColorLineAccess() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TScrollPagerPointer : public Fmxtee::Engine::TSeriesPointer
{
	typedef Fmxtee::Engine::TSeriesPointer inherited;
	
private:
	System::Uitypes::TAlphaColor FOldColor;
	bool FMouseIn;
	bool FOldColorSaved;
public:
	/* TSeriesPointer.Create */ inline __fastcall TScrollPagerPointer(Fmxtee::Engine::TChartSeries* const AOwner) : Fmxtee::Engine::TSeriesPointer(AOwner) { }
	/* TSeriesPointer.Destroy */ inline __fastcall virtual ~TScrollPagerPointer() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TScrollPagerAlign : unsigned char { saAfter, saBefore, saCustom };

class PASCALIMPLEMENTATION TScrollPagerTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	TScrollPagerAlign FAlign;
	double FDivisionRatio;
	bool FStartPointerClicked;
	bool FEndPointerClicked;
	TScrollPagerPointer* FStartPointer;
	TScrollPagerPointer* FEndPointer;
	System::Uitypes::TAlphaColor FPointHLColor;
	Fmxtee::Tools::Subchart::TSubChartTool* FSubChartTool;
	System::Classes::TNotifyEvent FScrolled;
	void __fastcall ColorBandChanged(System::TObject* Sender);
	Fmxtee::Tools::TColorBandTool* __fastcall CreateColorBand();
	Fmxtee::Tools::TColorBandTool* __fastcall GetColorBandTool();
	Fmxtee::Engine::TSeriesPointer* __fastcall GetEndLinePointer();
	bool __fastcall GetNoLimitDrag();
	Fmxtee::Engine::TSeriesPointer* __fastcall GetStartLinePointer();
	Fmxtee::Chart::TChart* __fastcall GetSubChartTChart();
	Fmxtee::Tools::Subchart::TSubChartTool* __fastcall GetSubChartTool();
	void __fastcall HookColorBand(Fmxtee::Tools::TColorBandTool* const ABand);
	void __fastcall HookSubChart(Fmxtee::Chart::TCustomChart* const AChart);
	Fmxtee::Engine::TChartAxis* __fastcall ParentNotMandatoryAxis();
	void __fastcall ResetZoomPanning();
	Fmxtee::Engine::TChartSeries* __fastcall SeriesLinkExists(Fmxtee::Engine::TChartSeries* const ASeries);
	bool __fastcall SeriesPointerClick(int X, int Y, Fmxtee::Engine::TSeriesPointer* const Point, bool Start);
	void __fastcall SetAlign(const TScrollPagerAlign Value);
	void __fastcall SetDivisionRatio(const double Value);
	void __fastcall SetNoLimitDrag(const bool Value);
	void __fastcall SetUpChartLayout();
	void __fastcall SetUpColorBand();
	void __fastcall SetupSeries(Fmxtee::Engine::TChartSeries* const Value);
	void __fastcall SetPointerHighlightColor(System::Uitypes::TAlphaColor Value);
	void __fastcall SubChartTChart_AfterDraw(System::TObject* Sender);
	void __fastcall SubChartTChart_MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall SubChartTChart_MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	void __fastcall SubChartTChart_MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, float X, float Y);
	Fmxtee::Engine::TChartAxis* __fastcall SubChartNotMandatoryAxis();
	Fmxtee::Engine::TChartSeries* __fastcall SubChartSeries();
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	void __fastcall DoScrolled();
	
public:
	__fastcall virtual TScrollPagerTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TScrollPagerTool();
	void __fastcall AddSeries(Fmxtee::Engine::TChartSeries* const ASeries);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall RemoveSeries(Fmxtee::Engine::TChartSeries* const ASeries);
	void __fastcall SetUpScrollPager();
	
__published:
	__property TScrollPagerAlign Align = {read=FAlign, write=SetAlign, default=0};
	__property Fmxtee::Tools::TColorBandTool* ColorBandTool = {read=GetColorBandTool};
	__property double DivisionRatio = {read=FDivisionRatio, write=SetDivisionRatio};
	__property Fmxtee::Engine::TSeriesPointer* EndLinePointer = {read=GetEndLinePointer};
	__property bool NoLimitDrag = {read=GetNoLimitDrag, write=SetNoLimitDrag, default=1};
	__property System::Uitypes::TAlphaColor PointerHighlightColor = {read=FPointHLColor, write=SetPointerHighlightColor, default=-65536};
	__property Series;
	__property Fmxtee::Engine::TSeriesPointer* StartLinePointer = {read=GetStartLinePointer};
	__property Fmxtee::Chart::TChart* SubChartTChart = {read=GetSubChartTChart};
	__property Fmxtee::Tools::Subchart::TSubChartTool* SubChartTool = {read=GetSubChartTool};
	__property System::Classes::TNotifyEvent OnScrolled = {read=FScrolled, write=FScrolled};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Scrollpager */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_SCROLLPAGER)
using namespace Fmxtee::Tools::Scrollpager;
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
#endif	// Fmxtee_Tools_ScrollpagerHPP
