// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChart.pas' rev: 31.00 (Windows)

#ifndef LmdchartHPP
#define LmdchartHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Imaging.jpeg.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <intfLMDBase.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDCustomControl.hpp>
#include <LMDTypes.hpp>
#include <LMDChartBackground.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartLegend.hpp>
#include <LMDChartTitleBox.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartData.hpp>
#include <LMDChartSeriesCollection.hpp>
#include <LMDChartArea.hpp>
#include <LMDChartTypes.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartCTColumn.hpp>
#include <LMDChartCTColumn3D.hpp>
#include <LMDChartCTBar.hpp>
#include <LMDChartCTAreaLine.hpp>
#include <LMDChartCTAreaLine3D.hpp>
#include <LMDChartCTPie2D.hpp>
#include <LMDChartCTBar3D.hpp>
#include <LMDChartCTAreaSpline.hpp>
#include <LMDChartCTDoughnut.hpp>
#include <LMDControl.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchart
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomChart;
class DELPHICLASS TLMDChart;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomChart : public Lmdcustomcontrol::TLMDCustomControl
{
	typedef Lmdcustomcontrol::TLMDCustomControl inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
public:
	/* TLMDCustomControl.Create */ inline __fastcall virtual TLMDCustomChart(System::Classes::TComponent* AOwner) : Lmdcustomcontrol::TLMDCustomControl(AOwner) { }
	/* TLMDCustomControl.Destroy */ inline __fastcall virtual ~TLMDCustomChart(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomChart(HWND ParentWindow) : Lmdcustomcontrol::TLMDCustomControl(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDChart : public TLMDCustomChart
{
	typedef TLMDCustomChart inherited;
	
private:
	Lmdchartlegend::TLMDChartLegend* FLegend;
	Lmdchartbackground::TLMDChartBackground* FBackground;
	Lmdcharttitlebox::TLMDChartTitleBox* FTitleBox;
	Lmdchartdata::TLMDChartData* FSeries;
	Lmdchartseriescollection::TLMDChartSeriesColl* FSeriesColl;
	Lmdchartarea::TLMDChartArea* FChartArea;
	bool FIsLoadingData;
	void __fastcall SetBackground(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetTitleBox(Lmdcharttitlebox::TLMDChartTitleBox* Value);
	void __fastcall SetSeriesColl(Lmdchartseriescollection::TLMDChartSeriesColl* Value);
	void __fastcall SetChartArea(Lmdchartarea::TLMDChartArea* Value);
	void __fastcall SetLegend(Lmdchartlegend::TLMDChartLegend* Value);
	Lmdcharttypes::TLMDChartCTAbstract* __fastcall GetChartType(void);
	void __fastcall SetChartType(Lmdcharttypes::TLMDChartCTAbstract* Value);
	void __fastcall SetIsLoadingData(const bool Value);
	
protected:
	__property Lmdchartdata::TLMDChartData* Series = {read=FSeries};
	virtual void __fastcall Paint(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDChart(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDChart(void);
	void __fastcall SaveStateToXML(System::UnicodeString FileName, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(System::UnicodeString FileName, System::UnicodeString Comment);
	void __fastcall Draw(void);
	void __fastcall DrawTo(Vcl::Graphics::TCanvas* ATarget);
	void __fastcall SaveToBMP(System::UnicodeString AFileName, int AImageWidth, int AImageHeight);
	void __fastcall SaveToJPG(System::UnicodeString AFileName, int AImageWidth, int AImageHeight);
	void __fastcall SaveToPNG(System::UnicodeString AFileName, int AImageWidth, int AImageHeight);
	void __fastcall SaveChartAreaToJPG(System::UnicodeString AFileName, int AImageWidth, int AImageHeight);
	void __fastcall SaveChartAreaToBMP(System::UnicodeString AFileName, int AImageWidth, int AImageHeight);
	void __fastcall SaveLegendToBMP(System::UnicodeString AFileName);
	void __fastcall SetDataChanged(void);
	__property bool IsLoadingData = {read=FIsLoadingData, write=SetIsLoadingData, nodefault};
	
__published:
	__property About = {default=0};
	__property Lmdchartlegend::TLMDChartLegend* Legend = {read=FLegend, write=SetLegend};
	__property Lmdchartbackground::TLMDChartBackground* Background = {read=FBackground, write=SetBackground};
	__property Lmdcharttitlebox::TLMDChartTitleBox* TitleBox = {read=FTitleBox, write=SetTitleBox};
	__property Lmdchartseriescollection::TLMDChartSeriesColl* SeriesObjects = {read=FSeriesColl, write=SetSeriesColl};
	__property Lmdchartarea::TLMDChartArea* ChartArea = {read=FChartArea, write=SetChartArea};
	__property Lmdcharttypes::TLMDChartCTAbstract* ChartType = {read=GetChartType, write=SetChartType};
	__property Align = {default=0};
	__property ShowHint;
	__property PopupMenu;
	__property OnClick;
	__property OnDblClick;
	__property OnMouseMove;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDChart(HWND ParentWindow) : TLMDCustomChart(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchart */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHART)
using namespace Lmdchart;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartHPP
