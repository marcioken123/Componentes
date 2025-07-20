// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeExtraLegendTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeextralegendtoolHPP
#define Vcltee_TeeextralegendtoolHPP

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
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeextralegendtool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TExtraLegendTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TExtraLegendTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	Vcltee::Chart::TChartLegend* FLegend;
	Vcltee::Chart::TChartLegend* __fastcall GetLegend();
	void __fastcall SetLegend(Vcltee::Chart::TChartLegend* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	
public:
	__fastcall virtual ~TExtraLegendTool();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property Vcltee::Chart::TChartLegend* Legend = {read=GetLegend, write=SetLegend};
	__property Series;
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TExtraLegendTool(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeCustomToolSeries(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeextralegendtool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEXTRALEGENDTOOL)
using namespace Vcltee::Teeextralegendtool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeextralegendtoolHPP
