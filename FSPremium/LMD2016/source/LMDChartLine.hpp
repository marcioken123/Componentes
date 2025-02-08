// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartLine.pas' rev: 31.00 (Windows)

#ifndef LmdchartlineHPP
#define LmdchartlineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartPersistent.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartline
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartLine;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartLine : public Lmdchartpersistent::TLMDChartSeriesCollectionAttribute
{
	typedef Lmdchartpersistent::TLMDChartSeriesCollectionAttribute inherited;
	
private:
	int FWidth;
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TPenStyle FStyle;
	void __fastcall SetWidth(int Value);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetStyle(Vcl::Graphics::TPenStyle Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartLine(System::Classes::TPersistent* AMainOwner);
	void __fastcall SetupCanvasPen(Vcl::Graphics::TPen* ATarget);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	
__published:
	__property int Width = {read=FWidth, write=SetWidth, default=1};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
	__property Vcl::Graphics::TPenStyle Style = {read=FStyle, write=SetStyle, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDChartLine(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartline */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTLINE)
using namespace Lmdchartline;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartlineHPP
