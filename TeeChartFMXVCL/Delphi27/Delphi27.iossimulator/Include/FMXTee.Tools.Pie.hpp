// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Pie.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_PieHPP
#define Fmxtee_Tools_PieHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Animate.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Pie
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPieTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TPieToolStyle : unsigned char { ptFocus, ptExplode };

class PASCALIMPLEMENTATION TPieTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	Fmxtee::Animate::TNumberAnimation* FExplode;
	TPieToolStyle FStyle;
	Fmxtee::Series::TPieSeries* ISeries;
	int ISlice;
	void __fastcall ExplodeSetValue(Fmxtee::Animate::TTeeAnimation* Sender, const double Value);
	Fmxtee::Animate::TNumberAnimation* __fastcall GetExplode();
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall FocusSlice(int ValueIndex, bool Focused, Fmxtee::Series::TPieSeries* ASeries = (Fmxtee::Series::TPieSeries*)(0x0));
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TPieTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Fmxtee::Animate::TNumberAnimation* ExplodeAnimation = {read=GetExplode};
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
}	/* namespace Pie */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_PIE)
using namespace Fmxtee::Tools::Pie;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_PieHPP
