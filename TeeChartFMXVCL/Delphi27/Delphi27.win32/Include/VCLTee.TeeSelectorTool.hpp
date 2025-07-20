// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSelectorTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeselectortoolHPP
#define Vcltee_TeeselectortoolHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeselectortool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSelectorTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSelectorTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
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
	Vcltee::Teetools::TAnnotationTool* FAnnotation;
	bool FDrawHandles;
	Vcltee::Chart::TTeeCustomShapePosition* FShape;
	Vcltee::Chart::TChartWall* FWall;
	bool IDragging;
	bool IDragged;
	System::Types::TPoint IDif;
	bool IResizingChart;
	bool IResized;
	void __fastcall EmptySelection();
	System::Classes::TPersistent* __fastcall GetSelection();
	Vcltee::Teengine::TChartSeries* __fastcall GetSeries();
	void __fastcall SetHandleSize(const int Value);
	void __fastcall SetAnnotation(Vcltee::Teetools::TAnnotationTool* const Value);
	void __fastcall SetWall(Vcltee::Chart::TChartWall* const Value);
	void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	
protected:
	virtual void __fastcall ChartEvent(Vcltee::Teengine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoSelected();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	void __fastcall TeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
	
public:
	Vcltee::Teengine::TChartClickedPart Part;
	__fastcall virtual TSelectorTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSelectorTool();
	void __fastcall ClearSelection();
	void __fastcall StopDragging();
	bool __fastcall ClickedCorner(int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	Vcltee::Chart::TChartTitle* __fastcall SelectedTitle();
	__property Vcltee::Teetools::TAnnotationTool* Annotation = {read=FAnnotation, write=SetAnnotation};
	__property Vcltee::Chart::TTeeCustomShapePosition* DraggingShape = {read=FShape};
	__property bool DrawHandles = {read=FDrawHandles, write=FDrawHandles, nodefault};
	__property System::Classes::TPersistent* Selection = {read=GetSelection};
	__property Vcltee::Teengine::TChartSeries* Series = {read=GetSeries, write=SetSeries};
	__property Vcltee::Chart::TChartWall* Wall = {read=FWall, write=SetWall};
	
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
	void *__ITeeEventListener;	// Vcltee::Teeprocs::ITeeEventListener 
	
public:
	operator Vcltee::Teeprocs::ITeeEventListener*(void) { return (Vcltee::Teeprocs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeselectortool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESELECTORTOOL)
using namespace Vcltee::Teeselectortool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeselectortoolHPP
