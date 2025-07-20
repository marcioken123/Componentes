// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeChart3D.pas' rev: 34.00 (Windows)

#ifndef Teechart3dHPP
#define Teechart3dHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <TeeBlocks.hpp>
#include <TeeChartBlock.hpp>
#include <TeeMakerControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teechart3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TChart3D;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TChart3D : public Teemakercontrol::TMaker
{
	typedef Teemakercontrol::TMaker inherited;
	
private:
	Teechartblock::TChartBlock* FChart;
	void __fastcall CreateChart();
	Vcltee::Teengine::TChartAxes* __fastcall GetAxes();
	Teechartblock::TChartBlock* __fastcall GetBlock();
	Vcltee::Chart::TChart* __fastcall GetChart();
	void __fastcall SetBlock(Teechartblock::TChartBlock* const Value);
	void __fastcall SetChart(Vcltee::Chart::TChart* const Value);
	void __fastcall SetupChart();
	
protected:
	virtual Vcltee::Teeprocs::TCustomTeePanel* __fastcall GetEditablePanel();
	virtual void __fastcall Loaded();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TChart3D(System::Classes::TComponent* AOwner);
	__property Vcltee::Teengine::TChartAxes* Axes = {read=GetAxes};
	__property Teechartblock::TChartBlock* ChartBlock = {read=GetBlock, write=SetBlock};
	
__published:
	__property Vcltee::Chart::TChart* Chart = {read=GetChart, write=SetChart};
public:
	/* TMaker.Destroy */ inline __fastcall virtual ~TChart3D() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TChart3D(HWND ParentWindow) : Teemakercontrol::TMaker(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teechart3d */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEECHART3D)
using namespace Teechart3d;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Teechart3dHPP
