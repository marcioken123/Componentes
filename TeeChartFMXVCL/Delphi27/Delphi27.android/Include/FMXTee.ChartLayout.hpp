// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.ChartLayout.pas' rev: 34.00 (Android)

#ifndef Fmxtee_ChartlayoutHPP
#define Fmxtee_ChartlayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <FMX.Layouts.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.SubChart.hpp>
#include <FMX.Controls.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Chartlayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartItem;
class DELPHICLASS TChartCollection;
class DELPHICLASS TChartLayout;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Fmxtee::Chart::TChart* FChart;
	Fmxtee::Chart::TChart* __fastcall GetChart();
	void __fastcall ReadChart(System::Classes::TStream* Stream);
	void __fastcall SetChart(Fmxtee::Chart::TChart* const Value);
	void __fastcall WriteChart(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TChartItem(System::Classes::TCollection* Collection)/* overload */;
	__fastcall virtual ~TChartItem();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Fmxtee::Chart::TChart* Chart = {read=GetChart, write=SetChart, stored=false};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartCollection : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TChartItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TChartLayout* IOwner;
	TChartItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TChartItem* const Value);
	
protected:
	virtual void __fastcall Notify(System::Classes::TCollectionItem* Item, System::Generics::Collections::TCollectionNotification Action);
	
public:
	Fmxtee::Chart::TChart* __fastcall AddChart(const System::UnicodeString ATitle = System::UnicodeString());
	TChartItem* __fastcall Clone(Fmxtee::Chart::TChart* const AChart);
	__property TChartItem* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TChartCollection(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TChartCollection() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TChartLayout : public Fmx::Layouts::TScrollBox
{
	typedef Fmx::Layouts::TScrollBox inherited;
	
private:
	int FChartHeight;
	TChartCollection* FCharts;
	int FChartWidth;
	int FColumns;
	int __fastcall CalcColumns(/* out */ int &W, /* out */ int &H);
	bool __fastcall GetView3D();
	HIDESBASE bool __fastcall IsVisible(TChartItem* const Item);
	void __fastcall SetChartHeight(const int Value);
	void __fastcall SetCharts(TChartCollection* const Value);
	void __fastcall SetChartWidth(const int Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetView3D(const bool Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TChartLayout(System::Classes::TComponent* AOwner)/* overload */;
	__fastcall virtual ~TChartLayout();
	Fmxtee::Chart::TChart* __fastcall Add(const System::UnicodeString Title)/* overload */;
	void __fastcall Add(Fmxtee::Engine::TSeriesDetail* const Detail)/* overload */;
	Fmx::Graphics::TBitmap* __fastcall Bitmap();
	void __fastcall Clear();
	int __fastcall Count();
	void __fastcall Relayout();
	__property bool View3D = {read=GetView3D, write=SetView3D, nodefault};
	
__published:
	__property TChartCollection* Charts = {read=FCharts, write=SetCharts};
	__property int ChartHeight = {read=FChartHeight, write=SetChartHeight, default=250};
	__property int ChartWidth = {read=FChartWidth, write=SetChartWidth, default=400};
	__property int Columns = {read=FColumns, write=SetColumns, default=0};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Chartlayout */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CHARTLAYOUT)
using namespace Fmxtee::Chartlayout;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_ChartlayoutHPP
