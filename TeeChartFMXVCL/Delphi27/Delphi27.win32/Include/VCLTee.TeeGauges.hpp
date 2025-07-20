// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeGauges.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeegaugesHPP
#define Vcltee_TeegaugesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teegauges
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGaugeSeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM THandStyle : unsigned char { hsLine, hsTriangle };

enum DECLSPEC_DENUM TGaugeShapeStyle : unsigned char { gsSlice, gsEllipse, gsPolygon };

class PASCALIMPLEMENTATION TGaugeSeries : public Vcltee::Series::TCircledSeries
{
	typedef Vcltee::Series::TCircledSeries inherited;
	
private:
	double FAngle;
	Vcltee::Teengine::TSeriesPointer* FCenter;
	Vcltee::Tecanvas::TTeePen* FCirclePen;
	int FDistance;
	Vcltee::Teengine::TSeriesPointer* FEndPoint;
	bool FFullRepaint;
	int FHandWidth;
	bool FLabelsInside;
	double FMax;
	double FMin;
	int FMinorDistance;
	TGaugeShapeStyle FShapeStyle;
	THandStyle FStyle;
	System::Classes::TNotifyEvent FOnChange;
	System::Types::TPoint ICenter;
	Vcltee::Teengine::TCustomAxisPanel* ILastModifiedChart;
	float __fastcall AngleOfValue(const float Value);
	void __fastcall CalcLinePoints(/* out */ System::Types::TPoint &P0, /* out */ System::Types::TPoint &P1);
	System::Types::TPoint __fastcall CalcPoint(const double Angle, const System::Types::TPoint &Center, const double RadiusX, const double RadiusY);
	void __fastcall CustomizeChart();
	void __fastcall DrawValueLine();
	double __fastcall GetValue();
	void __fastcall SetAngle(const double Value);
	void __fastcall SetCenter(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetCirclePen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetDistance(const int Value);
	void __fastcall SetEndPoint(Vcltee::Teengine::TSeriesPointer* const Value);
	void __fastcall SetFullRepaint(const bool Value);
	void __fastcall SetHandWidth(const int Value);
	void __fastcall SetLabelsInside(const bool Value);
	void __fastcall SetMax(const double AValue);
	void __fastcall SetMin(const double AValue);
	void __fastcall SetMinorDistance(const int Value);
	void __fastcall SetShapeStyle(const TGaugeShapeStyle Value);
	void __fastcall SetStyle(const THandStyle Value);
	void __fastcall SetValue(const double AValue);
	bool __fastcall ShouldDoXor();
	int __fastcall SizePointer(Vcltee::Teengine::TSeriesPointer* const APointer);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawAllValues();
	DYNAMIC void __fastcall GalleryChanged3D(bool Is3D);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall NotifyNewValue(Vcltee::Teengine::TChartSeries* Sender, int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TGaugeSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGaugeSeries();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Vcltee::Teengine::TChartAxis* __fastcall Axis();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	DYNAMIC int __fastcall NumSampleValues();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	
__published:
	__property Vcltee::Teengine::TSeriesPointer* Center = {read=FCenter, write=SetCenter};
	__property Circled = {default=1};
	__property CircleGradient;
	__property Vcltee::Tecanvas::TTeePen* CirclePen = {read=FCirclePen, write=SetCirclePen};
	__property Vcltee::Teengine::TSeriesPointer* EndPoint = {read=FEndPoint, write=SetEndPoint};
	__property bool FullRepaint = {read=FFullRepaint, write=SetFullRepaint, default=0};
	__property double Maximum = {read=FMax, write=SetMax};
	__property double Minimum = {read=FMin, write=SetMin};
	__property int MinorTickDistance = {read=FMinorDistance, write=SetMinorDistance, default=0};
	__property int HandDistance = {read=FDistance, write=SetDistance, default=3};
	__property THandStyle HandStyle = {read=FStyle, write=SetStyle, default=0};
	__property int HandWidth = {read=FHandWidth, write=SetHandWidth, default=0};
	__property bool LabelsInside = {read=FLabelsInside, write=SetLabelsInside, default=1};
	__property Pen;
	__property RotationAngle = {default=135};
	__property ShowInLegend = {default=0};
	__property TGaugeShapeStyle ShapeStyle = {read=FShapeStyle, write=SetShapeStyle, default=0};
	__property double TotalAngle = {read=FAngle, write=SetAngle};
	__property double Value = {read=GetValue, write=SetValue};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 TeeHandDistance = System::Int8(0x3);
}	/* namespace Teegauges */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEGAUGES)
using namespace Vcltee::Teegauges;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeegaugesHPP
