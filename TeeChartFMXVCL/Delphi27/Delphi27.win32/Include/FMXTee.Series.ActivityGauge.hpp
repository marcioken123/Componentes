// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.ActivityGauge.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_ActivitygaugeHPP
#define Fmxtee_Series_ActivitygaugeHPP

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
#include <FMXTee.TeeActivityDonut.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Activitygauge
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TActivityGauge;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<Fmxtee::Teeactivitydonut::TActivityDonut*> TActivityValues;

class PASCALIMPLEMENTATION TActivityGauge : public Fmxtee::Series::Donut::TDonutSeries
{
	typedef Fmxtee::Series::Donut::TDonutSeries inherited;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool Sequential = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall DoBeforeDrawChart();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
private:
	TActivityValues FActivityValues;
	System::Uitypes::TAlphaColor FBackColor;
	Fmxtee::Tools::TAnnotationTool* FCenterText;
	bool FHiddingSeries;
	Fmxtee::Teeactivitydonut::TActivityDonut* __fastcall ConfigureActivity(Fmxtee::Teeactivitydonut::TActivityDonut* const ASeries, double AValue, int AIndex, System::Uitypes::TAlphaColor AColor);
	TActivityValues __fastcall GetActivityValues();
	Fmxtee::Tools::TAnnotationTool* __fastcall GetCenterText();
	void __fastcall SetBackColor(const System::Uitypes::TAlphaColor Value);
	
public:
	__fastcall virtual TActivityGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TActivityGauge();
	int __fastcall AddActivity(const double AValue, const System::UnicodeString ALabel, const System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual void __fastcall Clear();
	virtual void __fastcall Delete(int ValueIndex)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property TActivityValues ActivityValues = {read=GetActivityValues, write=FActivityValues};
	__property System::Uitypes::TAlphaColor BackColor = {read=FBackColor, write=SetBackColor, default=-4144960};
	__property Fmxtee::Tools::TAnnotationTool* CenterText = {read=GetCenterText, write=FCenterText};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Delete(int Start, int Quantity, bool RemoveGap = false){ Fmxtee::Engine::TChartSeries::Delete(Start, Quantity, RemoveGap); }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 TeeDefaultDonutPercent = System::Int8(0x32);
}	/* namespace Activitygauge */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_ACTIVITYGAUGE)
using namespace Fmxtee::Series::Activitygauge;
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
#endif	// Fmxtee_Series_ActivitygaugeHPP
