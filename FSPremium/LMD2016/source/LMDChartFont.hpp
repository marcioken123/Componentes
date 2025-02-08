// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartFont.pas' rev: 31.00 (Windows)

#ifndef LmdchartfontHPP
#define LmdchartfontHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartPersistent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartfont
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartFont;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartFont : public Vcl::Graphics::TFont
{
	typedef Vcl::Graphics::TFont inherited;
	
private:
	System::TObject* FMainOwner;
	HIDESBASE int __fastcall GetQuality(void);
	HIDESBASE void __fastcall SetQuality(const int Value);
	bool __fastcall GetSmoothFont(void);
	int __fastcall GetEscapment(void);
	void __fastcall SetEscapment(const int Value);
	
protected:
	virtual void __fastcall Changed(void);
	
public:
	__fastcall TLMDChartFont(System::TObject* AMainOwner);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	__property int Quality = {read=GetQuality, write=SetQuality, nodefault};
	__property int Escapment = {read=GetEscapment, write=SetEscapment, nodefault};
	__property bool IsSmoothFontOn = {read=GetSmoothFont, nodefault};
public:
	/* TFont.Destroy */ inline __fastcall virtual ~TLMDChartFont(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartfont */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTFONT)
using namespace Lmdchartfont;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartfontHPP
