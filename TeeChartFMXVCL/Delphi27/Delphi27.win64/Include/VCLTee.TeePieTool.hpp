// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePieTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepietoolHPP
#define Vcltee_TeepietoolHPP

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
#include <System.UIConsts.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeAnimate.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepietool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPieTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TPieToolStyle : unsigned char { ptFocus, ptExplode };

class PASCALIMPLEMENTATION TPieTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	Vcltee::Teeanimate::TNumberAnimation* FExplode;
	TPieToolStyle FStyle;
	Vcltee::Series::TPieSeries* ISeries;
	int ISlice;
	void __fastcall ExplodeSetValue(Vcltee::Teeanimate::TTeeAnimation* Sender, const double Value);
	Vcltee::Teeanimate::TNumberAnimation* __fastcall GetExplode();
	
protected:
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FocusSlice(int ValueIndex, bool Focused, Vcltee::Series::TPieSeries* ASeries = (Vcltee::Series::TPieSeries*)(0x0));
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TPieTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Vcltee::Teeanimate::TNumberAnimation* ExplodeAnimation = {read=GetExplode};
	__property int Slice = {read=ISlice, nodefault};
	
__published:
	__property Active = {default=1};
	__property Pen;
	__property Series;
	__property TPieToolStyle Style = {read=FStyle, write=FStyle, default=0};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TPieTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepietool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPIETOOL)
using namespace Vcltee::Teepietool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepietoolHPP
