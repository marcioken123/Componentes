// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeODS.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeodsHPP
#define Vcltee_TeeodsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeStore.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeods
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesDataODS;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesDataODS : public Vcltee::Teestore::TSeriesData
{
	typedef Vcltee::Teestore::TSeriesData inherited;
	
public:
	DYNAMIC void __fastcall SaveToStream(System::Classes::TStream* AStream);
public:
	/* TSeriesData.Create */ inline __fastcall virtual TSeriesDataODS(Vcltee::Chart::TCustomChart* AChart, Vcltee::Teengine::TChartSeries* ASeries) : Vcltee::Teestore::TSeriesData(AChart, ASeries) { }
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TSeriesDataODS() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeods */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEODS)
using namespace Vcltee::Teeods;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeodsHPP
