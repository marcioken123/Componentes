// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeVolumePipe.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeevolumepipeHPP
#define Vcltee_TeevolumepipeHPP

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
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teevolumepipe
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVolumePipeSeries;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::Types::TPoint, 4> TTrapeziumPoints;

class PASCALIMPLEMENTATION TVolumePipeSeries : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
	
private:
	typedef System::DynamicArray<TTrapeziumPoints> _TVolumePipeSeries__1;
	
	
private:
	_TVolumePipeSeries__1 IPolyList;
	int IMin;
	int IMax;
	int IDiff;
	Vcltee::Tecanvas::TFourPoints BoundingPoints;
	Vcltee::Tecanvas::TTeePen* FLinesPen;
	int FConePercent;
	double totalVals;
	int totalPxArea;
	int lastX;
	int lastYDisp;
	int leftWall;
	int rightWall;
	int overallWidth;
	void __fastcall GetBoundingRectangle();
	Vcltee::Tecanvas::TTeeGradient* __fastcall GetGradient();
	int __fastcall GetMaxMarkHeight();
	void __fastcall SetConePercent(const int Value);
	void __fastcall SetGradient(Vcltee::Tecanvas::TTeeGradient* const Value);
	void __fastcall SetLinesPen(Vcltee::Tecanvas::TTeePen* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	int __fastcall CalcSegment(int Counter, const double Val);
	virtual void __fastcall DoBeforeDrawChart();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
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
	__property Vcltee::Tecanvas::TTeeGradient* Gradient = {read=GetGradient, write=SetGradient};
	__property Vcltee::Tecanvas::TTeePen* LinesPen = {read=FLinesPen, write=SetLinesPen};
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
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teevolumepipe */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEVOLUMEPIPE)
using namespace Vcltee::Teevolumepipe;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeevolumepipeHPP
