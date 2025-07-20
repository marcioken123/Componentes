// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeKnobGauge.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeknobgaugeHPP
#define Vcltee_TeeknobgaugeHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeeLinearGauge.hpp>
#include <VCLTee.TeeCircularGauge.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeNumericGauge.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeknobgauge
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKnobGauge;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKnobGauge : public Vcltee::Teecirculargauge::TCircularGauge
{
	typedef Vcltee::Teecirculargauge::TCircularGauge inherited;
	
private:
	bool FActiveCenter;
	bool FActiveChange;
	bool FAxisInside;
	Vcltee::Tecanvas::TTeeGradient* FHighLight;
	System::Types::TRect FInnerEllipse;
	int IAxisGap;
	int OldX;
	int OldY;
	System::Uitypes::TCursor OldCursor;
	System::Types::TRect __fastcall CalcRectangle();
	void __fastcall DrawHighLight(const System::Types::TRect &R, const int StartAngle, const int EndAngle, bool FarSide);
	void __fastcall SetAxisInside(const bool Value);
	void __fastcall SetActiveCenter(const bool Value);
	void __fastcall SetHighLight(Vcltee::Tecanvas::TTeeGradient* const Value);
	
protected:
	virtual void __fastcall CalcOrigRect();
	virtual void __fastcall DrawAllValues();
	virtual void __fastcall DrawAxis();
	virtual void __fastcall DrawCenter();
	virtual void __fastcall DrawColorLine(Vcltee::Teelineargauge::TGaugePointerRange* const Line);
	virtual void __fastcall DrawFace();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetAxisOnce();
	virtual void __fastcall SetGaugePalette(const System::Uitypes::TColor *Palette, const int Palette_High);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetValues();
	void __fastcall TeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
	
public:
	__fastcall virtual TKnobGauge(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TKnobGauge();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TPoint __fastcall CenterPoint();
	__property Vcltee::Tecanvas::TTeeGradient* HighLight = {read=FHighLight, write=SetHighLight};
	
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
	__property XValues;
	__property YValues;
	__property bool ActiveCenter = {read=FActiveCenter, write=SetActiveCenter, default=0};
	__property bool AxisInside = {read=FAxisInside, write=SetAxisInside, default=0};
	__property Center;
	__property Circled = {default=1};
	__property EndPoint;
	__property Face;
	__property Frame;
	__property GreenLine = {stored=false};
	__property Hand = {stored=false};
	__property LabelsInside = {default=1};
	__property Maximum = {default=0};
	__property Minimum = {default=0};
	__property MinorTickDistance = {default=3};
	__property MinorTicks;
	__property RedLine = {stored=false};
	__property RotateLabels = {default=1};
	__property RotationAngle = {default=0};
	__property Ticks;
	__property TotalAngle = {default=0};
	__property Value = {default=0};
private:
	void *__ITeeEventListener;	// Vcltee::Teeprocs::ITeeEventListener 
	
public:
	operator Vcltee::Teeprocs::ITeeEventListener*(void) { return (Vcltee::Teeprocs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeknobgauge */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEKNOBGAUGE)
using namespace Vcltee::Teeknobgauge;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeknobgaugeHPP
