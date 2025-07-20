// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCount.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecountHPP
#define Vcltee_TeecountHPP

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
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecount
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCountTeeFunction;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCountTeeFunction : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int First, int Last);
	virtual double __fastcall CalculateMany(Vcltee::Teengine::TDataSourcesList* const SeriesList, int ValueIndex);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TCountTeeFunction(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCountTeeFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecount */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECOUNT)
using namespace Vcltee::Teecount;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecountHPP
