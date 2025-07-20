// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeActivityDonut.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeactivitydonutHPP
#define Vcltee_TeeactivitydonutHPP

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
#include <VCLTee.TeeDonut.hpp>
#include <VCLTee.TeeTools.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeactivitydonut
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TActivityDonut;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TActivityDonut : public Vcltee::Teedonut::TDonutSeries
{
	typedef Vcltee::Teedonut::TDonutSeries inherited;
	
private:
	System::Uitypes::TColor FBackColor;
	System::Uitypes::TColor FColor;
	double FValue;
	
protected:
	double __fastcall GetValue();
	void __fastcall SetValue(const double Value);
	System::Uitypes::TColor __fastcall GetColor();
	void __fastcall SetColor(const System::Uitypes::TColor AColor);
	System::Uitypes::TColor __fastcall GetBackColor();
	void __fastcall SetBackColor(const System::Uitypes::TColor AColor);
	
public:
	__fastcall virtual TActivityDonut(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TActivityDonut();
	
__published:
	__property double Value = {read=GetValue, write=SetValue};
	__property System::Uitypes::TColor Color = {read=GetColor, write=SetColor, nodefault};
	__property System::Uitypes::TColor BackColor = {read=GetBackColor, write=SetBackColor, default=12632256};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeactivitydonut */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEACTIVITYDONUT)
using namespace Vcltee::Teeactivitydonut;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeactivitydonutHPP
