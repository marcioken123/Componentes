// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Funnel.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_FunnelHPP
#define Fmxtee_Series_FunnelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.UIConsts.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Funnel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFunnelSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFunnelSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TPointF> _TFunnelSeries__1;
	
	
private:
	System::Uitypes::TAlphaColor FAboveColor;
	bool FAutoUpdate;
	System::Uitypes::TAlphaColor FBelowColor;
	double FDifferenceLimit;
	Fmxtee::Canvas::TTeePen* FLinesPen;
	Fmxtee::Engine::TChartValueList* FOpportunityValues;
	bool FQuotesSorted;
	System::Uitypes::TAlphaColor FWithinColor;
	bool IOldAxisVisible;
	_TFunnelSeries__1 IPolyPoints;
	bool ISorted;
	double IMin;
	double IMax;
	double ISlope;
	double IDiff;
	System::StaticArray<System::Types::TPointF, 4> BoundingPoints;
	System::Uitypes::TAlphaColor __fastcall DefineFunnelRegion(int ValueIndex);
	virtual Fmxtee::Engine::TChartValueList* __fastcall GetQuoteValues();
	void __fastcall SetAboveColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetAutoUpdate(const bool Value);
	void __fastcall SetBelowColor(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetDifferenceLimit(const double Value);
	void __fastcall SetLinesPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetOpportunityValues(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetQuotesSorted(const bool Value);
	virtual void __fastcall SetQuoteValues(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetWithinColor(const System::Uitypes::TAlphaColor Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	HIDESBASE void __fastcall GetMarkText(Fmxtee::Engine::TChartSeries* Sender, int ValueIndex, System::UnicodeString &MarkText);
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TFunnelSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TFunnelSeries();
	int __fastcall AddSegment(const double AQuote, const double AOpportunity, const System::UnicodeString ALabel, System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	virtual int __fastcall CountLegendItems();
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Fmxtee::Engine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MinYValue();
	void __fastcall Recalc();
	
__published:
	__property Brush;
	__property Pen;
	__property System::Uitypes::TAlphaColor AboveColor = {read=FAboveColor, write=SetAboveColor, default=-16744448};
	__property bool AutoUpdate = {read=FAutoUpdate, write=SetAutoUpdate, default=1};
	__property System::Uitypes::TAlphaColor BelowColor = {read=FBelowColor, write=SetBelowColor, default=-65536};
	__property double DifferenceLimit = {read=FDifferenceLimit, write=SetDifferenceLimit};
	__property Fmxtee::Canvas::TTeePen* LinesPen = {read=FLinesPen, write=SetLinesPen};
	__property Fmxtee::Engine::TChartValueList* OpportunityValues = {read=FOpportunityValues, write=SetOpportunityValues};
	__property bool QuotesSorted = {read=FQuotesSorted, write=SetQuotesSorted, default=0};
	__property Fmxtee::Engine::TChartValueList* QuoteValues = {read=GetQuoteValues, write=SetQuoteValues};
	__property System::Uitypes::TAlphaColor WithinColor = {read=FWithinColor, write=SetWithinColor, default=-256};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Funnel */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_FUNNEL)
using namespace Fmxtee::Series::Funnel;
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
#endif	// Fmxtee_Series_FunnelHPP
