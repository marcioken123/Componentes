// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTagCloud.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetagcloudHPP
#define Vcltee_TeetagcloudHPP

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
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeSurfa.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetagcloud
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTagCloudSeries;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TDrawTagEvent)(TTagCloudSeries* Sender, int ValueIndex);

enum DECLSPEC_DENUM TTagCloudOrder : unsigned char { toText, toValue, toNone };

class PASCALIMPLEMENTATION TTagCloudSeries : public Vcltee::Teesurfa::TCustom3DPaletteSeries
{
	typedef Vcltee::Teesurfa::TCustom3DPaletteSeries inherited;
	
	
private:
	typedef System::DynamicArray<System::Types::TRect> _TTagCloudSeries__1;
	
	
private:
	System::UnicodeString FFilter;
	Vcltee::Tecanvas::TTeeFont* FFont;
	int FSeparation;
	TDrawTagEvent FOnDrawTag;
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	void __fastcall SetFilter(const System::UnicodeString Value);
	void __fastcall SetFont(Vcltee::Tecanvas::TTeeFont* const Value);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetSeparation(const int Value);
	bool __fastcall ShouldDraw(int ValueIndex);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DrawAllValues();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall PrepareLegendCanvas(int ValueIndex, System::Uitypes::TColor &BackColor, Vcl::Graphics::TBrushStyle &BrushStyle);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	_TTagCloudSeries__1 Positions;
	__fastcall virtual TTagCloudSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TTagCloudSeries();
	int __fastcall AddTag(const System::UnicodeString Text, const double Value);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	int __fastcall GetTagFontSize(int ValueIndex);
	void __fastcall Sort(TTagCloudOrder SortBy, Vcltee::Teengine::TChartListOrder Order = (Vcltee::Teengine::TChartListOrder)(0x1));
	virtual bool __fastcall UseAxis();
	
__published:
	__property System::UnicodeString Filter = {read=FFilter, write=SetFilter};
	__property Vcltee::Tecanvas::TTeeFont* Font = {read=FFont, write=SetFont};
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
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
	__property EndColor = {default=16777215};
	__property MidColor = {default=536870911};
	__property LegendEvery = {default=1};
	__property Pen;
	__property PaletteMin = {default=0};
	__property PaletteStep = {default=0};
	__property PaletteSteps = {default=32};
	__property PaletteStyle = {default=0};
	__property StartColor = {default=8388608};
	__property UseColorRange = {default=1};
	__property UsePalette = {default=0};
	__property UsePaletteMin = {default=0};
	__property XValues;
	__property YValues;
	__property TDrawTagEvent OnDrawTag = {read=FOnDrawTag, write=FOnDrawTag};
	__property OnGetColor;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetagcloud */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETAGCLOUD)
using namespace Vcltee::Teetagcloud;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetagcloudHPP
