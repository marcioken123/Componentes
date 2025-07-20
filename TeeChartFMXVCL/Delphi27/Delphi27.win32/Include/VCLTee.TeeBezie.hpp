// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeBezie.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeebezieHPP
#define Vcltee_TeebezieHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teebezie
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBezierSeries;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TBezierStyle : unsigned char { bsWindows, bsBezier3, bsBezier4 };

class PASCALIMPLEMENTATION TBezierSeries : public Vcltee::Series::TCustomSeries
{
	typedef Vcltee::Series::TCustomSeries inherited;
	
private:
	TBezierStyle FBezierStyle;
	int FNumBezierPoints;
	void __fastcall SetBezierPoints(int Value);
	void __fastcall SetBezierStyle(const TBezierStyle Value);
	
protected:
	virtual void __fastcall DrawAllValues();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetSeriesColor(System::Uitypes::TColor AColor);
	
public:
	__fastcall virtual TBezierSeries(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Active = {default=1};
	__property ColorEachPoint = {default=0};
	__property ColorSource = {default=0};
	__property Cursor = {default=0};
	__property HorizAxis = {default=1};
	__property Marks;
	__property ParentChart;
	__property DataSource;
	__property PercentFormat = {default=0};
	__property SeriesColor;
	__property ShowInLegend = {default=1};
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
	__property TBezierStyle BezierStyle = {read=FBezierStyle, write=SetBezierStyle, default=0};
	__property LinePen;
	__property int NumBezierPoints = {read=FNumBezierPoints, write=SetBezierPoints, default=32};
	__property Pointer;
	__property Transparency = {default=0};
	__property XValues;
	__property YValues;
	__property OnClickPointer;
public:
	/* TCustomSeries.Destroy */ inline __fastcall virtual ~TBezierSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teebezie */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEBEZIE)
using namespace Vcltee::Teebezie;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeebezieHPP
