// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartLabel.pas' rev: 31.00 (Windows)

#ifndef LmdchartlabelHPP
#define LmdchartlabelHPP

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
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartBackground.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartFont.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartlabel
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartLabel;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartLableAlign : unsigned char { claLeftTop, claLeftBottom, claRightTop, claRightBottom };

enum DECLSPEC_DENUM TLMDChartLableCentring : unsigned char { clcNone, clcHorizontal, clcVertical, clcHorzVert };

enum DECLSPEC_DENUM TLMDChartLabelAlign : unsigned char { claRightSide, claLeftSide, claSmart };

class PASCALIMPLEMENTATION TLMDChartLabel : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
private:
	bool FShowBackground;
	Lmdchartbackground::TLMDChartBackground* FBackground;
	Lmdchartline::TLMDChartLine* FEdge;
	Lmdchartfont::TLMDChartFont* FFont;
	int FIndent;
	void __fastcall SetBackground(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetEdge(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetFont(Lmdchartfont::TLMDChartFont* Value);
	void __fastcall SetIndent(int Value);
	void __fastcall SetShowBackground(bool Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartLabel(System::Classes::TPersistent* AMainOwner);
	__fastcall virtual ~TLMDChartLabel(void);
	void __fastcall Draw(Vcl::Graphics::TCanvas* ATarget, System::UnicodeString AText, int AX, int AY, TLMDChartLableAlign AAlign, TLMDChartLableCentring ACentring);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	HIDESBASE void __fastcall ResetOwner(System::Classes::TPersistent* AMainOwner);
	
__published:
	__property int Indent = {read=FIndent, write=SetIndent, default=5};
	__property bool ShowBackground = {read=FShowBackground, write=SetShowBackground, stored=true, default=1};
	__property Lmdchartline::TLMDChartLine* Edge = {read=FEdge, write=SetEdge};
	__property Lmdchartfont::TLMDChartFont* Font = {read=FFont, write=SetFont};
	__property Lmdchartbackground::TLMDChartBackground* Background = {read=FBackground, write=SetBackground};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartlabel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTLABEL)
using namespace Lmdchartlabel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartlabelHPP
