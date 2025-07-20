// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesBandTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriesbandtoolHPP
#define Vcltee_TeeseriesbandtoolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeeProCo.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriesbandtool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesBandTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TBandCondition : unsigned char { bcAll, bcLower, bcHigher };

class PASCALIMPLEMENTATION TSeriesBandTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	double FBoundValue;
	TBandCondition FCondition;
	bool FDrawBehind;
	Vcltee::Teengine::TChartSeries* FSeries2;
	Vcltee::Tecanvas::TTeeTransparency FTransparency;
	bool ISerie1Drawed;
	bool ISerie2Drawed;
	bool IPaintedBand;
	void __fastcall AfterSeriesDraw(System::TObject* Sender);
	void __fastcall BeforeSeriesDraw(System::TObject* Sender);
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetDrawBehind(const bool Value);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetTransparency(const Vcltee::Tecanvas::TTeeTransparency Value);
	void __fastcall SetBoundValue(const double Value);
	void __fastcall SetCondition(const TBandCondition Value);
	void __fastcall TryToPaint(System::TObject* Sender);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SeriesEvent(Vcltee::Teengine::TChartToolEvent AEvent, Vcltee::Teengine::TChartSeries* ASeries);
	virtual void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	virtual void __fastcall SetSeries2(Vcltee::Teengine::TChartSeries* const Value);
	virtual void __fastcall DrawBandTool();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TSeriesBandTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property double BoundValue = {read=FBoundValue, write=SetBoundValue};
	__property Brush;
	__property TBandCondition Condition = {read=FCondition, write=SetCondition, default=0};
	__property bool DrawBehindSeries = {read=FDrawBehind, write=SetDrawBehind, default=1};
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Pen;
	__property Series;
	__property Vcltee::Teengine::TChartSeries* Series2 = {read=FSeries2, write=SetSeries2};
	__property Vcltee::Tecanvas::TTeeTransparency Transparency = {read=FTransparency, write=SetTransparency, default=0};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TSeriesBandTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeseriesbandtool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESBANDTOOL)
using namespace Vcltee::Teeseriesbandtool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriesbandtoolHPP
