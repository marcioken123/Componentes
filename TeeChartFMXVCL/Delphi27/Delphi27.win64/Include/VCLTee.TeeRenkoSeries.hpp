// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeRenkoSeries.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeerenkoseriesHPP
#define Vcltee_TeerenkoseriesHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teerenkoseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRenkoSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRenkoSeries : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
private:
	double FBoxSize;
	System::Uitypes::TColor FDownSwing;
	bool FDraw3D;
	System::Uitypes::TColor FUpSwing;
	double IMin;
	double IMax;
	Vcltee::Tecanvas::TTeeBlend* IBlend;
	int __fastcall CalcBricks(bool Draw);
	void __fastcall CompareMinMax(const double Value);
	Vcltee::Teengine::TChartValueList* __fastcall GetCloseValues();
	void __fastcall SetBoxSize(const double Value);
	void __fastcall SetDownSwing(const System::Uitypes::TColor Value);
	void __fastcall SetDraw3D(const bool Value);
	void __fastcall SetUpSwing(const System::Uitypes::TColor Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Vcltee::Teengine::TChartSeries* Source);
	int __fastcall CalcNumBricks(const double Current, const double Previous);
	virtual void __fastcall DrawAllValues();
	void __fastcall DrawBrick(const double low, const double high, int Index);
	void __fastcall DrawBricks(const double Start, int StartIndex, int NumBricks, bool UpTrend);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TRenkoSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual int __fastcall CountLegendItems();
	virtual System::Uitypes::TColor __fastcall LegendItemColor(int LegendIndex);
	virtual System::UnicodeString __fastcall LegendString(int LegendIndex, Vcltee::Teengine::TLegendTextStyle LegendTextStyle);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	DYNAMIC int __fastcall NumSampleValues();
	virtual void __fastcall CalcFirstLastVisibleIndex();
	__property Vcltee::Teengine::TChartValueList* CloseValues = {read=GetCloseValues};
	
__published:
	__property double BoxSize = {read=FBoxSize, write=SetBoxSize};
	__property System::Uitypes::TColor DownSwingColor = {read=FDownSwing, write=SetDownSwing, default=0};
	__property bool Draw3D = {read=FDraw3D, write=SetDraw3D, default=1};
	__property Transparency = {default=0};
	__property System::Uitypes::TColor UpSwingColor = {read=FUpSwing, write=SetUpSwing, default=16777215};
	__property Active = {default=1};
	__property Brush;
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property Depth = {default=-1};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property Pen;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property ValueFormat = {default=0};
	__property VertAxis = {default=0};
	__property XLabelsSource = {default=0};
	__property XValues;
	__property YValues;
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
public:
	/* TChartSeries.Destroy */ inline __fastcall virtual ~TRenkoSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerenkoseries */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEERENKOSERIES)
using namespace Vcltee::Teerenkoseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeerenkoseriesHPP
