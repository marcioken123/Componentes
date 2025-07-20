// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFunnel.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeefunnelHPP
#define Vcltee_TeefunnelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teefunnel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFunnelSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFunnelSeries : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TPoint> _TFunnelSeries__1;
	
	
private:
	System::Uitypes::TColor FAboveColor;
	bool FAutoUpdate;
	System::Uitypes::TColor FBelowColor;
	double FDifferenceLimit;
	Vcltee::Tecanvas::TTeePen* FLinesPen;
	Vcltee::Teengine::TChartValueList* FOpportunityValues;
	bool FQuotesSorted;
	System::Uitypes::TColor FWithinColor;
	bool IOldAxisVisible;
	_TFunnelSeries__1 IPolyPoints;
	bool ISorted;
	double IMin;
	double IMax;
	double ISlope;
	double IDiff;
	System::StaticArray<System::Types::TPoint, 4> BoundingPoints;
	System::Uitypes::TColor __fastcall DefineFunnelRegion(int ValueIndex);
	virtual Vcltee::Teengine::TChartValueList* __fastcall GetQuoteValues();
	void __fastcall SetAboveColor(const System::Uitypes::TColor Value);
	void __fastcall SetAutoUpdate(const bool Value);
	void __fastcall SetBelowColor(const System::Uitypes::TColor Value);
	void __fastcall SetDifferenceLimit(const double Value);
	void __fastcall SetLinesPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetOpportunityValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetQuotesSorted(const bool Value);
	virtual void __fastcall SetQuoteValues(Vcltee::Teengine::TChartValueList* const Value);
	void __fastcall SetWithinColor(const System::Uitypes::TColor Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	HIDESBASE void __fastcall GetMarkText(Vcltee::Teengine::TChartSeries* Sender, int ValueIndex, System::UnicodeString &MarkText);
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TFunnelSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TFunnelSeries();
	int __fastcall AddSegment(const double AQuote, const double AOpportunity, const System::UnicodeString ALabel, System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	virtual int __fastcall CountLegendItems();
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MinYValue();
	void __fastcall Recalc();
	
__published:
	__property Brush;
	__property Pen;
	__property System::Uitypes::TColor AboveColor = {read=FAboveColor, write=SetAboveColor, default=32768};
	__property bool AutoUpdate = {read=FAutoUpdate, write=SetAutoUpdate, default=1};
	__property System::Uitypes::TColor BelowColor = {read=FBelowColor, write=SetBelowColor, default=255};
	__property double DifferenceLimit = {read=FDifferenceLimit, write=SetDifferenceLimit};
	__property Vcltee::Tecanvas::TTeePen* LinesPen = {read=FLinesPen, write=SetLinesPen};
	__property Vcltee::Teengine::TChartValueList* OpportunityValues = {read=FOpportunityValues, write=SetOpportunityValues};
	__property bool QuotesSorted = {read=FQuotesSorted, write=SetQuotesSorted, default=0};
	__property Vcltee::Teengine::TChartValueList* QuoteValues = {read=GetQuoteValues, write=SetQuoteValues};
	__property System::Uitypes::TColor WithinColor = {read=FWithinColor, write=SetWithinColor, default=65535};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teefunnel */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFUNNEL)
using namespace Vcltee::Teefunnel;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeefunnelHPP
