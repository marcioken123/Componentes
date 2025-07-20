// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeScroB.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeescrobHPP
#define Vcltee_TeescrobHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teescrob
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChartScrollBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TScrollBarAxis : unsigned char { sbDefault, sbOther, sbBoth };

class PASCALIMPLEMENTATION TChartScrollBar : public Vcl::Stdctrls::TScrollBar
{
	typedef Vcl::Stdctrls::TScrollBar inherited;
	
private:
	TScrollBarAxis FAxis;
	Vcltee::Chart::TCustomChart* FChart;
	bool FInverted;
	System::Classes::TNotifyEvent FOldOnPageChange;
	System::Classes::TNotifyEvent FOldOnScroll;
	System::Classes::TNotifyEvent FOldOnUndoZoom;
	System::Classes::TNotifyEvent FOldOnZoom;
	int FPageSize;
	bool IScrollAxes;
	bool __fastcall HasPaging();
	void __fastcall ChartOnPageChange(System::TObject* Sender);
	void __fastcall ChartOnScroll(System::TObject* Sender);
	void __fastcall ChartOnUndoZoom(System::TObject* Sender);
	void __fastcall ChartOnZoom(System::TObject* Sender);
	void __fastcall CalcTotals(Vcltee::Teengine::TChartAxis* const Axis, /* out */ double &AMin, /* out */ double &AMax);
	void __fastcall SetChart(Vcltee::Chart::TCustomChart* const Value);
	void __fastcall SetInverted(bool Value);
	HIDESBASE void __fastcall SetPageSize(int Value);
	
protected:
	int __fastcall AssociatedSeries(Vcltee::Teengine::TChartAxis* const Axis);
	DYNAMIC void __fastcall Change();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TChartScrollBar(System::Classes::TComponent* AOwner);
	void __fastcall RecalcPosition(bool ScrollAxes = true);
	
__published:
	__property Align = {default=0};
	__property TScrollBarAxis Axis = {read=FAxis, write=FAxis, default=2};
	__property Vcltee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
	__property Enabled = {default=0};
	__property bool Inverted = {read=FInverted, write=SetInverted, default=0};
	__property LargeChange = {default=500};
	__property Max = {default=30000};
	__property SmallChange = {default=50};
	__property int PageSize = {read=FPageSize, write=SetPageSize, nodefault};
public:
	/* TWinControl.CreateParented */ inline __fastcall TChartScrollBar(HWND ParentWindow) : Vcl::Stdctrls::TScrollBar(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TChartScrollBar() { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word TeeMaxScrollPos = System::Word(0x7530);
}	/* namespace Teescrob */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESCROB)
using namespace Vcltee::Teescrob;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeescrobHPP
