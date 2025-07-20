// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCircularGauge.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecirculargaugeHPP
#define Vcltee_TeecirculargaugeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeLinearGauge.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeNumericGauge.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecirculargauge
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGaugeHand;
class DELPHICLASS TGaugeHandItem;
class DELPHICLASS TGaugeHands;
class DELPHICLASS TCircularGauge;
class DELPHICLASS TClockGauge;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGaugeHand : public Vcltee::Teelineargauge::TGaugeSeriesPointer
{
	typedef Vcltee::Teelineargauge::TGaugeSeriesPointer inherited;
	
private:
	int FDistance;
	int FOffset;
	double FValue;
	void __fastcall SetDistance(const int Value);
	void __fastcall SetOffset(const int Value);
	void __fastcall SetValue(const double Value);
	
public:
	__fastcall TGaugeHand(Vcltee::Teengine::TChartSeries* const AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE void __fastcall Draw(const double Angle, const System::Types::TPoint &Center, const System::Types::TPoint &EndP, int Off);
	
__published:
	__property int Distance = {read=FDistance, write=SetDistance, default=30};
	__property HorizSize = {default=5};
	__property int Offset = {read=FOffset, write=SetOffset, default=80};
	__property double Value = {read=FValue, write=SetValue};
public:
	/* TSeriesPointer.Destroy */ inline __fastcall virtual ~TGaugeHand() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TGaugeHandItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TGaugeHand* FFormat;
	double __fastcall GetValue();
	void __fastcall SetFormat(TGaugeHand* const Value);
	void __fastcall SetValue(const double Value);
	
public:
	__fastcall virtual TGaugeHandItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TGaugeHandItem();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TGaugeHand* Format = {read=FFormat, write=SetFormat};
	__property double Value = {read=GetValue, write=SetValue};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGaugeHands : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TGaugeHandItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TGaugeHandItem* __fastcall Get(int Index);
	void __fastcall Put(int Index, TGaugeHandItem* const Value);
	
public:
	HIDESBASE TGaugeHandItem* __fastcall Add(const double AValue);
	__property TGaugeHandItem* Items[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TGaugeHands(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TGaugeHands() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TCircularGauge : public Vcltee::Teelineargauge::TCustomGaugeMinMax
{
	typedef Vcltee::Teelineargauge::TCustomGaugeMinMax inherited;
	
private:
	Vcltee::Teelineargauge::TGaugeSeriesPointer* FCenter;
	Vcltee::Teengine::TSeriesPointer* FEndPoint;
	TGaugeHands* FHands;
	bool FLabelsInside;
	bool FRotateLabels;
	double FTotalAngle;
	bool FCircled;
	double FRotAngle;
	int FXRadius;
	int FYRadius;
	Vcltee::Teenumericgauge::TNumericGauge* FNumericGauge;
	Vcltee::Teelineargauge::TLinearGauge* FLinearGauge;
	bool FAutoPositionNumericGauge;
	bool FAutoValueNumericGauge;
	bool FAutoPositionLinearGauge;
	bool FAutoValueLinearGauge;
	bool FFillToSemiCircle;
	System::Types::TRect __fastcall CalcLinearGaugeBounds();
	System::Types::TRect __fastcall CalcNumericGaugeBounds();
	Vcltee::Series::TCircularFrame* __fastcall CircularFrame();
	void __fastcall DrawEnd(const System::Types::TPoint &P);
	int __fastcall GetDisplayTotalAngle();
	int __fastcall GetDisplayRotationAngle();
	TGaugeHand* __fastcall GetHand();
	int __fastcall GetHandOffset();
	TGaugeHands* __fastcall GetHands();
	Vcltee::Teelineargauge::TLinearGauge* __fastcall GetLinearGauge();
	Vcltee::Teenumericgauge::TNumericGauge* __fastcall GetNumericGauge();
	void __fastcall SetCenter(Vcltee::Teelineargauge::TGaugeSeriesPointer* const Value);
	void __fastcall SetCircled(const bool Value);
	void __fastcall SetDisplayTotalAngle(const int Value);
	void __fastcall SetDisplayRotationAngle(const int Value);
	void __fastcall SetEndPoint(Vcltee::Teengine::TSeriesPointer* const Value);
	HIDESBASE void __fastcall SetHand(TGaugeHand* const Value);
	void __fastcall SetHandOffset(const int Value);
	void __fastcall SetHands(TGaugeHands* const Value);
	void __fastcall SetHandsParentChart();
	void __fastcall SetLabelsInside(const bool Value);
	void __fastcall SetLinearGauge(Vcltee::Teelineargauge::TLinearGauge* const Value);
	void __fastcall SetNumericGauge(Vcltee::Teenumericgauge::TNumericGauge* const Value);
	void __fastcall SetRotateLabels(const bool Value);
	void __fastcall SetRotAngle(const double Value);
	void __fastcall SetTotalAngle(const double Value);
	void __fastcall SetAutoPositionLinearGauge(const bool Value);
	void __fastcall SetAutoValueLinearGauge(const bool Value);
	void __fastcall SetAutoPositionNumericGauge(const bool Value);
	void __fastcall SetAutoValueNumericGauge(const bool Value);
	void __fastcall SetFillToSemicircle(const bool Value);
	
protected:
	System::Types::TPoint ICenter;
	double IStartAngle;
	int __fastcall CalcDistance(int Distance);
	virtual void __fastcall CalcOrigRect();
	System::Types::TPoint __fastcall CalcPoint(const double Angle, const System::Types::TPoint &Center, const double RadiusX, const double RadiusY);
	void __fastcall CalcRadius();
	double __fastcall CalcValue(const double AValue);
	__classmethod virtual void __fastcall CreateSubGallery(Vcltee::Teengine::TChartSubGalleryProc AddSubChart);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawAxis();
	virtual void __fastcall DrawAxisMinorTick(const System::Types::TPoint &Inner, const System::Types::TPoint &Outer);
	virtual void __fastcall DrawAxisTick(const System::Types::TPoint &Inner, const System::Types::TPoint &InnerPlus, const System::Types::TPoint &InnerMinus, const System::Types::TPoint &Outer, const System::Types::TPoint &OuterPlus, const System::Types::TPoint &OuterMinus);
	virtual void __fastcall DrawCenter();
	virtual void __fastcall DrawColorLine(Vcltee::Teelineargauge::TGaugePointerRange* const Line);
	void __fastcall DrawFrame();
	virtual void __fastcall DrawFace();
	virtual void __fastcall DrawHand();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual Vcltee::Series::TFramedBorder* __fastcall CreateFrame();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual System::UnicodeString __fastcall GetLabel(const double AValue);
	virtual void __fastcall SetAxisOnce();
	virtual void __fastcall SetGaugePalette(const System::Uitypes::TColor *Palette, const int Palette_High);
	virtual void __fastcall SetMinimum(const double Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	__classmethod virtual void __fastcall SetSubGallery(Vcltee::Teengine::TChartSeries* ASeries, int Index);
	virtual void __fastcall SetValues();
	double __fastcall ValueToAngle(const double AValue);
	
public:
	__fastcall virtual TCircularGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCircularGauge();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual Vcltee::Teengine::TChartAxis* __fastcall Axis();
	virtual bool __fastcall UseAxis();
	int __fastcall CircleXCenter();
	int __fastcall CircleYCenter();
	__property Vcltee::Teelineargauge::TLinearGauge* LinearGauge = {read=GetLinearGauge, write=SetLinearGauge};
	__property Vcltee::Teenumericgauge::TNumericGauge* NumericGauge = {read=GetNumericGauge, write=SetNumericGauge};
	__property int XRadius = {read=FXRadius, nodefault};
	__property int YRadius = {read=FYRadius, nodefault};
	
__published:
	__property Active = {default=1};
	__property Cursor = {default=0};
	__property ParentChart;
	__property DataSource;
	__property Marks;
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
	__property bool AutoPositionLinearGauge = {read=FAutoPositionLinearGauge, write=SetAutoPositionLinearGauge, default=1};
	__property bool AutoValueLinearGauge = {read=FAutoValueLinearGauge, write=SetAutoValueLinearGauge, default=1};
	__property bool AutoPositionNumericGauge = {read=FAutoPositionNumericGauge, write=SetAutoPositionNumericGauge, default=1};
	__property bool AutoValueNumericGauge = {read=FAutoValueNumericGauge, write=SetAutoValueNumericGauge, default=1};
	__property Vcltee::Teelineargauge::TGaugeSeriesPointer* Center = {read=FCenter, write=SetCenter};
	__property bool Circled = {read=FCircled, write=SetCircled, default=1};
	__property int DisplayTotalAngle = {read=GetDisplayTotalAngle, write=SetDisplayTotalAngle, nodefault};
	__property int DisplayRotationAngle = {read=GetDisplayRotationAngle, write=SetDisplayRotationAngle, nodefault};
	__property bool FillToSemiCircle = {read=FFillToSemiCircle, write=SetFillToSemicircle, default=1};
	__property Vcltee::Teengine::TSeriesPointer* EndPoint = {read=FEndPoint, write=SetEndPoint};
	__property Face;
	__property Frame;
	__property GreenLine = {stored=false};
	__property TGaugeHand* Hand = {read=GetHand, write=SetHand, stored=false};
	__property int HandOffset = {read=GetHandOffset, write=SetHandOffset, nodefault};
	__property TGaugeHands* Hands = {read=GetHands, write=SetHands};
	__property bool LabelsInside = {read=FLabelsInside, write=SetLabelsInside, default=1};
	__property Maximum = {default=0};
	__property Minimum = {default=0};
	__property MinorTickDistance = {default=3};
	__property MinorTicks;
	__property Ranges;
	__property RedLine = {stored=false};
	__property bool RotateLabels = {read=FRotateLabels, write=SetRotateLabels, default=1};
	__property double RotationAngle = {read=FRotAngle, write=SetRotAngle};
	__property Ticks;
	__property double TotalAngle = {read=FTotalAngle, write=SetTotalAngle};
	__property Value = {default=0};
};


enum DECLSPEC_DENUM TClockGaugeStyle : unsigned char { cgsDecimal, cgsRoman };

class PASCALIMPLEMENTATION TClockGauge : public TCircularGauge
{
	typedef TCircularGauge inherited;
	
private:
	bool FCustomTime;
	bool FSnap;
	TClockGaugeStyle FStyle;
	System::TDateTime FTime;
	Vcl::Extctrls::TTimer* ITimer;
	TGaugeHand* __fastcall GetHours();
	TGaugeHand* __fastcall GetMinutes();
	TGaugeHand* __fastcall GetSeconds();
	System::TDateTime __fastcall GetTime();
	bool __fastcall IsTimeStored();
	void __fastcall SetCustomTime(const bool Value);
	void __fastcall SetSnap(const bool Value);
	void __fastcall SetStyle(const TClockGaugeStyle Value);
	void __fastcall SetTime(const System::TDateTime Value);
	void __fastcall TimerExpired(System::TObject* Sender);
	
protected:
	virtual System::UnicodeString __fastcall GetLabel(const double AValue);
	virtual void __fastcall Loaded();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TClockGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TClockGauge();
	__property TGaugeHand* Hours = {read=GetHours};
	__property TGaugeHand* Minutes = {read=GetMinutes};
	__property TGaugeHand* Seconds = {read=GetSeconds};
	__property Vcl::Extctrls::TTimer* Timer = {read=ITimer};
	
__published:
	__property bool CustomTime = {read=FCustomTime, write=SetCustomTime, default=0};
	__property bool SnapToSeconds = {read=FSnap, write=SetSnap, default=1};
	__property TClockGaugeStyle Style = {read=FStyle, write=SetStyle, default=1};
	__property System::TDateTime Time = {read=GetTime, write=SetTime, stored=IsTimeStored};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecirculargauge */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECIRCULARGAUGE)
using namespace Vcltee::Teecirculargauge;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecirculargaugeHPP
