// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Bubble.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Series_BubbleHPP
#define Fmxtee_Series_BubbleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Bubble
{
//-- forward type declarations -----------------------------------------------
struct TPointerSizes;
class DELPHICLASS TCustomBubbleSeries;
class DELPHICLASS TBubbleSeries;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TPointerSizes
{
public:
	int X;
	int Y;
	float Size;
};


class PASCALIMPLEMENTATION TCustomBubbleSeries : public Fmxtee::Series::TPointSeries
{
	typedef Fmxtee::Series::TPointSeries inherited;
	
private:
	Fmxtee::Engine::TChartValueList* FRadiusValues;
	void __fastcall RestorePointer(const TPointerSizes &Value);
	TPointerSizes __fastcall SavePointer();
	void __fastcall SetRadiusValues(Fmxtee::Engine::TChartValueList* Value);
	
protected:
	virtual float __fastcall CalcPointerSize(const int ValueIndex);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual void __fastcall PreparePointer(int ValueIndex);
	
public:
	__fastcall virtual TCustomBubbleSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddBubble(const double AX, const double AY, const double ARadius, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	
__published:
	__property Fmxtee::Engine::TChartValueList* RadiusValues = {read=FRadiusValues, write=SetRadiusValues};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TCustomBubbleSeries() { }
	
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
};


class PASCALIMPLEMENTATION TBubbleSeries : public TCustomBubbleSeries
{
	typedef TCustomBubbleSeries inherited;
	
private:
	bool FSquared;
	double __fastcall ApplyRadius(const double Value, Fmxtee::Engine::TChartValueList* const AList, bool Increment);
	void __fastcall SetSquared(bool Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRectF &Rect);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	virtual bool __fastcall IsPointInChartRect(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall PreparePointer(int ValueIndex);
	DYNAMIC void __fastcall RecalcAxisMargins(Fmxtee::Engine::TChartAxis* const Axis, System::Types::TRectF &R);
	
public:
	__fastcall virtual TBubbleSeries(System::Classes::TComponent* AOwner);
	DYNAMIC int __fastcall NumSampleValues();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall MaxZValue();
	virtual double __fastcall MinZValue();
	
__published:
	__property ColorEachPoint = {default=1};
	__property bool Squared = {read=FSquared, write=SetSquared, default=1};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TBubbleSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Bubble */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_BUBBLE)
using namespace Fmxtee::Series::Bubble;
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
#endif	// Fmxtee_Series_BubbleHPP
