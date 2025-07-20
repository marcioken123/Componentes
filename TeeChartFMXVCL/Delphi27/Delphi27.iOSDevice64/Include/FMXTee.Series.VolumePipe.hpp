// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.VolumePipe.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Series_VolumepipeHPP
#define Fmxtee_Series_VolumepipeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <System.UIConsts.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Volumepipe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVolumePipeSeries;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::Types::TPointF, 4> TTrapeziumPoints;

class PASCALIMPLEMENTATION TVolumePipeSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
	
private:
	typedef System::DynamicArray<TTrapeziumPoints> _TVolumePipeSeries__1;
	
	
private:
	_TVolumePipeSeries__1 IPolyList;
	float IMin;
	float IMax;
	float IDiff;
	Fmxtee::Canvas::TFourPoints BoundingPoints;
	Fmxtee::Canvas::TTeePen* FLinesPen;
	int FConePercent;
	double totalVals;
	float totalPxArea;
	float lastX;
	float lastYDisp;
	float leftWall;
	float rightWall;
	float overallWidth;
	void __fastcall GetBoundingRectangle();
	Fmxtee::Canvas::TTeeGradient* __fastcall GetGradient();
	int __fastcall GetMaxMarkHeight();
	void __fastcall SetConePercent(const int Value);
	void __fastcall SetGradient(Fmxtee::Canvas::TTeeGradient* const Value);
	void __fastcall SetLinesPen(Fmxtee::Canvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	int __fastcall CalcSegment(int Counter, const double Val);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual bool __fastcall IsPointInChartRect(int ValueIndex);
	
public:
	__fastcall virtual TVolumePipeSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TVolumePipeSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	virtual bool __fastcall UseAxis();
	
__published:
	__property Active = {default=1};
	__property Brush;
	__property Color;
	__property ColorEachPoint = {default=1};
	__property ColorSource = {default=0};
	__property int ConePercent = {read=FConePercent, write=SetConePercent, default=30};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property Fmxtee::Canvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Fmxtee::Canvas::TTeePen* LinesPen = {read=FLinesPen, write=SetLinesPen};
	__property Marks;
	__property ParentChart;
	__property Pen;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
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
	__property YValues;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Volumepipe */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_VOLUMEPIPE)
using namespace Fmxtee::Series::Volumepipe;
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
#endif	// Fmxtee_Series_VolumepipeHPP
