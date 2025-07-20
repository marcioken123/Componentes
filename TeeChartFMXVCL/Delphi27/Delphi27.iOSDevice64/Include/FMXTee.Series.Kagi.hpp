// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Kagi.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_KagiHPP
#define Fmxtee_Series_KagiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Kagi
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKagiSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKagiSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
private:
	bool FAbsReversal;
	Fmxtee::Engine::TSeriesPointer* FBuySymbol;
	Fmxtee::Canvas::TTeePen* FDownSwing;
	double FReversalAmount;
	Fmxtee::Engine::TSeriesPointer* FSellSymbol;
	Fmxtee::Canvas::TTeePen* FUpSwing;
	double __fastcall BasePrice();
	int __fastcall CalcSegments(bool Draw);
	void __fastcall DrawHorizLine(const double y, const double FromValue, const double ToValue);
	void __fastcall DrawVertLine(const double x, const double FromValue, const double ToValue);
	Fmxtee::Engine::TChartValueList* __fastcall GetCloseValues();
	bool __fastcall Reversal(const double Value, const double History0, const double History1);
	void __fastcall SetAbsoluteReversal(const bool Value);
	void __fastcall SetBuySymbol(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetDownSwing(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetReversalAmount(const double Value);
	void __fastcall SetSellSymbol(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetUpSwing(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TKagiSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TKagiSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CountLegendItems();
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Fmxtee::Engine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	DYNAMIC int __fastcall NumSampleValues();
	__property Fmxtee::Engine::TChartValueList* CloseValues = {read=GetCloseValues};
	
__published:
	__property bool AbsoluteReversal = {read=FAbsReversal, write=SetAbsoluteReversal, default=0};
	__property Fmxtee::Engine::TSeriesPointer* BuySymbol = {read=FBuySymbol, write=SetBuySymbol};
	__property Fmxtee::Canvas::TTeePen* DownSwing = {read=FDownSwing, write=SetDownSwing};
	__property double ReversalAmount = {read=FReversalAmount, write=SetReversalAmount};
	__property Fmxtee::Engine::TSeriesPointer* SellSymbol = {read=FSellSymbol, write=SetSellSymbol};
	__property Fmxtee::Canvas::TTeePen* UpSwing = {read=FUpSwing, write=SetUpSwing};
	__property Active = {default=1};
	__property Brush;
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property Pen;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property XValues;
	__property YValues;
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property OnAfterAdd;
	__property OnBeforeAdd;
	__property OnClearValues;
	__property OnClick;
	__property OnDblClick;
	__property OnGetMarkText;
	__property OnMouseEnter;
	__property OnMouseLeave;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Kagi */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_KAGI)
using namespace Fmxtee::Series::Kagi;
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
#endif	// Fmxtee_Series_KagiHPP
