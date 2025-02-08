// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartPrintTask.pas' rev: 31.00 (Windows)

#ifndef LmdchartprinttaskHPP
#define LmdchartprinttaskHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDChart.hpp>
#include <LMDImagePrintTask.hpp>
#include <LMDDocElementRenderer.hpp>
#include <LMDCustomPrintTask.hpp>
#include <LMDLayoutRenderPrintTask.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartprinttask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartPrintTask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartPrintTask : public Lmdimageprinttask::TLMDCustomImagePrintTask
{
	typedef Lmdimageprinttask::TLMDCustomImagePrintTask inherited;
	
private:
	Lmdchart::TLMDChart* FChart;
	void __fastcall SetChart(Lmdchart::TLMDChart* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall RenderTargetPicture(void);
	virtual void __fastcall SetExpectedPictureSize(void);
	
public:
	__fastcall virtual TLMDChartPrintTask(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDChartPrintTask(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdchart::TLMDChart* Chart = {read=FChart, write=SetChart};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartprinttask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTPRINTTASK)
using namespace Lmdchartprinttask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartprinttaskHPP
