// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLegendScrollBar.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelegendscrollbarHPP
#define Vcltee_TeelegendscrollbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelegendscrollbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLegendScrollBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLegendScrollBar : public Vcltee::Teetools::TTeeScrollBar
{
	typedef Vcltee::Teetools::TTeeScrollBar inherited;
	
private:
	Vcltee::Chart::TCustomChartLegend* L;
	bool __fastcall HasPaging();
	void __fastcall LegendCalcSize(Vcltee::Chart::TCustomChartLegend* Sender, int &ASize);
	void __fastcall SetLegendEvent(Vcltee::Chart::TLegendCalcSize Value);
	
protected:
	virtual int __fastcall CurrentCount();
	virtual int __fastcall DeltaMain();
	virtual int __fastcall GetPosition();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetPosition(int Value);
	virtual bool __fastcall ShouldDraw(System::Types::TRect &R);
	virtual int __fastcall TotalCount();
	
public:
	__fastcall virtual ~TLegendScrollBar();
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
public:
	/* TTeeScrollBar.Create */ inline __fastcall virtual TLegendScrollBar(System::Classes::TComponent* AOwner) : Vcltee::Teetools::TTeeScrollBar(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelegendscrollbar */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELEGENDSCROLLBAR)
using namespace Vcltee::Teelegendscrollbar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelegendscrollbarHPP
