// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesStats.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriesstatsHPP
#define Vcltee_TeeseriesstatsHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriesstats
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesStatsTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesStatsTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	Vcltee::Teengine::TTeeFunction* __fastcall GetStatFunction(Vcltee::Teengine::TTeeFunctionClass FuncType);
	
public:
	__classmethod virtual System::UnicodeString __fastcall Description();
	void __fastcall FreeStatsSeries();
	double __fastcall Kurtosis();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	double __fastcall Mean();
	double __fastcall Skewness();
	void __fastcall Statistics(System::Classes::TStrings* const Lines);
	double __fastcall StdDeviation();
	
__published:
	__property Active = {default=1};
	__property Series;
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TSeriesStatsTool(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeCustomToolSeries(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TSeriesStatsTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeseriesstats */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESSTATS)
using namespace Vcltee::Teeseriesstats;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriesstatsHPP
