// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.SubChart.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Tools_SubchartHPP
#define Fmxtee_Tools_SubchartHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Graphics.hpp>
#include <System.UIConsts.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Procs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Subchart
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSubChart;
class DELPHICLASS TChartCollection;
class DELPHICLASS TSubChartTool;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TSubChart : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	bool FAllowDrag;
	bool FAllowResize;
	Fmxtee::Chart::TChart* FChart;
	System::Classes::TNotifyEvent FOnDragged;
	System::Classes::TNotifyEvent FOnDragging;
	System::Classes::TNotifyEvent FOnResized;
	System::Classes::TNotifyEvent FOnResizing;
	System::Types::TPointF P;
	bool IDrag;
	bool IResize;
	int IEdge;
	System::Types::TRectF ITempRect;
	Fmxtee::Engine::TTeeCustomTool* ITool;
	System::Types::TRectF __fastcall GetBounds();
	Fmxtee::Chart::TChart* __fastcall GetChart();
	int __fastcall GetHeight();
	int __fastcall GetLeft();
	int __fastcall GetTop();
	int __fastcall GetWidth();
	bool __fastcall GetResizing();
	void __fastcall ReadChart(System::Classes::TStream* Stream);
	void __fastcall SetChart(Fmxtee::Chart::TChart* const Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetLeft(const int Value);
	void __fastcall SetTop(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall WriteChart(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TSubChart(System::Classes::TCollection* Collection)/* overload */;
	__fastcall virtual ~TSubChart();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::Types::TRectF Bounds = {read=GetBounds};
	bool __fastcall Clicked(int x, int y);
	int __fastcall ClickedEdge(int x, int y);
	__property bool Dragging = {read=IDrag, nodefault};
	__property bool Resizing = {read=GetResizing, nodefault};
	
__published:
	__property bool AllowDrag = {read=FAllowDrag, write=FAllowDrag, default=0};
	__property bool AllowResize = {read=FAllowResize, write=FAllowResize, default=0};
	__property Fmxtee::Chart::TChart* Chart = {read=GetChart, write=SetChart, stored=false};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	__property int Left = {read=GetLeft, write=SetLeft, nodefault};
	__property int Top = {read=GetTop, write=SetTop, nodefault};
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	__property System::Classes::TNotifyEvent OnDragged = {read=FOnDragged, write=FOnDragged};
	__property System::Classes::TNotifyEvent OnDragging = {read=FOnDragging, write=FOnDragging};
	__property System::Classes::TNotifyEvent OnResized = {read=FOnResized, write=FOnResized};
	__property System::Classes::TNotifyEvent OnResizing = {read=FOnResizing, write=FOnResizing};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartCollection : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TSubChart* operator[](int Index) { return this->Items[Index]; }
	
private:
	TSubChartTool* IOwner;
	TSubChart* __fastcall Get(int Index);
	TSubChart* __fastcall GetLast();
	void __fastcall Put(int Index, TSubChart* const Value);
	
protected:
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Generics::Collections::TCollectionNotification Action);
	
public:
	Fmxtee::Chart::TChart* __fastcall AddChart(const System::UnicodeString AName = System::UnicodeString());
	TSubChart* __fastcall Clone(Fmxtee::Chart::TChart* const AChart);
	__property TSubChart* Last = {read=GetLast};
	__property TSubChart* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TChartCollection(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TChartCollection() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TSubChartEvent)(TSubChartTool* Sender, TSubChart* Item);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSubChartTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
	
private:
	typedef System::DynamicArray<Fmxtee::Chart::TCustomChart*> _TSubChartTool__1;
	
	
private:
	TChartCollection* FCharts;
	TSubChartEvent FOnAdded;
	TSubChartEvent FOnDeleting;
	bool FIsScroller;
	_TSubChartTool__1 IToDestroy;
	void __fastcall AddToDestroy(Fmxtee::Chart::TCustomChart* const AChart);
	void __fastcall DestroyPending();
	System::Uitypes::TCursor __fastcall GetCursor();
	void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Generics::Collections::TCollectionNotification Action);
	void __fastcall SetCharts(TChartCollection* const Value);
	void __fastcall SetCursor(const System::Uitypes::TCursor Value);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall ChartDragDropEvent(Fmxtee::Engine::TChartDragDropEvent AEvent, System::TObject* Source, int X, int Y, Fmxtee::Engine::TDragState State, bool &Accept, Fmx::Types::TDragObject &DragObject);
	virtual void __fastcall ChartKeyEvent(Fmxtee::Engine::TChartKeyEvent AEvent, System::Word &Key, System::WideChar &Key1, System::Classes::TShiftState Shift);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Loaded();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TSubChartTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TSubChartTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	void __fastcall GridLayout(const int AColumns = 0x0);
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property TChartCollection* Charts = {read=FCharts, write=SetCharts};
	__property System::Uitypes::TCursor Cursor = {read=GetCursor, write=SetCursor, default=0};
	__property bool IsScroller = {read=FIsScroller, write=FIsScroller, nodefault};
	__property TSubChartEvent OnAdded = {read=FOnAdded, write=FOnAdded};
	__property TSubChartEvent OnDeleting = {read=FOnDeleting, write=FOnDeleting};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Subchart */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_SUBCHART)
using namespace Fmxtee::Tools::Subchart;
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
#endif	// Fmxtee_Tools_SubchartHPP
