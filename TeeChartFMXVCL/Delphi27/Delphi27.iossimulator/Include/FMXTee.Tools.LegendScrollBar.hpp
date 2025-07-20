// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.LegendScrollBar.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_LegendscrollbarHPP
#define Fmxtee_Tools_LegendscrollbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Legendscrollbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLegendScrollBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLegendScrollBar : public Fmxtee::Tools::TTeeScrollBar
{
	typedef Fmxtee::Tools::TTeeScrollBar inherited;
	
private:
	Fmxtee::Chart::TCustomChartLegend* L;
	bool __fastcall HasPaging();
	void __fastcall LegendCalcSize(Fmxtee::Chart::TCustomChartLegend* Sender, int &ASize);
	void __fastcall SetLegendEvent(Fmxtee::Chart::TLegendCalcSize Value);
	
protected:
	virtual int __fastcall CurrentCount();
	virtual int __fastcall DeltaMain();
	virtual int __fastcall GetPosition();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetPosition(int Value);
	virtual bool __fastcall ShouldDraw(System::Types::TRectF &R);
	virtual int __fastcall TotalCount();
	
public:
	__fastcall virtual ~TLegendScrollBar();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
public:
	/* TTeeScrollBar.Create */ inline __fastcall virtual TLegendScrollBar(System::Classes::TComponent* AOwner) : Fmxtee::Tools::TTeeScrollBar(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Legendscrollbar */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_LEGENDSCROLLBAR)
using namespace Fmxtee::Tools::Legendscrollbar;
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
#endif	// Fmxtee_Tools_LegendscrollbarHPP
