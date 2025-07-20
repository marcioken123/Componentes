// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Chart.Grid.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Chart_GridHPP
#define Fmxtee_Chart_GridHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.Types.hpp>
#include <FMX.Grid.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Grid.Style.hpp>
#include <FMX.Presentation.Factory.hpp>
#include <FMX.Presentation.Style.hpp>
#include <System.Rtti.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Controls.Model.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMX.ScrollBox.hpp>
#include <FMX.Controls.Presentation.hpp>
#include <System.UITypes.hpp>
#include <FMX.BehaviorManager.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Chart
{
namespace Grid
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartGridNavigator;
class DELPHICLASS TCustomChartGrid;
class DELPHICLASS TChartGrid;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartGridNavigator : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	/* TComponent.Create */ inline __fastcall virtual TChartGridNavigator(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TChartGridNavigator() { }
	
};


enum DECLSPEC_DENUM TChartGridShow : unsigned char { cgsAuto, cgsNo, cgsYes };

typedef void __fastcall (__closure *TEditingCellEvent)(TCustomChartGrid* Sender, int ACol, int ARow, bool &Allow);

class PASCALIMPLEMENTATION TCustomChartGrid : public Fmx::Grid::TCustomGrid
{
	typedef Fmx::Grid::TCustomGrid inherited;
	
	
private:
	typedef System::DynamicArray<bool> _TCustomChartGrid__1;
	
	
private:
	bool FAllowAppend;
	bool FAllowInsertSeries;
	Fmxtee::Chart::TCustomChart* FChart;
	bool FColors;
	Fmxtee::Canvas::TTeeGradient* FGradientCell;
	bool FGrid3DMode;
	bool FLabels;
	bool FSymbolClickable;
	TChartGridShow FVisuals;
	TChartGridShow FXValues;
	System::UnicodeString FOldValue;
	System::Classes::TNotifyEvent FOnChangeColor;
	TEditingCellEvent FOnEditing;
	Fmx::Grid::TOnSetValue FOnSetCell;
	bool FShowFields;
	bool FWasNull;
	_TCustomChartGrid__1 IHasNo;
	TChartGridNavigator* INavigator;
	Fmx::Menus::TPopupMenu* IPopupVisual;
	Fmxtee::Engine::TChartSeries* FSeries;
	Fmxtee::Engine::TCustomAxisPanel* ISeriesChart;
	void __fastcall AddListener(Fmxtee::Engine::TCustomAxisPanel* const AChart);
	bool __fastcall AtSeriesColor(Fmxtee::Engine::TChartSeries* &Series);
	bool __fastcall CanInsertSeries();
	virtual void __fastcall CanvasChanged(System::TObject* Sender);
	void __fastcall AddColumns(const int ACount);
	HIDESBASE int __fastcall Col();
	int __fastcall ColCount();
	HIDESBASE int __fastcall Row();
	void __fastcall DoChangeVisual(Fmxtee::Engine::TChartSeries* const ASeries, int AIndex);
	System::UnicodeString __fastcall FindHeaderText(int ACol);
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradientCell();
	void __fastcall MenuChangeVisual(System::TObject* Sender);
	void __fastcall MenuDeleteVisual(System::TObject* Sender);
	void __fastcall MenuEditVisual(System::TObject* Sender);
	Fmxtee::Engine::TChartSeries* __fastcall NewBarSeries();
	void __fastcall NotifyChange();
	void __fastcall Regenerate();
	void __fastcall RemoveListener(Fmxtee::Engine::TCustomAxisPanel* const AChart);
	void __fastcall SetBooleanProperty(bool &Variable, bool Value);
	void __fastcall SetChart(Fmxtee::Chart::TCustomChart* const AChart);
	void __fastcall SetGradientCell(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetGrid3DMode(bool Value);
	void __fastcall SetManualData(Fmxtee::Engine::TChartSeries* const ASeries);
	void __fastcall SetShowColors(bool Value);
	void __fastcall SetShowFields(bool Value);
	void __fastcall SetShowLabels(bool Value);
	void __fastcall SetShowVisuals(const TChartGridShow Value);
	void __fastcall SetShowXValues(const TChartGridShow Value);
	void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	int __fastcall ValidListsOfSeries(Fmxtee::Engine::TChartSeries* const ASeries, const int AIndex);
	
protected:
	System::Classes::TNotifyEvent FActiveChanged;
	System::Classes::TNotifyEvent FSelectedChanged;
	System::Classes::TNotifyEvent FOnTopLeftChanged;
	bool __fastcall CanEditShow();
	virtual void __fastcall DblClick();
	virtual Fmx::Controls::Model::TDataModelClass __fastcall DefineModelClass();
	System::Rtti::TValue __fastcall GetValue(int ACol, int ARow);
	Fmxtee::Engine::TChartSeries* __fastcall GetSeriesColor(/* out */ System::Uitypes::TAlphaColor &AColor)/* overload */;
	Fmxtee::Engine::TChartSeries* __fastcall GetSeriesColor(/* out */ System::Uitypes::TAlphaColor &AColor, int ACol, int ARow)/* overload */;
	void __fastcall EditVisual(int ACol);
	bool __fastcall HasPoints();
	bool __fastcall HasVisuals(Fmxtee::Engine::TChartSeries* const ASeries);
	virtual void __fastcall KeyDown(System::Word &Key, System::WideChar &KeyChar, System::Classes::TShiftState Shift);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetValue(int ACol, int ARow, const System::Rtti::TValue &Value);
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	bool __fastcall IsVisualsColumn(int ACol);
	
public:
	bool AllowChanges;
	__fastcall virtual TCustomChartGrid(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TCustomChartGrid();
	void __fastcall AppendRow();
	void __fastcall ChangeColor()/* overload */;
	void __fastcall ChangeColor(System::Uitypes::TAlphaColor AColor)/* overload */;
	void __fastcall ChangeColor(Fmxtee::Engine::TChartSeries* const ASeries, System::Uitypes::TAlphaColor AColor)/* overload */;
	int __fastcall ColorsColumn();
	void __fastcall Delete();
	int __fastcall FindXYZIndex(Fmxtee::Engine::TChartSeries* const ASeries, int ARow, int ACol);
	int __fastcall FirstRowNum();
	Fmxtee::Engine::TChartSeries* __fastcall GetSeries(int ACol)/* overload */;
	Fmxtee::Engine::TChartSeries* __fastcall GetSeries(int ACol, /* out */ Fmxtee::Engine::TChartValueList* &AList)/* overload */;
	Fmxtee::Engine::TChartSeries* __fastcall GetXYZSeries();
	HIDESBASE void __fastcall Insert();
	int __fastcall LabelsColumn();
	void __fastcall RecalcDimensions();
	void __fastcall StartEditing();
	void __fastcall StopEditing(bool Cancel);
	__property bool AllowAppend = {read=FAllowAppend, write=FAllowAppend, default=1};
	__property bool AllowInsertSeries = {read=FAllowInsertSeries, write=FAllowInsertSeries, default=0};
	__property Fmxtee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
	__property Fmxtee::Canvas::TTeeGradient* GradientCell = {read=GetGradientCell, write=SetGradientCell};
	__property Fmxtee::Engine::TChartSeries* Series = {read=FSeries, write=SetSeries};
	__property bool SeriesSymbolClickable = {read=FSymbolClickable, write=FSymbolClickable, default=1};
	__property bool ShowColors = {read=FColors, write=SetShowColors, default=0};
	__property bool ShowFields = {read=FShowFields, write=SetShowFields, default=1};
	__property bool ShowLabels = {read=FLabels, write=SetShowLabels, default=1};
	__property TChartGridShow ShowVisuals = {read=FVisuals, write=SetShowVisuals, default=0};
	__property TChartGridShow ShowXValues = {read=FXValues, write=SetShowXValues, default=0};
	__property bool Grid3DMode = {read=FGrid3DMode, write=SetGrid3DMode, default=0};
	__property System::Classes::TNotifyEvent OnChangeColor = {read=FOnChangeColor, write=FOnChangeColor};
	__property TEditingCellEvent OnEditingCell = {read=FOnEditing, write=FOnEditing};
	__property Fmx::Grid::TOnSetValue OnSetEditText = {read=FOnSetCell, write=FOnSetCell};
	__property System::Classes::TNotifyEvent OnTopLeftChanged = {read=FOnTopLeftChanged, write=FOnTopLeftChanged};
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};


class PASCALIMPLEMENTATION TChartGrid : public TCustomChartGrid
{
	typedef TCustomChartGrid inherited;
	
public:
	__property RowCount = {default=100};
	__property TopRow;
	
__published:
	__property Align = {default=0};
	__property AutoHide = {default=2};
	__property OnGetValue;
	__property OnSetValue;
	__property Action;
	__property Anchors;
	__property Height;
	__property Position;
	__property Size;
	__property StyleLookup = {default=0};
	__property TabOrder = {default=-1};
	__property Width;
	__property ParentShowHint = {default=1};
	__property ShowHint;
	__property Chart;
	__property Series;
	__property ShowColors = {default=0};
	__property ShowLabels = {default=1};
	__property ShowVisuals = {default=0};
	__property ShowXValues = {default=0};
	__property OnChangeColor;
	__property OnEditingCell;
	__property OnSetEditText;
	__property OnTopLeftChanged;
public:
	/* TCustomChartGrid.Create */ inline __fastcall virtual TChartGrid(System::Classes::TComponent* AOwner)/* overload */ : TCustomChartGrid(AOwner) { }
	/* TCustomChartGrid.Destroy */ inline __fastcall virtual ~TChartGrid() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Grid */
}	/* namespace Chart */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CHART_GRID)
using namespace Fmxtee::Chart::Grid;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CHART)
using namespace Fmxtee::Chart;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Chart_GridHPP
