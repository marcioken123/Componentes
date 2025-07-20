// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Donut.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Series_DonutHPP
#define Fmxtee_Series_DonutHPP

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
#include <FMXTee.Chart.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Donut
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDonutSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDonutSeries : public Fmxtee::Series::TPieSeries
{
	typedef Fmxtee::Series::TPieSeries inherited;
	
protected:
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TDonutSeries(System::Classes::TComponent* AOwner);
	
__published:
	__property DonutPercent = {default=50};
public:
	/* TPieSeries.Destroy */ inline __fastcall virtual ~TDonutSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
static constexpr System::Int8 TeeDefaultDonutPercent = System::Int8(0x32);
}	/* namespace Donut */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_DONUT)
using namespace Fmxtee::Series::Donut;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES)
using namespace Fmxtee::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Series_DonutHPP
