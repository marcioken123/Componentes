// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.TreeMap.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_TreemapHPP
#define Fmxtee_Series_TreemapHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Constants.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Series.Organizational.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Treemap
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeMapItem;
class DELPHICLASS TTreeMapSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeMapItem : public Fmxtee::Series::Organizational::TOrgItem
{
	typedef Fmxtee::Series::Organizational::TOrgItem inherited;
	
private:
	double __fastcall GetValue();
	void __fastcall SetValue(const double Value);
	
__published:
	__property double Value = {read=GetValue, write=SetValue};
public:
	/* TOrgItem.Destroy */ inline __fastcall virtual ~TTreeMapItem() { }
	
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TTreeMapItem(System::Classes::TCollection* Collection) : Fmxtee::Series::Organizational::TOrgItem(Collection) { }
	
};


enum DECLSPEC_DENUM TTreeMapTiling : unsigned char { tmSlice, tmStrip };

enum DECLSPEC_DENUM TTreeMapColorStyle : unsigned char { csByLevel, csByValue };

class PASCALIMPLEMENTATION TTreeMapSeries : public Fmxtee::Series::Organizational::TCustomOrgSeries
{
	typedef Fmxtee::Series::Organizational::TCustomOrgSeries inherited;
	
public:
	TTreeMapItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TTreeMapColorStyle FColorStyle;
	TTreeMapTiling FMapStyle;
	Fmxtee::Series::Surface::TSeriesColorPalette* FPalette;
	HIDESBASE TTreeMapItem* __fastcall GetItem(int Index);
	int __fastcall GetPaletteSteps();
	void __fastcall SetColorStyle(const TTreeMapColorStyle Value);
	HIDESBASE void __fastcall SetItem(int Index, TTreeMapItem* const Value);
	void __fastcall SetMapStyle(const TTreeMapTiling Value);
	void __fastcall SetPalette(Fmxtee::Series::Surface::TSeriesColorPalette* const Value);
	void __fastcall SetPaletteSteps(const int Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::Uitypes::TAlphaColor __fastcall GetValueColor(int ValueIndex);
	
public:
	__fastcall virtual TTreeMapSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTreeMapSeries();
	HIDESBASE int __fastcall Add(const double AValue, const System::UnicodeString Text, int Superior = 0xffffffff, System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff))/* overload */;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	__property TTreeMapItem* Item[int Index] = {read=GetItem, write=SetItem/*, default*/};
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property Format;
	__property Items;
	__property Spacing;
	__property TTreeMapColorStyle ColorStyle = {read=FColorStyle, write=SetColorStyle, default=0};
	__property TTreeMapTiling MapStyle = {read=FMapStyle, write=SetMapStyle, default=0};
	__property Fmxtee::Series::Surface::TSeriesColorPalette* Palette = {read=FPalette, write=SetPalette};
	__property int PaletteSteps = {read=GetPaletteSteps, write=SetPaletteSteps, default=10};
	__property XValues;
	__property YValues;
	__property Active = {default=1};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property Transparency = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property Brush;
	__property Pen;
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
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Add(const System::UnicodeString Text, int Superior = 0xffffffff){ return Fmxtee::Series::Organizational::TCustomOrgSeries::Add(Text, Superior); }
	inline int __fastcall  Add(const double AValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff)){ return Fmxtee::Engine::TChartSeries::Add(AValue, ALabel, AColor); }
	inline int __fastcall  Add(const double *ADetail, const int ADetail_High, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff)){ return Fmxtee::Engine::TChartSeries::Add(ADetail, ADetail_High, ALabel, AColor); }
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Treemap */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_TREEMAP)
using namespace Fmxtee::Series::Treemap;
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
#endif	// Fmxtee_Series_TreemapHPP
