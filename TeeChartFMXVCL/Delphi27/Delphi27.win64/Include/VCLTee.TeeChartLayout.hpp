// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeChartLayout.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeechartlayoutHPP
#define Vcltee_TeechartlayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teechartlayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartItem;
class DELPHICLASS TChartCollection;
class DELPHICLASS TChartLayout;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChartItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Vcltee::Chart::TChart* FChart;
	Vcltee::Chart::TChart* __fastcall GetChart();
	void __fastcall ReadChart(System::Classes::TStream* Stream);
	void __fastcall SetChart(Vcltee::Chart::TChart* const Value);
	void __fastcall WriteChart(System::Classes::TStream* Stream);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TChartItem(System::Classes::TCollection* Collection)/* overload */;
	__fastcall virtual ~TChartItem();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcltee::Chart::TChart* Chart = {read=GetChart, write=SetChart, stored=false};
};


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
	Vcltee::Chart::TChart* __fastcall AddChart(const System::UnicodeString ATitle = System::UnicodeString());
	TChartItem* __fastcall Clone(Vcltee::Chart::TChart* const AChart);
	__property TChartItem* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TChartCollection(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TChartCollection() { }
	
};


class PASCALIMPLEMENTATION TChartLayout : public Vcl::Forms::TScrollBox
{
	typedef Vcl::Forms::TScrollBox inherited;
	
private:
	int FChartHeight;
	TChartCollection* FCharts;
	int FChartWidth;
	int FColumns;
	int __fastcall CalcColumns(/* out */ int &W, /* out */ int &H);
	bool __fastcall GetView3D();
	bool __fastcall IsVisible(TChartItem* const Item);
	void __fastcall SetChartHeight(const int Value);
	void __fastcall SetCharts(TChartCollection* const Value);
	void __fastcall SetChartWidth(const int Value);
	void __fastcall SetColumns(const int Value);
	void __fastcall SetView3D(const bool Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TChartLayout(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TChartLayout();
	Vcltee::Chart::TChart* __fastcall Add(const System::UnicodeString Title)/* overload */;
	void __fastcall Add(Vcltee::Teengine::TSeriesDetail* const Detail)/* overload */;
	Vcl::Graphics::TBitmap* __fastcall Bitmap();
	void __fastcall Clear();
	int __fastcall Count();
	void __fastcall Relayout();
	__property bool View3D = {read=GetView3D, write=SetView3D, nodefault};
	
__published:
	__property BorderStyle = {default=0};
	__property TChartCollection* Charts = {read=FCharts, write=SetCharts};
	__property int ChartHeight = {read=FChartHeight, write=SetChartHeight, default=250};
	__property int ChartWidth = {read=FChartWidth, write=SetChartWidth, default=400};
	__property int Columns = {read=FColumns, write=SetColumns, default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartLayout(HWND ParentWindow) : Vcl::Forms::TScrollBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teechartlayout */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECHARTLAYOUT)
using namespace Vcltee::Teechartlayout;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeechartlayoutHPP
