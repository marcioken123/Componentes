// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.TagCloud.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_TagcloudHPP
#define Fmxtee_Series_TagcloudHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.Surface.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Tagcloud
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTagCloudSeries;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TDrawTagEvent)(TTagCloudSeries* Sender, int ValueIndex);

enum DECLSPEC_DENUM TTagCloudOrder : unsigned char { toText, toValue, toNone };

class PASCALIMPLEMENTATION TTagCloudSeries : public Fmxtee::Series::Surface::TCustom3DPaletteSeries
{
	typedef Fmxtee::Series::Surface::TCustom3DPaletteSeries inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRectF> _TTagCloudSeries__1;
	
	
private:
	System::UnicodeString FFilter;
	Fmxtee::Canvas::TTeeFont* FFont;
	int FSeparation;
	TDrawTagEvent FOnDrawTag;
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetFilter(const System::UnicodeString Value);
	void __fastcall SetFont(Fmxtee::Canvas::TTeeFont* const Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetSeparation(const int Value);
	bool __fastcall ShouldDraw(int ValueIndex);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall DrawAllValues();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareLegendCanvas(int ValueIndex, System::Uitypes::TAlphaColor &BackColor, Fmx::Graphics::TBrushKind &BrushStyle);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	_TTagCloudSeries__1 Positions;
	__fastcall virtual TTagCloudSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTagCloudSeries();
	int __fastcall AddTag(const System::UnicodeString Text, const double Value);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	float __fastcall GetTagFontSize(int ValueIndex);
	void __fastcall Sort(TTagCloudOrder SortBy, Fmxtee::Engine::TChartListOrder Order = (Fmxtee::Engine::TChartListOrder)(0x1));
	virtual bool __fastcall UseAxis();
	
__published:
	__property System::UnicodeString Filter = {read=FFilter, write=SetFilter};
	__property Fmxtee::Canvas::TTeeFont* Font = {read=FFont, write=SetFont};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property int TagSeparation = {read=FSeparation, write=SetSeparation, default=5};
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
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
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
	__property Brush;
	__property EndColor = {default=-1};
	__property MidColor = {default=0};
	__property LegendEvery = {default=1};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property StartColor = {default=-16777088};
	__property UseColorRange = {default=1};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property XValues;
	__property YValues;
	__property TDrawTagEvent OnDrawTag = {read=FOnDrawTag, write=FOnDrawTag};
	__property OnGetColor;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Tagcloud */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_TAGCLOUD)
using namespace Fmxtee::Series::Tagcloud;
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
#endif	// Fmxtee_Series_TagcloudHPP
