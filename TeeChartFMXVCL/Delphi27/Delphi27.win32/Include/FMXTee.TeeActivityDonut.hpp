// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.TeeActivityDonut.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_TeeactivitydonutHPP
#define Fmxtee_TeeactivitydonutHPP

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
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Series.Donut.hpp>
#include <FMXTee.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Teeactivitydonut
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TActivityDonut;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TActivityDonut : public Fmxtee::Series::Donut::TDonutSeries
{
	typedef Fmxtee::Series::Donut::TDonutSeries inherited;
	
private:
	System::Uitypes::TAlphaColor FBackColor;
	System::Uitypes::TAlphaColor FColor;
	double FValue;
	
protected:
	double __fastcall GetValue();
	void __fastcall SetValue(const double Value);
	System::Uitypes::TAlphaColor __fastcall GetColor();
	void __fastcall SetColor(const System::Uitypes::TAlphaColor AColor);
	System::Uitypes::TAlphaColor __fastcall GetBackColor();
	void __fastcall SetBackColor(const System::Uitypes::TAlphaColor AColor);
	
public:
	__fastcall virtual TActivityDonut(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TActivityDonut();
	
__published:
	__property double Value = {read=GetValue, write=SetValue};
	__property System::Uitypes::TAlphaColor Color = {read=GetColor, write=SetColor, nodefault};
	__property System::Uitypes::TAlphaColor BackColor = {read=GetBackColor, write=SetBackColor, default=-4144960};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeactivitydonut */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TEEACTIVITYDONUT)
using namespace Fmxtee::Teeactivitydonut;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_TeeactivitydonutHPP
