// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.SeriesRegion.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_SeriesregionHPP
#define Fmxtee_Tools_SeriesregionHPP

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
#include <System.UIConsts.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Seriesregion
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesRegionTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesRegionTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	bool FAutoBounds;
	bool FDrawBehindSeries;
	double FLowerBound;
	double FOrigin;
	Fmxtee::Canvas::TTeeHiddenPen* FOriginPen;
	Fmxtee::Canvas::TTeeTransparency FTransparency;
	double FUpperBound;
	bool FUseOrigin;
	bool ISeriesDrawn;
	System::Uitypes::TAlphaColor __fastcall GetColor();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	int __fastcall IntersectionPoint(const double Value, /* out */ double &y);
	void __fastcall SetAutoBounds(const bool Value);
	void __fastcall SetColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetDrawBehindSeries(const bool Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetLowerBound(const double Value);
	void __fastcall SetOrigin(const double Value);
	void __fastcall SetOriginPen(Fmxtee::Canvas::TTeeHiddenPen* const Value);
	void __fastcall SetTransparency(const Fmxtee::Canvas::TTeeTransparency Value);
	void __fastcall SetUpperBound(const double Value);
	void __fastcall SetUseOrigin(const bool Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall DrawRegion();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SeriesEvent(Fmxtee::Engine::TChartToolEvent AEvent, Fmxtee::Engine::TChartSeries* ASeries);
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
public:
	__fastcall virtual TSeriesRegionTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSeriesRegionTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property bool AutoBounds = {read=FAutoBounds, write=SetAutoBounds, default=1};
	__property bool DrawBehindSeries = {read=FDrawBehindSeries, write=SetDrawBehindSeries, default=1};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property double LowerBound = {read=FLowerBound, write=SetLowerBound};
	__property double Origin = {read=FOrigin, write=SetOrigin};
	__property Fmxtee::Canvas::TTeeHiddenPen* OriginPen = {read=FOriginPen, write=SetOriginPen};
	__property double UpperBound = {read=FUpperBound, write=SetUpperBound};
	__property bool UseOrigin = {read=FUseOrigin, write=SetUseOrigin, default=1};
	__property Active = {default=1};
	__property Brush;
	__property System::Uitypes::TAlphaColor Color = {read=GetColor, write=SetColor, default=-1};
	__property Pen;
	__property Series;
	__property Fmxtee::Canvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Seriesregion */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_SERIESREGION)
using namespace Fmxtee::Tools::Seriesregion;
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
#endif	// Fmxtee_Tools_SeriesregionHPP
