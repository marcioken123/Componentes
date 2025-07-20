// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeActivityGauge.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeactivitygaugeHPP
#define Vcltee_TeeactivitygaugeHPP

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
#include <VCLTee.TeeActivityDonut.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeactivitygauge
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TActivityGauge;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<Vcltee::Teeactivitydonut::TActivityDonut*> TActivityValues;

class PASCALIMPLEMENTATION TActivityGauge : public Vcltee::Teedonut::TDonutSeries
{
	typedef Vcltee::Teedonut::TDonutSeries inherited;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool Sequential = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall DoBeforeDrawChart();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
private:
	TActivityValues FActivityValues;
	System::Uitypes::TColor FBackColor;
	Vcltee::Teetools::TAnnotationTool* FCenterText;
	bool FHiddingSeries;
	Vcltee::Teeactivitydonut::TActivityDonut* __fastcall ConfigureActivity(Vcltee::Teeactivitydonut::TActivityDonut* const ASeries, double AValue, int AIndex, System::Uitypes::TColor AColor);
	TActivityValues __fastcall GetActivityValues();
	Vcltee::Teetools::TAnnotationTool* __fastcall GetCenterText();
	void __fastcall SetBackColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TActivityGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TActivityGauge();
	int __fastcall AddActivity(const double AValue, const System::UnicodeString ALabel, const System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	virtual void __fastcall Clear();
	virtual void __fastcall Delete(int ValueIndex)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property TActivityValues ActivityValues = {read=GetActivityValues, write=FActivityValues};
	__property System::Uitypes::TColor BackColor = {read=FBackColor, write=SetBackColor, default=12632256};
	__property Vcltee::Teetools::TAnnotationTool* CenterText = {read=GetCenterText, write=FCenterText};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Delete(int Start, int Quantity, bool RemoveGap = false){ Vcltee::Teengine::TChartSeries::Delete(Start, Quantity, RemoveGap); }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 TeeDefaultDonutPercent = System::Int8(0x32);
}	/* namespace Teeactivitygauge */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEACTIVITYGAUGE)
using namespace Vcltee::Teeactivitygauge;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeactivitygaugeHPP
