// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartLegend.pas' rev: 31.00 (Windows)

#ifndef LmdchartlegendHPP
#define LmdchartlegendHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartBackground.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartData.hpp>
#include <LMDChartFont.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartlegend
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartLegend;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDLegendAlignment : unsigned char { laTop, laTopRight, laTopLeft, laBottom, laBottomLeft, laBottomRight, laLeft, laRight, laAbsolute };

class PASCALIMPLEMENTATION TLMDChartLegend : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
private:
	bool FShow;
	int FAbsoluteX;
	int FAbsoluteY;
	bool FOverlap;
	TLMDLegendAlignment FAlignment;
	Lmdchartline::TLMDChartLine* FEdge;
	Lmdchartfont::TLMDChartFont* FFont;
	Lmdchartbackground::TLMDChartBackground* FBackground;
	int FMarginEdge;
	int FMarginChart;
	bool FHorizontalListing;
	int FSpaceBtwLines;
	int FIconSize;
	int FSpaceAfterIcon;
	int FInnerIndentLeft;
	int FInnerIndentRight;
	int FInnerIndentTop;
	int FInnerIndentBottom;
	void __fastcall SetAlignment(TLMDLegendAlignment Value);
	void __fastcall SetEdge(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetFont(Lmdchartfont::TLMDChartFont* Value);
	void __fastcall SetMarginEdge(int Value);
	void __fastcall SetMarginChart(int Value);
	void __fastcall SetHorizontalListing(bool Value);
	void __fastcall SetIconSize(int Value);
	void __fastcall SetInnerIndentBottom(int Value);
	void __fastcall SetInnerIndentLeft(int Value);
	void __fastcall SetInnerIndentRight(int Value);
	void __fastcall SetInnerIndentTop(int Value);
	void __fastcall SetSpaceBtwLines(int Value);
	void __fastcall SetBackground(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetSpaceAfterIcon(int Value);
	void __fastcall SetOverlap(bool Value);
	void __fastcall SetAbsoluteX(int Value);
	void __fastcall SetAbsoluteY(int Value);
	void __fastcall SetShow(bool Value);
	
public:
	__fastcall virtual TLMDChartLegend(System::Classes::TPersistent* AMainOwner);
	__fastcall virtual ~TLMDChartLegend(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	System::Types::TRect __fastcall Draw(Vcl::Graphics::TCanvas* ATarget, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AVal, System::Types::TRect &ABorders);
	System::Types::TRect __fastcall SpaceLeftAfter(const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AVal);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	
__published:
	__property bool Show = {read=FShow, write=SetShow, default=1};
	__property int AbsoluteX = {read=FAbsoluteX, write=SetAbsoluteX, default=0};
	__property int AbsoluteY = {read=FAbsoluteY, write=SetAbsoluteY, default=0};
	__property bool Overlap = {read=FOverlap, write=SetOverlap, default=0};
	__property Lmdchartbackground::TLMDChartBackground* Background = {read=FBackground, write=SetBackground};
	__property Lmdchartline::TLMDChartLine* Edge = {read=FEdge, write=SetEdge};
	__property Lmdchartfont::TLMDChartFont* Font = {read=FFont, write=SetFont};
	__property int MarginEdge = {read=FMarginEdge, write=SetMarginEdge, default=5};
	__property int MarginChart = {read=FMarginChart, write=SetMarginChart, default=5};
	__property bool HorizontalListing = {read=FHorizontalListing, write=SetHorizontalListing, default=1};
	__property int SpaceBtwLines = {read=FSpaceBtwLines, write=SetSpaceBtwLines, default=5};
	__property int IconSize = {read=FIconSize, write=SetIconSize, default=6};
	__property int InnerIndentLeft = {read=FInnerIndentLeft, write=SetInnerIndentLeft, default=4};
	__property int InnerIndentRight = {read=FInnerIndentRight, write=SetInnerIndentRight, default=4};
	__property int InnerIndentTop = {read=FInnerIndentTop, write=SetInnerIndentTop, default=4};
	__property int InnerIndentBottom = {read=FInnerIndentBottom, write=SetInnerIndentBottom, default=4};
	__property int SpaceAfterIcon = {read=FSpaceAfterIcon, write=SetSpaceAfterIcon, default=2};
	__property TLMDLegendAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartlegend */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTLEGEND)
using namespace Lmdchartlegend;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartlegendHPP
