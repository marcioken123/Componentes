// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.SeriesBand.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_SeriesbandHPP
#define Fmxtee_Tools_SeriesbandHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Constants.hpp>
#include <FMXTee.ProConstants.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Seriesband
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesBandTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TBandCondition : unsigned char { bcAll, bcLower, bcHigher };

class PASCALIMPLEMENTATION TSeriesBandTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	double FBoundValue;
	TBandCondition FCondition;
	bool FDrawBehind;
	Fmxtee::Engine::TChartSeries* FSeries2;
	Fmxtee::Canvas::TTeeTransparency FTransparency;
	bool ISerie1Drawed;
	bool ISerie2Drawed;
	bool IPaintedBand;
	void __fastcall AfterSeriesDraw(System::TObject* Sender);
	void __fastcall BeforeSeriesDraw(System::TObject* Sender);
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetDrawBehind(const bool Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetTransparency(const Fmxtee::Canvas::TTeeTransparency Value);
	void __fastcall SetBoundValue(const double Value);
	void __fastcall SetCondition(const TBandCondition Value);
	void __fastcall TryToPaint(System::TObject* Sender);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SeriesEvent(Fmxtee::Engine::TChartToolEvent AEvent, Fmxtee::Engine::TChartSeries* ASeries);
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	virtual void __fastcall SetSeries2(Fmxtee::Engine::TChartSeries* const Value);
	virtual void __fastcall DrawBandTool();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TSeriesBandTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property double BoundValue = {read=FBoundValue, write=SetBoundValue};
	__property Brush;
	__property TBandCondition Condition = {read=FCondition, write=SetCondition, default=0};
	__property bool DrawBehindSeries = {read=FDrawBehind, write=SetDrawBehind, default=1};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Pen;
	__property Series;
	__property Fmxtee::Engine::TChartSeries* Series2 = {read=FSeries2, write=SetSeries2};
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TSeriesBandTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Seriesband */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_SERIESBAND)
using namespace Fmxtee::Tools::Seriesband;
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
#endif	// Fmxtee_Tools_SeriesbandHPP
