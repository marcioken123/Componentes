// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Functions.Count.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Functions_CountHPP
#define Fmxtee_Functions_CountHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Functions
{
namespace Count
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCountTeeFunction;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCountTeeFunction : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int First, int Last);
	virtual double __fastcall CalculateMany(Fmxtee::Engine::TDataSourcesList* const SeriesList, int ValueIndex);
public:
	/* TTeeFunction.Create */ inline __fastcall virtual TCountTeeFunction(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeFunction(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCountTeeFunction() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Count */
}	/* namespace Functions */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS_COUNT)
using namespace Fmxtee::Functions::Count;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS)
using namespace Fmxtee::Functions;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Functions_CountHPP
