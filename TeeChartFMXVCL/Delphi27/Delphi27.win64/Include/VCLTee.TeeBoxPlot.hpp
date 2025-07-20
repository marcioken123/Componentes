// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeBoxPlot.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeboxplotHPP
#define Vcltee_TeeboxplotHPP

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
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.StatChar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeboxplot
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomBoxSeries;
class DELPHICLASS TBoxSeries;
class DELPHICLASS THorizBoxSeries;
class DELPHICLASS TViolinSeries;
class DELPHICLASS TBeeSwarmSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomBoxSeries : public Vcltee::Series::TPointSeries
{
	typedef Vcltee::Series::TPointSeries inherited;
	
private:
	Vcltee::Teengine::TSeriesPointer* FExtrOut;
	Vcltee::Tecanvas::TTeePen* FMedianPen;
	Vcltee::Teengine::TSeriesPointer* FMildOut;
	double FPosition;
	double FWhiskerLength;
	Vcltee::Tecanvas::TTeePen* FWhiskerPen;
	bool IVertical;
	bool FUseCustomValues;
	double FMedian;
	double FQuartile1;
	double FQuartile3;
	double FInnerFence1;
	double FInnerFence3;
	double FOuterFence1;
	double FOuterFence3;
	double FAdjacentPoint1;
	double FAdjacentPoint3;
	void __fastcall CalcValues(/* out */ System::Types::TRect &R, /* out */ int &x, /* out */ int &y, /* out */ int &horiz, /* out */ int &vert, /* out */ int &tmp);
	Vcltee::Teengine::TSeriesPointer* __fastcall GetBox();
	void __fastcall SetAdjacentPoint1(const double Value);
	void __fastcall SetAdjacentPoint3(const double Value);
	void __fastcall SetExtrOut(Vcltee::Teengine::TSeriesPointer* Value);
	void __fastcall SetInnerFence1(const double Value);
	void __fastcall SetInnerFence3(const double Value);
	void __fastcall SetMedian(const double Value);
	void __fastcall SetMedianPen(Vcltee::Tecanvas::TTeePen* Value);
	void __fastcall SetMildOut(Vcltee::Teengine::TSeriesPointer* Value);
	void __fastcall SetOuterFence1(const double Value);
	void __fastcall SetOuterFence3(const double Value);
	void __fastcall SetPosition(const double Value);
	void __fastcall SetQuartile1(const double Value);
	void __fastcall SetQuartile3(const double Value);
	void __fastcall SetUseCustomValues(const bool Value);
	void __fastcall SetWhiskerLength(const double Value);
	void __fastcall SetWhiskerPen(Vcltee::Tecanvas::TTeePen* Value);
	bool __fastcall SaveCustomValues();
	void __fastcall TryPrepareHover();
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual Vcltee::Teengine::TChartValueList* __fastcall GetSampleValues();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSampleValues(Vcltee::Teengine::TChartValueList* Value);
	
public:
	__fastcall virtual TCustomBoxSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomBoxSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	void __fastcall RecalcStats();
	__property Vcltee::Teengine::TSeriesPointer* Box = {read=GetBox};
	
__published:
	__property Vcltee::Teengine::TSeriesPointer* ExtrOut = {read=FExtrOut, write=SetExtrOut};
	__property Vcltee::Tecanvas::TTeePen* MedianPen = {read=FMedianPen, write=SetMedianPen};
	__property Vcltee::Teengine::TSeriesPointer* MildOut = {read=FMildOut, write=SetMildOut};
	__property double Position = {read=FPosition, write=SetPosition};
	__property Vcltee::Teengine::TChartValueList* SampleValues = {read=GetSampleValues, write=SetSampleValues};
	__property bool UseCustomValues = {read=FUseCustomValues, write=SetUseCustomValues, default=0};
	__property double WhiskerLength = {read=FWhiskerLength, write=SetWhiskerLength};
	__property Vcltee::Tecanvas::TTeePen* WhiskerPen = {read=FWhiskerPen, write=SetWhiskerPen};
	__property double AdjacentPoint1 = {read=FAdjacentPoint1, write=SetAdjacentPoint1, stored=SaveCustomValues};
	__property double AdjacentPoint3 = {read=FAdjacentPoint3, write=SetAdjacentPoint3, stored=SaveCustomValues};
	__property double InnerFence1 = {read=FInnerFence1, write=SetInnerFence1, stored=SaveCustomValues};
	__property double InnerFence3 = {read=FInnerFence3, write=SetInnerFence3, stored=SaveCustomValues};
	__property double Median = {read=FMedian, write=SetMedian, stored=SaveCustomValues};
	__property double OuterFence1 = {read=FOuterFence1, write=SetOuterFence1, stored=SaveCustomValues};
	__property double OuterFence3 = {read=FOuterFence3, write=SetOuterFence3, stored=SaveCustomValues};
	__property double Quartile1 = {read=FQuartile1, write=SetQuartile1, stored=SaveCustomValues};
	__property double Quartile3 = {read=FQuartile3, write=SetQuartile3, stored=SaveCustomValues};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


class PASCALIMPLEMENTATION TBoxSeries : public TCustomBoxSeries
{
	typedef TCustomBoxSeries inherited;
	
public:
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall MaxYValue();
public:
	/* TCustomBoxSeries.Create */ inline __fastcall virtual TBoxSeries(System::Classes::TComponent* AOwner) : TCustomBoxSeries(AOwner) { }
	/* TCustomBoxSeries.Destroy */ inline __fastcall virtual ~TBoxSeries() { }
	
};


class PASCALIMPLEMENTATION THorizBoxSeries : public TCustomBoxSeries
{
	typedef TCustomBoxSeries inherited;
	
public:
	__fastcall virtual THorizBoxSeries(System::Classes::TComponent* AOwner);
	virtual double __fastcall MinYValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxXValue();
public:
	/* TCustomBoxSeries.Destroy */ inline __fastcall virtual ~THorizBoxSeries() { }
	
};


class PASCALIMPLEMENTATION TViolinSeries : public Vcltee::Series::TCustomSeries
{
	typedef Vcltee::Series::TCustomSeries inherited;
	
private:
	double FPosition;
	Vcltee::Statchar::TKDEFunction* FKDEFunction;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	void __fastcall Change(Vcltee::Statchar::TKDEOptions* updateOptions);
	void __fastcall SetKDEFunction(Vcltee::Statchar::TKDEFunction* Value);
	void __fastcall SetPosition(const double Value);
	Vcltee::Statchar::TKDEFunction* __fastcall GetKDEFunction();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TViolinSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TViolinSeries();
	void __fastcall Update()/* overload */;
	void __fastcall Update(Vcltee::Teengine::TChartValueList* Values)/* overload */;
	virtual void __fastcall DrawAllValues();
	HIDESBASE void __fastcall CheckDatasource();
	__property Vcltee::Statchar::TKDEFunction* KDEFunction = {read=GetKDEFunction, write=SetKDEFunction};
	
__published:
	__property SeriesColor;
	__property double Position = {read=FPosition, write=SetPosition};
	__property Active = {default=1};
	__property ColorEachLine = {default=1};
	__property ColorEachPoint = {default=0};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property Emboss;
	__property Gradient;
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property Shadow;
	__property ShowInLegend = {default=1};
	__property Stacked = {default=0};
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
	__property ClickableLine = {default=1};
	__property ClickTolerance = {default=0};
	__property Dark3D = {default=1};
	__property DrawStyle = {default=0};
	__property InflateMargins = {default=1};
	__property InvertedStairs = {default=0};
	__property LineBrush = {default=0};
	__property LineHeight = {default=0};
	__property LinePen;
	__property OutLine;
	__property Pointer;
	__property PointerBehind = {default=0};
	__property Stairs = {default=0};
	__property TreatNulls = {default=0};
	__property XValues;
	__property YValues;
	__property Transparency = {default=0};
};


class PASCALIMPLEMENTATION TBeeSwarmSeries : public TViolinSeries
{
	typedef TViolinSeries inherited;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	
public:
	__fastcall virtual TBeeSwarmSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall DrawAllValues();
	HIDESBASE void __fastcall Update(Vcltee::Teengine::TChartValueList* YValues);
public:
	/* TViolinSeries.Destroy */ inline __fastcall virtual ~TBeeSwarmSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeboxplot */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEBOXPLOT)
using namespace Vcltee::Teeboxplot;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeboxplotHPP
