// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDonut.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedonutHPP
#define Vcltee_TeedonutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedonut
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDonutSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDonutSeries : public Vcltee::Series::TPieSeries
{
	typedef Vcltee::Series::TPieSeries inherited;
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TDonutSeries(System::Classes::TComponent* AOwner);
	
__published:
	__property DonutPercent = {default=50};
public:
	/* TPieSeries.Destroy */ inline __fastcall virtual ~TDonutSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 TeeDefaultDonutPercent = System::Int8(0x32);
}	/* namespace Teedonut */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDONUT)
using namespace Vcltee::Teedonut;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedonutHPP
