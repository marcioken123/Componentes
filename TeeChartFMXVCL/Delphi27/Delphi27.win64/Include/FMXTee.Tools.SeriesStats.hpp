// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.SeriesStats.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_SeriesstatsHPP
#define Fmxtee_Tools_SeriesstatsHPP

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
#include <System.UITypes.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Seriesstats
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesStatsTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesStatsTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	Fmxtee::Engine::TTeeFunction* __fastcall GetStatFunction(Fmxtee::Engine::TTeeFunctionClass FuncType);
	
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
	/* TCustomChartElement.Create */ inline __fastcall virtual TSeriesStatsTool(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeCustomToolSeries(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TSeriesStatsTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Seriesstats */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_SERIESSTATS)
using namespace Fmxtee::Tools::Seriesstats;
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
#endif	// Fmxtee_Tools_SeriesstatsHPP
