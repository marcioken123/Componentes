// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTreeMapSeries.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetreemapseriesHPP
#define Vcltee_TeetreemapseriesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeOrgSeries.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetreemapseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeMapItem;
class DELPHICLASS TTreeMapSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeMapItem : public Vcltee::Teeorgseries::TOrgItem
{
	typedef Vcltee::Teeorgseries::TOrgItem inherited;
	
private:
	double __fastcall GetValue();
	void __fastcall SetValue(const double Value);
	
__published:
	__property double Value = {read=GetValue, write=SetValue};
public:
	/* TOrgItem.Destroy */ inline __fastcall virtual ~TTreeMapItem() { }
	
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TTreeMapItem(System::Classes::TCollection* Collection) : Vcltee::Teeorgseries::TOrgItem(Collection) { }
	
};


enum DECLSPEC_DENUM TTreeMapTiling : unsigned char { tmSlice, tmStrip };

enum DECLSPEC_DENUM TTreeMapColorStyle : unsigned char { csByLevel, csByValue };

class PASCALIMPLEMENTATION TTreeMapSeries : public Vcltee::Teeorgseries::TCustomOrgSeries
{
	typedef Vcltee::Teeorgseries::TCustomOrgSeries inherited;
	
public:
	TTreeMapItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TTreeMapColorStyle FColorStyle;
	TTreeMapTiling FMapStyle;
	Vcltee::Teesurfa::TSeriesColorPalette* FPalette;
	HIDESBASE TTreeMapItem* __fastcall GetItem(int Index);
	int __fastcall GetPaletteSteps();
	void __fastcall SetColorStyle(const TTreeMapColorStyle Value);
	HIDESBASE void __fastcall SetItem(int Index, TTreeMapItem* const Value);
	void __fastcall SetMapStyle(const TTreeMapTiling Value);
	void __fastcall SetPalette(Vcltee::Teesurfa::TSeriesColorPalette* const Value);
	void __fastcall SetPaletteSteps(const int Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::Uitypes::TColor __fastcall GetValueColor(int ValueIndex);
	
public:
	__fastcall virtual TTreeMapSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTreeMapSeries();
	HIDESBASE int __fastcall Add(const double AValue, const System::UnicodeString Text, int Superior = 0xffffffff, System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000))/* overload */;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC bool __fastcall IsValidSourceOf(Vcltee::Teengine::TChartSeries* Value);
	__property TTreeMapItem* Item[int Index] = {read=GetItem, write=SetItem/*, default*/};
	DYNAMIC int __fastcall NumSampleValues();
	
__published:
	__property Format;
	__property Items;
	__property Spacing;
	__property TTreeMapColorStyle ColorStyle = {read=FColorStyle, write=SetColorStyle, default=0};
	__property TTreeMapTiling MapStyle = {read=FMapStyle, write=SetMapStyle, default=0};
	__property Vcltee::Teesurfa::TSeriesColorPalette* Palette = {read=FPalette, write=SetPalette};
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
	inline int __fastcall  Add(const System::UnicodeString Text, int Superior = 0xffffffff){ return Vcltee::Teeorgseries::TCustomOrgSeries::Add(Text, Superior); }
	inline int __fastcall  Add(const double AValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000)){ return Vcltee::Teengine::TChartSeries::Add(AValue, ALabel, AColor); }
	inline int __fastcall  Add(const double *ADetail, const int ADetail_High, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000)){ return Vcltee::Teengine::TChartSeries::Add(ADetail, ADetail_High, ALabel, AColor); }
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetreemapseries */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETREEMAPSERIES)
using namespace Vcltee::Teetreemapseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetreemapseriesHPP
