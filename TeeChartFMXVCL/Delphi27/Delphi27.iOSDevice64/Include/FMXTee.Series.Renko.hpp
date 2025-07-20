// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Renko.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_RenkoHPP
#define Fmxtee_Series_RenkoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Renko
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRenkoSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRenkoSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
private:
	double FBoxSize;
	System::Uitypes::TAlphaColor FDownSwing;
	bool FDraw3D;
	System::Uitypes::TAlphaColor FUpSwing;
	double IMin;
	double IMax;
	Fmxtee::Canvas::TTeeBlend* IBlend;
	int __fastcall CalcBricks(bool Draw);
	void __fastcall CompareMinMax(const double Value);
	Fmxtee::Engine::TChartValueList* __fastcall GetCloseValues();
	void __fastcall SetBoxSize(const double Value);
	void __fastcall SetDownSwing(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetDraw3D(const bool Value);
	void __fastcall SetUpSwing(const System::Uitypes::TAlphaColor Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	int __fastcall CalcNumBricks(const double Current, const double Previous);
	virtual void __fastcall DrawAllValues();
	void __fastcall DrawBrick(const double low, const double high, int Index);
	void __fastcall DrawBricks(const double Start, int StartIndex, int NumBricks, bool UpTrend);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TRenkoSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CountLegendItems();
	virtual System::Uitypes::TAlphaColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Fmxtee::Engine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	DYNAMIC int __fastcall NumSampleValues();
	virtual void __fastcall CalcFirstLastVisibleIndex();
	__property Fmxtee::Engine::TChartValueList* CloseValues = {read=GetCloseValues};
	
__published:
	__property double BoxSize = {read=FBoxSize, write=SetBoxSize};
	__property System::Uitypes::TAlphaColor DownSwingColor = {read=FDownSwing, write=SetDownSwing, default=-16777216};
	__property bool Draw3D = {read=FDraw3D, write=SetDraw3D, default=1};
	__property Transparency = {default=0};
	__property System::Uitypes::TAlphaColor UpSwingColor = {read=FUpSwing, write=SetUpSwing, default=-1};
	__property Active = {default=1};
	__property Brush;
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property Pen;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property XValues;
	__property YValues;
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
public:
	/* TChartSeries.Destroy */ inline __fastcall virtual ~TRenkoSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Renko */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_RENKO)
using namespace Fmxtee::Series::Renko;
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
#endif	// Fmxtee_Series_RenkoHPP
