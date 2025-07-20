// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.DataTable.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_DatatableHPP
#define Fmxtee_Tools_DatatableHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Datatable
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTableLegend;
class DELPHICLASS TDataTableTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTableLegend : public Fmxtee::Procs::TTeeCustomShape
{
	typedef Fmxtee::Procs::TTeeCustomShape inherited;
	
private:
	bool FFontColor;
	bool FOtherSide;
	Fmxtee::Chart::TLegendSymbol* FSymbol;
	int __fastcall CalcSymbolHeight();
	void __fastcall SetFontColor(const bool Value);
	void __fastcall SetSymbol(Fmxtee::Chart::TLegendSymbol* const Value);
	void __fastcall SetOtherSide(const bool Value);
	
protected:
	virtual void __fastcall SetParent(Fmxtee::Procs::TCustomTeePanel* Value);
	
public:
	__fastcall virtual TTableLegend(Fmxtee::Procs::TCustomTeePanel* const AOwner)/* overload */;
	__fastcall virtual ~TTableLegend();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Brush;
	__property Color = {default=-1};
	__property Font;
	__property bool FontSeriesColor = {read=FFontColor, write=SetFontColor, default=0};
	__property Gradient;
	__property bool OtherSide = {read=FOtherSide, write=SetOtherSide, default=0};
	__property Pen;
	__property Fmxtee::Chart::TLegendSymbol* Symbol = {read=FSymbol, write=SetSymbol};
	__property Transparency = {default=0};
	__property Transparent = {default=1};
	__property Visible;
};


typedef void __fastcall (__closure *TDataTableFilterSeries)(TDataTableTool* Sender, Fmxtee::Engine::TChartSeries* Series, bool &Accept);

class PASCALIMPLEMENTATION TDataTableTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	bool FAutoPos;
	bool FClipText;
	Fmxtee::Canvas::TTeePen* FColumnPen;
	Fmxtee::Canvas::TTeeFont* FFont;
	bool FInverted;
	int FLeft;
	TTableLegend* FLegend;
	TDataTableFilterSeries FOnFilterSeries;
	int FTop;
	void __fastcall CalcFirstLastAllSeries(/* out */ int &tmpFirst, /* out */ int &tmpLast);
	int __fastcall CalcPosLabels(Fmxtee::Engine::TChartAxis* Axis, int Value);
	int __fastcall CalcTableSize(Fmxtee::Engine::TChartAxis* const Axis);
	Fmxtee::Chart::TCustomChart* __fastcall Chart();
	void __fastcall Draw();
	Fmxtee::Canvas::TTeePen* __fastcall GetRowPen();
	Fmxtee::Engine::TChartAxis* __fastcall GuessAxis();
	System::UnicodeString __fastcall ItemText(Fmxtee::Engine::TChartSeries* const Series, int ValueIndex);
	int __fastcall LegendWidth(/* out */ int &SymbolWidth);
	void __fastcall SetAutoPos(const bool Value);
	void __fastcall SetClipText(const bool Value);
	void __fastcall SetColumnPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetFont(Fmxtee::Canvas::TTeeFont* const Value);
	void __fastcall SetInverted(const bool Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetLegend(TTableLegend* const Value);
	void __fastcall SetRowPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetTop(const int Value);
	int __fastcall TableSize();
	bool __fastcall ValidSeries(int Index);
	int __fastcall VisibleSeriesCount();
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
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
	__property Fmxtee::Canvas::TTeePen* ColumnPen = {read=FColumnPen, write=SetColumnPen};
	__property Fmxtee::Canvas::TTeeFont* Font = {read=FFont, write=SetFont};
	__property bool Inverted = {read=FInverted, write=SetInverted, default=0};
	__property int Left = {read=FLeft, write=SetLeft, default=0};
	__property TTableLegend* Legend = {read=FLegend, write=SetLegend};
	__property Fmxtee::Canvas::TTeePen* RowPen = {read=GetRowPen, write=SetRowPen};
	__property int Top = {read=FTop, write=SetTop, default=0};
	__property TDataTableFilterSeries OnFilterSeries = {read=FOnFilterSeries, write=FOnFilterSeries};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Datatable */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_DATATABLE)
using namespace Fmxtee::Tools::Datatable;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_DatatableHPP
