// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesRegion.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriesregionHPP
#define Vcltee_TeeseriesregionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriesregion
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesRegionTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesRegionTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	bool FAutoBounds;
	bool FDrawBehindSeries;
	double FLowerBound;
	double FOrigin;
	Vcltee::Tecanvas::TTeeHiddenPen* FOriginPen;
	Vcltee::Tecanvas::TTeeTransparency FTransparency;
	double FUpperBound;
	bool FUseOrigin;
	bool ISeriesDrawn;
	System::Uitypes::TColor __fastcall GetColor();
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	int __fastcall IntersectionPoint(const double Value, /* out */ double &y);
	void __fastcall SetAutoBounds(const bool Value);
	void __fastcall SetColor(const System::Uitypes::TColor Value);
	void __fastcall SetDrawBehindSeries(const bool Value);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetLowerBound(const double Value);
	void __fastcall SetOrigin(const double Value);
	void __fastcall SetOriginPen(Vcltee::Tecanvas::TTeeHiddenPen* const Value);
	void __fastcall SetTransparency(const Vcltee::Tecanvas::TTeeTransparency Value);
	void __fastcall SetUpperBound(const double Value);
	void __fastcall SetUseOrigin(const bool Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall DrawRegion();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SeriesEvent(Vcltee::Teengine::TChartToolEvent AEvent, Vcltee::Teengine::TChartSeries* ASeries);
	virtual void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	
public:
	__fastcall virtual TSeriesRegionTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSeriesRegionTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property bool AutoBounds = {read=FAutoBounds, write=SetAutoBounds, default=1};
	__property bool DrawBehindSeries = {read=FDrawBehindSeries, write=SetDrawBehindSeries, default=1};
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property double LowerBound = {read=FLowerBound, write=SetLowerBound};
	__property double Origin = {read=FOrigin, write=SetOrigin};
	__property Vcltee::Tecanvas::TTeeHiddenPen* OriginPen = {read=FOriginPen, write=SetOriginPen};
	__property double UpperBound = {read=FUpperBound, write=SetUpperBound};
	__property bool UseOrigin = {read=FUseOrigin, write=SetUseOrigin, default=1};
	__property Active = {default=1};
	__property Brush;
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, default=16777215};
	__property Pen;
	__property Series;
	__property Vcltee::Tecanvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeseriesregion */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESREGION)
using namespace Vcltee::Teeseriesregion;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriesregionHPP
