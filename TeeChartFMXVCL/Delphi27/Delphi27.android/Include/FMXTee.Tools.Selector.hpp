// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Selector.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Tools_SelectorHPP
#define Fmxtee_Tools_SelectorHPP

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
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Selector
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSelectorTool;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSelectorTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	bool FAllowDrag;
	bool FAllowResizeChart;
	System::Uitypes::TCursor FCursor;
	int FHandleSize;
	System::Classes::TNotifyEvent FOnDragged;
	System::Classes::TNotifyEvent FOnDragging;
	System::Classes::TNotifyEvent FOnResized;
	System::Classes::TNotifyEvent FOnResizing;
	System::Classes::TNotifyEvent FOnSelected;
	Fmxtee::Tools::TAnnotationTool* FAnnotation;
	bool FDrawHandles;
	Fmxtee::Chart::TTeeCustomShapePosition* FShape;
	Fmxtee::Chart::TChartWall* FWall;
	bool IDragging;
	bool IDragged;
	System::Types::TPointF IDif;
	bool IResizingChart;
	bool IResized;
	void __fastcall EmptySelection();
	System::Classes::TPersistent* __fastcall GetSelection();
	Fmxtee::Engine::TChartSeries* __fastcall GetSeries();
	void __fastcall SetHandleSize(const int Value);
	void __fastcall SetAnnotation(Fmxtee::Tools::TAnnotationTool* const Value);
	void __fastcall SetWall(Fmxtee::Chart::TChartWall* const Value);
	void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoSelected();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	
public:
	Fmxtee::Engine::TChartClickedPart Part;
	__fastcall virtual TSelectorTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSelectorTool();
	void __fastcall ClearSelection();
	void __fastcall StopDragging();
	bool __fastcall ClickedCorner(int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	Fmxtee::Chart::TChartTitle* __fastcall SelectedTitle();
	__property Fmxtee::Tools::TAnnotationTool* Annotation = {read=FAnnotation, write=SetAnnotation};
	__property Fmxtee::Chart::TTeeCustomShapePosition* DraggingShape = {read=FShape};
	__property bool DrawHandles = {read=FDrawHandles, write=FDrawHandles, nodefault};
	__property System::Classes::TPersistent* Selection = {read=GetSelection};
	__property Fmxtee::Engine::TChartSeries* Series = {read=GetSeries, write=SetSeries};
	__property Fmxtee::Chart::TChartWall* Wall = {read=FWall, write=SetWall};
	
__published:
	__property Active = {default=1};
	__property bool AllowDrag = {read=FAllowDrag, write=FAllowDrag, default=1};
	__property bool AllowResizeChart = {read=FAllowResizeChart, write=FAllowResizeChart, default=0};
	__property Brush;
	__property System::Uitypes::TCursor Cursor = {read=FCursor, write=FCursor, default=-21};
	__property int HandleSize = {read=FHandleSize, write=SetHandleSize, default=3};
	__property Pen;
	__property System::Classes::TNotifyEvent OnDragged = {read=FOnDragged, write=FOnDragged};
	__property System::Classes::TNotifyEvent OnDragging = {read=FOnDragging, write=FOnDragging};
	__property System::Classes::TNotifyEvent OnResized = {read=FOnResized, write=FOnResized};
	__property System::Classes::TNotifyEvent OnResizing = {read=FOnResizing, write=FOnResizing};
	__property System::Classes::TNotifyEvent OnSelected = {read=FOnSelected, write=FOnSelected};
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Selector */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_SELECTOR)
using namespace Fmxtee::Tools::Selector;
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
#endif	// Fmxtee_Tools_SelectorHPP
