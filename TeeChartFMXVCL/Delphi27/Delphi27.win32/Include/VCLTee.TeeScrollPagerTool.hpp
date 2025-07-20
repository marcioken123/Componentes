// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeScrollPagerTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeescrollpagertoolHPP
#define Vcltee_TeescrollpagertoolHPP

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
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeSubChart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teescrollpagertool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeSubChartAccess;
class DELPHICLASS TTeeColorLineAccess;
class DELPHICLASS TScrollPagerPointer;
class DELPHICLASS TScrollPagerTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeSubChartAccess : public Vcltee::Teesubchart::TSubChartTool
{
	typedef Vcltee::Teesubchart::TSubChartTool inherited;
	
public:
	/* TSubChartTool.Create */ inline __fastcall virtual TTeeSubChartAccess(System::Classes::TComponent* AOwner) : Vcltee::Teesubchart::TSubChartTool(AOwner) { }
	/* TSubChartTool.Destroy */ inline __fastcall virtual ~TTeeSubChartAccess() { }
	
};


class PASCALIMPLEMENTATION TTeeColorLineAccess : public Vcltee::Teetools::TColorLineTool
{
	typedef Vcltee::Teetools::TColorLineTool inherited;
	
public:
	/* TColorLineTool.Create */ inline __fastcall virtual TTeeColorLineAccess(System::Classes::TComponent* AOwner) : Vcltee::Teetools::TColorLineTool(AOwner) { }
	
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TTeeColorLineAccess() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TScrollPagerPointer : public Vcltee::Teengine::TSeriesPointer
{
	typedef Vcltee::Teengine::TSeriesPointer inherited;
	
private:
	System::Uitypes::TColor FOldColor;
	bool FMouseIn;
	bool FOldColorSaved;
public:
	/* TSeriesPointer.Create */ inline __fastcall TScrollPagerPointer(Vcltee::Teengine::TChartSeries* const AOwner) : Vcltee::Teengine::TSeriesPointer(AOwner) { }
	/* TSeriesPointer.Destroy */ inline __fastcall virtual ~TScrollPagerPointer() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TScrollPagerAlign : unsigned char { saAfter, saBefore, saCustom };

class PASCALIMPLEMENTATION TScrollPagerTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	TScrollPagerAlign FAlign;
	double FDivisionRatio;
	bool FStartPointerClicked;
	bool FEndPointerClicked;
	TScrollPagerPointer* FStartPointer;
	TScrollPagerPointer* FEndPointer;
	System::Uitypes::TColor FPointHLColor;
	Vcltee::Teesubchart::TSubChartTool* FSubChartTool;
	System::Classes::TNotifyEvent FScrolled;
	void __fastcall ColorBandChanged(System::TObject* Sender);
	Vcltee::Teetools::TColorBandTool* __fastcall CreateColorBand();
	Vcltee::Teetools::TColorBandTool* __fastcall GetColorBandTool();
	Vcltee::Teengine::TSeriesPointer* __fastcall GetEndLinePointer();
	bool __fastcall GetNoLimitDrag();
	Vcltee::Teengine::TSeriesPointer* __fastcall GetStartLinePointer();
	Vcltee::Chart::TChart* __fastcall GetSubChartTChart();
	Vcltee::Teesubchart::TSubChartTool* __fastcall GetSubChartTool();
	void __fastcall HookColorBand(Vcltee::Teetools::TColorBandTool* const ABand);
	void __fastcall HookSubChart(Vcltee::Chart::TCustomChart* const AChart);
	Vcltee::Teengine::TChartAxis* __fastcall ParentNotMandatoryAxis();
	void __fastcall ResetZoomPanning();
	Vcltee::Teengine::TChartSeries* __fastcall SeriesLinkExists(Vcltee::Teengine::TChartSeries* const ASeries);
	bool __fastcall SeriesPointerClick(int X, int Y, Vcltee::Teengine::TSeriesPointer* const Point, bool Start);
	void __fastcall SetAlign(const TScrollPagerAlign Value);
	void __fastcall SetDivisionRatio(const double Value);
	void __fastcall SetNoLimitDrag(const bool Value);
	void __fastcall SetUpChartLayout();
	void __fastcall SetUpColorBand();
	void __fastcall SetupSeries(Vcltee::Teengine::TChartSeries* const Value);
	void __fastcall SetPointerHighlightColor(System::Uitypes::TColor Value);
	void __fastcall SubChartTChart_AfterDraw(System::TObject* Sender);
	void __fastcall SubChartTChart_MouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SubChartTChart_MouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SubChartTChart_MouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	Vcltee::Teengine::TChartAxis* __fastcall SubChartNotMandatoryAxis();
	Vcltee::Teengine::TChartSeries* __fastcall SubChartSeries();
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	void __fastcall DoScrolled();
	
public:
	__fastcall virtual TScrollPagerTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TScrollPagerTool();
	void __fastcall AddSeries(Vcltee::Teengine::TChartSeries* const ASeries);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall RemoveSeries(Vcltee::Teengine::TChartSeries* const ASeries);
	void __fastcall SetUpScrollPager();
	
__published:
	__property TScrollPagerAlign Align = {read=FAlign, write=SetAlign, default=0};
	__property Vcltee::Teetools::TColorBandTool* ColorBandTool = {read=GetColorBandTool};
	__property double DivisionRatio = {read=FDivisionRatio, write=SetDivisionRatio};
	__property Vcltee::Teengine::TSeriesPointer* EndLinePointer = {read=GetEndLinePointer};
	__property bool NoLimitDrag = {read=GetNoLimitDrag, write=SetNoLimitDrag, default=1};
	__property System::Uitypes::TColor PointerHighlightColor = {read=FPointHLColor, write=SetPointerHighlightColor, default=255};
	__property Series;
	__property Vcltee::Teengine::TSeriesPointer* StartLinePointer = {read=GetStartLinePointer};
	__property Vcltee::Chart::TChart* SubChartTChart = {read=GetSubChartTChart};
	__property Vcltee::Teesubchart::TSubChartTool* SubChartTool = {read=GetSubChartTool};
	__property System::Classes::TNotifyEvent OnScrolled = {read=FScrolled, write=FScrolled};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teescrollpagertool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESCROLLPAGERTOOL)
using namespace Vcltee::Teescrollpagertool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeescrollpagertoolHPP
