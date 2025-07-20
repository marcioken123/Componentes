// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Functions.Cumulative.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Functions_CumulativeHPP
#define Fmxtee_Functions_CumulativeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Functions
{
namespace Cumulative
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCumulative;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCumulative : public Fmxtee::Engine::TTeeFunction
{
	typedef Fmxtee::Engine::TTeeFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Fmxtee::Engine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCumulative(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Fmxtee::Engine::TChartSeries* const Series, int First, int Last);
	virtual double __fastcall CalculateMany(Fmxtee::Engine::TDataSourcesList* const SeriesList, int ValueIndex);
	
__published:
	__property Period = {default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCumulative() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Cumulative */
}	/* namespace Functions */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_FUNCTIONS_CUMULATIVE)
using namespace Fmxtee::Functions::Cumulative;
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
#endif	// Fmxtee_Functions_CumulativeHPP
