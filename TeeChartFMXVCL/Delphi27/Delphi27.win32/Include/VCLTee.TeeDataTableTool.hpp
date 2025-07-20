// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDataTableTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedatatabletoolHPP
#define Vcltee_TeedatatabletoolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedatatabletool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTableLegend;
class DELPHICLASS TDataTableTool;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTableLegend : public Vcltee::Teeprocs::TTeeCustomShape
{
	typedef Vcltee::Teeprocs::TTeeCustomShape inherited;
	
private:
	bool FFontColor;
	bool FOtherSide;
	Vcltee::Chart::TLegendSymbol* FSymbol;
	int __fastcall CalcSymbolHeight();
	void __fastcall SetFontColor(const bool Value);
	void __fastcall SetSymbol(Vcltee::Chart::TLegendSymbol* const Value);
	void __fastcall SetOtherSide(const bool Value);
	
protected:
	virtual void __fastcall SetParent(Vcltee::Teeprocs::TCustomTeePanel* Value);
	
public:
	__fastcall virtual TTableLegend(Vcltee::Teeprocs::TCustomTeePanel* const AOwner)/* overload */;
	__fastcall virtual ~TTableLegend();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Brush;
	__property Color = {default=16777215};
	__property Font;
	__property bool FontSeriesColor = {read=FFontColor, write=SetFontColor, default=0};
	__property Gradient;
	__property bool OtherSide = {read=FOtherSide, write=SetOtherSide, default=0};
	__property Pen;
	__property Vcltee::Chart::TLegendSymbol* Symbol = {read=FSymbol, write=SetSymbol};
	__property Transparency = {default=0};
	__property Transparent = {default=1};
	__property Visible;
};

#pragma pack(pop)

typedef void __fastcall (__closure *TDataTableFilterSeries)(TDataTableTool* Sender, Vcltee::Teengine::TChartSeries* Series, bool &Accept);

class PASCALIMPLEMENTATION TDataTableTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	bool FAutoPos;
	bool FClipText;
	Vcltee::Tecanvas::TTeePen* FColumnPen;
	Vcltee::Tecanvas::TTeeFont* FFont;
	bool FInverted;
	int FLeft;
	TTableLegend* FLegend;
	TDataTableFilterSeries FOnFilterSeries;
	int FTop;
	void __fastcall CalcFirstLastAllSeries(/* out */ int &tmpFirst, /* out */ int &tmpLast);
	int __fastcall CalcPosLabels(Vcltee::Teengine::TChartAxis* Axis, int Value);
	int __fastcall CalcTableSize(Vcltee::Teengine::TChartAxis* const Axis);
	Vcltee::Chart::TCustomChart* __fastcall Chart();
	void __fastcall Draw();
	Vcltee::Tecanvas::TTeePen* __fastcall GetRowPen();
	Vcltee::Teengine::TChartAxis* __fastcall GuessAxis();
	System::UnicodeString __fastcall ItemText(Vcltee::Teengine::TChartSeries* const Series, int ValueIndex);
	int __fastcall LegendWidth(/* out */ int &SymbolWidth);
	void __fastcall SetAutoPos(const bool Value);
	void __fastcall SetClipText(const bool Value);
	void __fastcall SetColumnPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetFont(Vcltee::Tecanvas::TTeeFont* const Value);
	void __fastcall SetInverted(const bool Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetLegend(TTableLegend* const Value);
	void __fastcall SetRowPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetTop(const int Value);
	int __fastcall TableSize();
	bool __fastcall ValidSeries(int Index);
	int __fastcall VisibleSeriesCount();
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TDataTableTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDataTableTool();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property bool AutoPosition = {read=FAutoPos, write=SetAutoPos, default=1};
	__property Brush;
	__property bool ClipText = {read=FClipText, write=SetClipText, default=1};
	__property Vcltee::Tecanvas::TTeePen* ColumnPen = {read=FColumnPen, write=SetColumnPen};
	__property Vcltee::Tecanvas::TTeeFont* Font = {read=FFont, write=SetFont};
	__property bool Inverted = {read=FInverted, write=SetInverted, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property TTableLegend* Legend = {read=FLegend, write=SetLegend};
	__property Vcltee::Tecanvas::TTeePen* RowPen = {read=GetRowPen, write=SetRowPen};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property TDataTableFilterSeries OnFilterSeries = {read=FOnFilterSeries, write=FOnFilterSeries};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedatatabletool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDATATABLETOOL)
using namespace Vcltee::Teedatatabletool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedatatabletoolHPP
