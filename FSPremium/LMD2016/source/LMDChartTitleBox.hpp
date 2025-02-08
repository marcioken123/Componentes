// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartTitleBox.pas' rev: 31.00 (Windows)

#ifndef LmdcharttitleboxHPP
#define LmdcharttitleboxHPP

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

namespace Lmdcharttitlebox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartTitleBox;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartAlignment : unsigned char { caTop, caBottom, caLeft, caRigth };

class PASCALIMPLEMENTATION TLMDChartTitleBox : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
private:
	System::UnicodeString FText;
	Lmdchartfont::TLMDChartFont* FFont;
	TLMDChartAlignment FAlignment;
	Lmdchartbackground::TLMDChartBackground* FBackground;
	Lmdchartline::TLMDChartLine* FEdge;
	Vcl::Graphics::TPicture* FIcon;
	int FMarginEdge;
	int FMarginChart;
	TLMDChartAlignment FIconAlignment;
	int FInnerIndentLeft;
	int FInnerIndentRight;
	int FInnerIndentTop;
	int FInnerIndentBottom;
	int FIconMargin;
	void __fastcall SetFont(Lmdchartfont::TLMDChartFont* Value);
	void __fastcall SetBackground(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetIcon(Vcl::Graphics::TPicture* Value);
	void __fastcall SetEdge(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetIconMargin(int Value);
	void __fastcall SetIconAlignment(TLMDChartAlignment Value);
	void __fastcall SetInnerIndentBottom(int Value);
	void __fastcall SetInnerIndentLeft(int Value);
	void __fastcall SetInnerIndentRight(int Value);
	void __fastcall SetInnerIndentTop(int Value);
	void __fastcall SetAlignment(TLMDChartAlignment Value);
	void __fastcall SetMarginChart(int Value);
	void __fastcall SetMarginEdge(int Value);
	
protected:
	void __fastcall DrawIconTrnsp(Vcl::Graphics::TCanvas* ATarget, int AX, int AY, System::Uitypes::TColor ATranspColor);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartTitleBox(System::Classes::TPersistent* AMainOwner);
	__fastcall virtual ~TLMDChartTitleBox(void);
	System::Types::TRect __fastcall Draw(Vcl::Graphics::TCanvas* ATarget, const System::Types::TRect &AArea);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	
__published:
	__property System::UnicodeString Text = {read=FText, write=FText};
	__property Lmdchartfont::TLMDChartFont* Font = {read=FFont, write=SetFont};
	__property TLMDChartAlignment Alignment = {read=FAlignment, write=SetAlignment, default=1};
	__property Lmdchartbackground::TLMDChartBackground* Background = {read=FBackground, write=SetBackground};
	__property Lmdchartline::TLMDChartLine* Edge = {read=FEdge, write=SetEdge};
	__property Vcl::Graphics::TPicture* Icon = {read=FIcon, write=SetIcon};
	__property int MarginEdge = {read=FMarginEdge, write=SetMarginEdge, default=5};
	__property int MarginChart = {read=FMarginChart, write=SetMarginChart, default=5};
	__property int IconMargin = {read=FIconMargin, write=SetIconMargin, default=5};
	__property TLMDChartAlignment IconAlignment = {read=FIconAlignment, write=SetIconAlignment, default=2};
	__property int InnerIndentLeft = {read=FInnerIndentLeft, write=SetInnerIndentLeft, default=4};
	__property int InnerIndentRight = {read=FInnerIndentRight, write=SetInnerIndentRight, default=4};
	__property int InnerIndentTop = {read=FInnerIndentTop, write=SetInnerIndentTop, default=4};
	__property int InnerIndentBottom = {read=FInnerIndentBottom, write=SetInnerIndentBottom, default=4};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcharttitlebox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTTITLEBOX)
using namespace Lmdcharttitlebox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcharttitleboxHPP
