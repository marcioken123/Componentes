// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.BubbleCh.pas' rev: 34.00 (Windows)

#ifndef Vcltee_BubblechHPP
#define Vcltee_BubblechHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Bubblech
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


class PASCALIMPLEMENTATION TCustomBubbleSeries : public Vcltee::Series::TPointSeries
{
	typedef Vcltee::Series::TPointSeries inherited;
	
private:
	Vcltee::Teengine::TChartValueList* FRadiusValues;
	void __fastcall RestorePointer(const TPointerSizes &Value);
	TPointerSizes __fastcall SavePointer();
	void __fastcall SetRadiusValues(Vcltee::Teengine::TChartValueList* Value);
	
protected:
	virtual float __fastcall CalcPointerSize(const int ValueIndex);
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual void __fastcall PreparePointer(int ValueIndex);
	
public:
	__fastcall virtual TCustomBubbleSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddBubble(const double AX, const double AY, const double ARadius, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	DYNAMIC bool __fastcall IsValidSourceOf(Vcltee::Teengine::TChartSeries* Value);
	
__published:
	__property Vcltee::Teengine::TChartValueList* RadiusValues = {read=FRadiusValues, write=SetRadiusValues};
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TCustomBubbleSeries() { }
	
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
};


class PASCALIMPLEMENTATION TBubbleSeries : public TCustomBubbleSeries
{
	typedef TCustomBubbleSeries inherited;
	
private:
	bool FSquared;
	double __fastcall ApplyRadius(const double Value, Vcltee::Teengine::TChartValueList* const AList, bool Increment);
	void __fastcall SetSquared(bool Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DrawLegendShape(int ValueIndex, const System::Types::TRect &Rect);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	virtual bool __fastcall IsPointInChartRect(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall PreparePointer(int ValueIndex);
	DYNAMIC void __fastcall RecalcAxisMargins(Vcltee::Teengine::TChartAxis* const Axis, System::Types::TRect &R);
	
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
}	/* namespace Bubblech */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_BUBBLECH)
using namespace Vcltee::Bubblech;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_BubblechHPP
