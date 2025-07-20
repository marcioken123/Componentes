// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCumu.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecumuHPP
#define Vcltee_TeecumuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecumu
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCumulative;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCumulative : public Vcltee::Teengine::TTeeFunction
{
	typedef Vcltee::Teengine::TTeeFunction inherited;
	
protected:
	virtual void __fastcall PrepareForGallery(Vcltee::Teengine::TCustomAxisPanel* const Chart);
	
public:
	__fastcall virtual TCumulative(System::Classes::TComponent* AOwner);
	virtual double __fastcall Calculate(Vcltee::Teengine::TChartSeries* const Series, int First, int Last);
	virtual double __fastcall CalculateMany(Vcltee::Teengine::TDataSourcesList* const SeriesList, int ValueIndex);
	
__published:
	__property Period = {default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TCumulative() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecumu */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECUMU)
using namespace Vcltee::Teecumu;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecumuHPP
