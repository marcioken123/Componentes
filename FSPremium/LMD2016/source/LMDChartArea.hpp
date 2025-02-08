// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartArea.pas' rev: 31.00 (Windows)

#ifndef LmdchartareaHPP
#define LmdchartareaHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Variants.hpp>
#include <System.Math.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartBackground.hpp>
#include <LMDChartData.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartAxis.hpp>
#include <LMDChartFont.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartTypes.hpp>
#include <LMDChartCTColumn.hpp>
#include <LMDChartCTColumn3D.hpp>
#include <LMDChartCTBar.hpp>
#include <LMDChartCTAreaLine.hpp>
#include <LMDChartCTAreaLine3D.hpp>
#include <LMDChartCTPie2D.hpp>
#include <LMDChartCTBar3D.hpp>
#include <LMDChartCTAreaSpline.hpp>
#include <LMDChartCTDoughnut.hpp>
#include <LMDChartCTAreaSpline3D.hpp>
#include <LMDChartScaleBreak.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartarea
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartArea;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartArea : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
private:
	Vcl::Graphics::TBitmap* FSaveBuffer;
	int FMarginLeft;
	int FMarginTop;
	int FMarginBottom;
	int FMarginRight;
	int FInnerIndentLeft;
	int FInnerIndentRight;
	int FInnerIndentTop;
	int FInnerIndentBottom;
	Lmdchartbackground::TLMDChartBackground* FBackground;
	Lmdcharttypes::TLMDChartCTAbstract* FChartType;
	bool FMajorGridVertical;
	bool FMajorGridHorizontal;
	Lmdchartline::TLMDChartLine* FMajorGridLineVertical;
	Lmdchartline::TLMDChartLine* FMajorGridLineHorizontal;
	System::Byte FShadowTransparency;
	System::Uitypes::TColor FShadowColor;
	System::Byte FShadowDepth;
	bool FShadow;
	Lmdchartaxis::TLMDChartAxis* FXAxis;
	Lmdchartaxis::TLMDChartYAxis* FYAxis;
	bool FVerticalAxisLeftOrient;
	System::Byte FElementsTransparency;
	int FElementsShowValue;
	Lmdchartline::TLMDChartLine* FEdge;
	bool FShowMarkers;
	void __fastcall SetBackground(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetMarginLeft(int Value);
	void __fastcall SetMarginTop(int Value);
	void __fastcall SetMarginRight(int Value);
	void __fastcall SetMarginBottom(int Value);
	void __fastcall SetXAxis(Lmdchartaxis::TLMDChartAxis* Value);
	void __fastcall SetYAxis(Lmdchartaxis::TLMDChartYAxis* Value);
	void __fastcall SetInnerIndentLeft(int Value);
	void __fastcall SetInnerIndentTop(int Value);
	void __fastcall SetInnerIndentRight(int Value);
	void __fastcall SetInnerIndentBottom(int Value);
	void __fastcall SetEdge(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetMajorGridVertical(bool Value);
	void __fastcall SetMajorGridHorizontal(bool Value);
	void __fastcall SetMajorGridLineVertical(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetMajorGridLineHorizontal(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetChartType(Lmdcharttypes::TLMDChartCTAbstract* Value);
	void __fastcall SetShadowTransparency(System::Byte Value);
	void __fastcall SetShadowColor(System::Uitypes::TColor Value);
	void __fastcall SetShadowDepth(System::Byte Value);
	void __fastcall SetShadow(bool Value);
	void __fastcall SetShowMarkers(bool Value);
	void __fastcall CheckStacked(Lmdchartdata::TLMDChartData* AValues);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartArea(System::Classes::TPersistent* AMainOwner);
	void __fastcall SetChanged(void);
	__fastcall virtual ~TLMDChartArea(void);
	void __fastcall DrawChart(Vcl::Graphics::TCanvas* ATarget, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	
__published:
	__property bool ShowMarkers = {read=FShowMarkers, write=SetShowMarkers, default=1};
	__property Lmdcharttypes::TLMDChartCTAbstract* ChartType = {read=FChartType, write=SetChartType};
	__property bool MajorGridVertical = {read=FMajorGridVertical, write=SetMajorGridVertical, default=1};
	__property bool MajorGridHorizontal = {read=FMajorGridHorizontal, write=SetMajorGridHorizontal, default=1};
	__property Lmdchartline::TLMDChartLine* MajorGridLineVertical = {read=FMajorGridLineVertical, write=SetMajorGridLineVertical};
	__property Lmdchartline::TLMDChartLine* MajorGridLineHorizontal = {read=FMajorGridLineHorizontal, write=SetMajorGridLineHorizontal};
	__property Lmdchartaxis::TLMDChartYAxis* YAxis = {read=FYAxis, write=SetYAxis};
	__property Lmdchartline::TLMDChartLine* Edge = {read=FEdge, write=SetEdge};
	__property Lmdchartaxis::TLMDChartAxis* XAxis = {read=FXAxis, write=SetXAxis};
	__property Lmdchartbackground::TLMDChartBackground* Background = {read=FBackground, write=SetBackground};
	__property int MarginLeft = {read=FMarginLeft, write=SetMarginLeft, default=20};
	__property int MarginTop = {read=FMarginTop, write=SetMarginTop, default=0};
	__property int MarginBottom = {read=FMarginBottom, write=SetMarginBottom, default=0};
	__property int MarginRight = {read=FMarginRight, write=SetMarginRight, default=20};
	__property int InnerIndentLeft = {read=FInnerIndentLeft, write=SetInnerIndentLeft, default=30};
	__property int InnerIndentRight = {read=FInnerIndentRight, write=SetInnerIndentRight, default=30};
	__property int InnerIndentTop = {read=FInnerIndentTop, write=SetInnerIndentTop, default=30};
	__property int InnerIndentBottom = {read=FInnerIndentBottom, write=SetInnerIndentBottom, default=30};
	__property System::Byte ShadowTransparency = {read=FShadowTransparency, write=SetShadowTransparency, default=255};
	__property System::Uitypes::TColor ShadowColor = {read=FShadowColor, write=SetShadowColor, default=0};
	__property System::Byte ShadowDepth = {read=FShadowDepth, write=SetShadowDepth, default=4};
	__property bool Shadow = {read=FShadow, write=SetShadow, default=0};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool HadChanged;
}	/* namespace Lmdchartarea */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTAREA)
using namespace Lmdchartarea;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartareaHPP
