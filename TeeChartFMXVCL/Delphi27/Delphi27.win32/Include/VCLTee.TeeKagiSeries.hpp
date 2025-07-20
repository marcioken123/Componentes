// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeKagiSeries.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeekagiseriesHPP
#define Vcltee_TeekagiseriesHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teekagiseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKagiSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKagiSeries : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
private:
	bool FAbsReversal;
	Vcltee::Teengine::TSeriesPointer* FBuySymbol;
	Vcltee::Tecanvas::TTeePen* FDownSwing;
	double FReversalAmount;
	Vcltee::Teengine::TSeriesPointer* FSellSymbol;
	Vcltee::Tecanvas::TTeePen* FUpSwing;
	double __fastcall BasePrice();
	int __fastcall CalcSegments(bool Draw);
	void __fastcall DrawHorizLine(const double y, const double FromValue, const double ToValue);
	void __fastcall DrawVertLine(const double x, const double FromValue, const double ToValue);
	Vcltee::Teengine::TChartValueList* __fastcall GetCloseValues();
	bool __fastcall Reversal(const double Value, const double History0, const double History1);
	void __fastcall SetAbsoluteReversal(const bool Value);
	void __fastcall SetBuySymbol(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetDownSwing(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetReversalAmount(const double Value);
	void __fastcall SetSellSymbol(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetUpSwing(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TKagiSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TKagiSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CountLegendItems();
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	DYNAMIC int __fastcall NumSampleValues();
	__property Vcltee::Teengine::TChartValueList* CloseValues = {read=GetCloseValues};
	
__published:
	__property bool AbsoluteReversal = {read=FAbsReversal, write=SetAbsoluteReversal, default=0};
	__property Vcltee::Teengine::TSeriesPointer* BuySymbol = {read=FBuySymbol, write=SetBuySymbol};
	__property Vcltee::Tecanvas::TTeePen* DownSwing = {read=FDownSwing, write=SetDownSwing};
	__property double ReversalAmount = {read=FReversalAmount, write=SetReversalAmount};
	__property Vcltee::Teengine::TSeriesPointer* SellSymbol = {read=FSellSymbol, write=SetSellSymbol};
	__property Vcltee::Tecanvas::TTeePen* UpSwing = {read=FUpSwing, write=SetUpSwing};
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
}	/* namespace Teekagiseries */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEKAGISERIES)
using namespace Vcltee::Teekagiseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeekagiseriesHPP
