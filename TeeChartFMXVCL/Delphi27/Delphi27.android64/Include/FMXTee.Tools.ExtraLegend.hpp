// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.ExtraLegend.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Tools_ExtralegendHPP
#define Fmxtee_Tools_ExtralegendHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Extralegend
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TExtraLegendTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TExtraLegendTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	Fmxtee::Chart::TChartLegend* FLegend;
	Fmxtee::Chart::TChartLegend* __fastcall GetLegend();
	void __fastcall SetLegend(Fmxtee::Chart::TChartLegend* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
public:
	__fastcall virtual ~TExtraLegendTool();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Fmxtee::Chart::TChartLegend* Legend = {read=GetLegend, write=SetLegend};
	__property Series;
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TExtraLegendTool(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeCustomToolSeries(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Extralegend */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_EXTRALEGEND)
using namespace Fmxtee::Tools::Extralegend;
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
#endif	// Fmxtee_Tools_ExtralegendHPP
