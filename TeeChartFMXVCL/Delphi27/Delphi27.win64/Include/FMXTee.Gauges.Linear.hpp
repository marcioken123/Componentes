// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Gauges.Linear.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Gauges_LinearHPP
#define Fmxtee_Gauges_LinearHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UIConsts.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.ProConstants.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Gauges.Numeric.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Gauges
{
namespace Linear
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGaugeSeriesPointer;
class DELPHICLASS TGaugePointerRange;
class DELPHICLASS TGaugeRange;
class DELPHICLASS TGaugeRanges;
class DELPHICLASS TCustomGaugeMinMax;
class DELPHICLASS TLinearGauge;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TGaugePointerStyles : unsigned char { gpHand, gpCenter, gpTick, gpMinorTick, gpColorLine };

class PASCALIMPLEMENTATION TGaugeSeriesPointer : public Fmxtee::Engine::TSeriesPointer
{
	typedef Fmxtee::Engine::TSeriesPointer inherited;
	
private:
	TGaugePointerStyles FGaugeStyle;
	void __fastcall SetGaugeStyle(const TGaugePointerStyles Value);
	
protected:
	int PXMinus;
	int PXPlus;
	int PYMinus;
	int PYPlus;
	int PXMinusSmall;
	int PXPlusSmall;
	int PYMinusSmall;
	int PYPlusSmall;
	double IStartAngle;
	void __fastcall SetValues(int x, int y, int horiz, int vert);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE void __fastcall Draw(const System::Types::TPointF &Inner, const System::Types::TPointF &InnerPlus, const System::Types::TPointF &InnerMinus, const System::Types::TPointF &Outer, const System::Types::TPointF &OuterPlus, const System::Types::TPointF &OuterMinus)/* overload */;
	
__published:
	__property TGaugePointerStyles GaugeStyle = {read=FGaugeStyle, write=SetGaugeStyle, nodefault};
public:
	/* TSeriesPointer.Create */ inline __fastcall TGaugeSeriesPointer(Fmxtee::Engine::TChartSeries* const AOwner) : Fmxtee::Engine::TSeriesPointer(AOwner) { }
	/* TSeriesPointer.Destroy */ inline __fastcall virtual ~TGaugeSeriesPointer() { }
	
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  Draw(const System::Types::TPointF &P){ Fmxtee::Engine::TSeriesPointer::Draw(P); }
	inline void __fastcall  Draw(int X, int Y){ Fmxtee::Engine::TSeriesPointer::Draw(X, Y); }
	inline void __fastcall  Draw(int px, int py, System::Uitypes::TAlphaColor ColorValue, Fmxtee::Engine::TSeriesPointerStyle AStyle){ Fmxtee::Engine::TSeriesPointer::Draw(px, py, ColorValue, AStyle); }
	
};


class PASCALIMPLEMENTATION TGaugePointerRange : public TGaugeSeriesPointer
{
	typedef TGaugeSeriesPointer inherited;
	
private:
	double FEndValue;
	int FPosition;
	bool FSpiralled;
	double FStartValue;
	void __fastcall SetEndValue(const double Value);
	void __fastcall SetPosition(const int Value);
	void __fastcall SetSpiralled(const bool Value);
	void __fastcall SetStartValue(const double Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE void __fastcall Draw(const double StartAngle, const double EndAngle, const System::Types::TRectF &Rectangle);
	
__published:
	__property double EndValue = {read=FEndValue, write=SetEndValue};
	__property int Position = {read=FPosition, write=SetPosition, default=50};
	__property bool Spiralled = {read=FSpiralled, write=SetSpiralled, default=1};
	__property double StartValue = {read=FStartValue, write=SetStartValue};
public:
	/* TSeriesPointer.Create */ inline __fastcall TGaugePointerRange(Fmxtee::Engine::TChartSeries* const AOwner) : TGaugeSeriesPointer(AOwner) { }
	/* TSeriesPointer.Destroy */ inline __fastcall virtual ~TGaugePointerRange() { }
	
};


class PASCALIMPLEMENTATION TGaugeRange : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TGaugePointerRange* FFormat;
	double __fastcall GetEndValue();
	double __fastcall GetStartValue();
	void __fastcall SetEndValue(const double Value);
	void __fastcall SetFormat(TGaugePointerRange* const Value);
	void __fastcall SetStartValue(const double Value);
	
public:
	__fastcall virtual TGaugeRange(System::Classes::TCollection* Collection);
	__fastcall virtual ~TGaugeRange();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property double EndValue = {read=GetEndValue, write=SetEndValue};
	__property double StartValue = {read=GetStartValue, write=SetStartValue};
	
__published:
	__property TGaugePointerRange* Format = {read=FFormat, write=SetFormat};
};


class PASCALIMPLEMENTATION TGaugeRanges : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TGaugeRange* operator[](int Index) { return this->Items[Index]; }
	
private:
	TGaugeRange* __fastcall Get(int Index);
	void __fastcall Put(int Index, TGaugeRange* const Value);
	
public:
	HIDESBASE TGaugeRange* __fastcall Add(const double StartValue, const double EndValue, const System::Uitypes::TAlphaColor Color = (System::Uitypes::TAlphaColor)(0xff000000));
	__property TGaugeRange* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TGaugeRanges(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGaugeRanges() { }
	
};


class PASCALIMPLEMENTATION TCustomGaugeMinMax : public Fmxtee::Gauges::Numeric::TCustomGauge
{
	typedef Fmxtee::Gauges::Numeric::TCustomGauge inherited;
	
private:
	bool FAllowDrag;
	TGaugeRanges* FAxisRanges;
	TGaugeSeriesPointer* FHand;
	bool FHorizontal;
	double FMaximum;
	double FMinimum;
	int FMinorDist;
	TGaugeSeriesPointer* FMinorTicks;
	TGaugeRanges* FRanges;
	TGaugeSeriesPointer* FTicks;
	bool IAxisDone;
	bool __fastcall CanSetAxisOnce();
	TGaugeSeriesPointer* __fastcall CreateHand();
	TGaugePointerRange* __fastcall GetGreenLine();
	TGaugePointerRange* __fastcall GetRedLine();
	void __fastcall SetAxisRanges(TGaugeRanges* const Value);
	void __fastcall SetGreenLine(TGaugePointerRange* const Value);
	void __fastcall SetHand(TGaugeSeriesPointer* const Value);
	HIDESBASE void __fastcall SetHorizontal(const bool Value);
	void __fastcall SetMaximum(const double Value);
	void __fastcall SetMinorDist(const int Value);
	void __fastcall SetMinorTicks(TGaugeSeriesPointer* const Value);
	void __fastcall SetRanges(TGaugeRanges* const Value);
	void __fastcall SetRangesParentChart(TGaugeRanges* const ARanges);
	void __fastcall SetRedLine(TGaugePointerRange* const Value);
	void __fastcall SetTicks(TGaugeSeriesPointer* const Value);
	
protected:
	double IRange;
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawAxis() = 0 ;
	virtual void __fastcall DrawAxisMinorTick(const System::Types::TPointF &Inner, const System::Types::TPointF &Outer);
	virtual void __fastcall DrawAxisTick(const System::Types::TPointF &Inner, const System::Types::TPointF &InnerPlus, const System::Types::TPointF &InnerMinus, const System::Types::TPointF &Outer, const System::Types::TPointF &OuterPlus, const System::Types::TPointF &OuterMinus);
	virtual void __fastcall DrawColorLine(TGaugePointerRange* const Line);
	void __fastcall DrawColorLines();
	virtual void __fastcall DrawHand();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetAxisOnce();
	virtual void __fastcall SetGaugePalette(const System::Uitypes::TAlphaColor *Palette, const int Palette_High);
	virtual void __fastcall SetMinimum(const double Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetValues();
	
public:
	__fastcall virtual TCustomGaugeMinMax(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomGaugeMinMax();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual Fmxtee::Engine::TChartAxis* __fastcall Axis() = 0 ;
	__property bool AllowDrag = {read=FAllowDrag, write=FAllowDrag, default=1};
	__property TGaugeRanges* AxisRanges = {read=FAxisRanges, write=SetAxisRanges};
	__property TGaugePointerRange* GreenLine = {read=GetGreenLine, write=SetGreenLine};
	__property TGaugeSeriesPointer* Hand = {read=FHand, write=SetHand};
	__property bool Horizontal = {read=FHorizontal, write=SetHorizontal, default=1};
	__property double Maximum = {read=FMaximum, write=SetMaximum};
	__property double Minimum = {read=FMinimum, write=SetMinimum};
	__property int MinorTickDistance = {read=FMinorDist, write=SetMinorDist, default=0};
	__property TGaugeSeriesPointer* MinorTicks = {read=FMinorTicks, write=SetMinorTicks};
	__property TGaugeRanges* Ranges = {read=FRanges, write=SetRanges};
	__property TGaugePointerRange* RedLine = {read=GetRedLine, write=SetRedLine};
	__property TGaugeSeriesPointer* Ticks = {read=FTicks, write=SetTicks};
	
__published:
	__property ShowInLegend = {default=0};
};


class PASCALIMPLEMENTATION TLinearGauge : public TCustomGaugeMinMax
{
	typedef TCustomGaugeMinMax inherited;
	
private:
	TGaugeSeriesPointer* FMaxIndicator;
	bool FUseValuePalette;
	Fmxtee::Procs::TTeeShape* FValueArea;
	double IMaxValue;
	void __fastcall SetMaxIndicator(TGaugeSeriesPointer* const Value);
	void __fastcall SetUseValuePalette(const bool Value);
	void __fastcall SetValueArea(Fmxtee::Procs::TTeeShape* const Value);
	
protected:
	System::Types::TRectF IAxisRect;
	__classmethod virtual void __fastcall CreateSubGallery(Fmxtee::Engine::TChartSubGalleryProc AddSubChart);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawAxis();
	virtual void __fastcall DrawColorLine(TGaugePointerRange* const Line);
	virtual void __fastcall DrawHand();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetValue(const double AValue);
	virtual void __fastcall SetValues();
	__classmethod virtual void __fastcall SetSubGallery(Fmxtee::Engine::TChartSeries* ASeries, int Index);
	
public:
	__fastcall virtual TLinearGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLinearGauge();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual Fmxtee::Engine::TChartAxis* __fastcall Axis();
	virtual bool __fastcall UseAxis();
	__property bool Embedded = {read=IInternalUse, write=IInternalUse, nodefault};
	
__published:
	__property Active = {default=1};
	__property Cursor = {default=0};
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property ShowInLegend = {default=0};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property OnAfterAdd;
	__property OnBeforeAdd;
	__property OnChange;
	__property OnClearValues;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property XLabelsSource = {default=0};
	__property XValues;
	__property YValues;
	__property AllowDrag = {default=1};
	__property Face;
	__property Frame;
	__property GreenLine = {stored=false};
	__property Hand = {stored=false};
	__property Horizontal = {default=1};
	__property Maximum = {default=0};
	__property TGaugeSeriesPointer* MaxValueIndicator = {read=FMaxIndicator, write=SetMaxIndicator};
	__property Minimum = {default=0};
	__property MinorTickDistance = {default=0};
	__property MinorTicks;
	__property Ranges;
	__property RedLine = {stored=false};
	__property Ticks;
	__property bool UseValueColorPalette = {read=FUseValuePalette, write=SetUseValuePalette, default=0};
	__property Value = {default=0};
	__property Fmxtee::Procs::TTeeShape* ValueArea = {read=FValueArea, write=SetValueArea};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Linear */
}	/* namespace Gauges */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_GAUGES_LINEAR)
using namespace Fmxtee::Gauges::Linear;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_GAUGES)
using namespace Fmxtee::Gauges;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Gauges_LinearHPP
