// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDHTMLSTYLE.pas' rev: 31.00 (Windows)

#ifndef LmdhtmlstyleHPP
#define LmdhtmlstyleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDParserStack.hpp>
#include <LMDText.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdhtmlstyle
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDHTMLStyle;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHTMLStyle : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdparserstack::TLMDStringStack* FFontFace;
	Lmdparserstack::TLMDStringStack* FFontSize;
	Lmdparserstack::TLMDStringStack* FBaseFontSize;
	Lmdparserstack::TLMDStringStack* FBaseFontFace;
	Lmdparserstack::TLMDIntegerStack* FBaseFontColor;
	Lmdparserstack::TLMDIntegerStack* FFontColor;
	Lmdparserstack::TLMDFontStyleStack* FFontStyle;
	Lmdparserstack::TLMDIntegerStack* FShadowColor;
	Lmdparserstack::TLMDIntegerStack* FShadowDepth;
	Lmdparserstack::TLMDIntegerStack* FLightColor;
	Lmdparserstack::TLMDIntegerStack* FLightDepth;
	Lmdparserstack::TLMDIntegerStack* FTextStyle;
	Lmdparserstack::TLMDIntegerStack* FSubscriptStyle;
	Lmdparserstack::TLMDIntegerStack* FLink;
	Lmdparserstack::TLMDStringStack* FHREF;
	System::UnicodeString __fastcall GetFontFace(void);
	System::UnicodeString __fastcall GetFontSize(void);
	System::UnicodeString __fastcall GetBaseFontSize(void);
	System::UnicodeString __fastcall GetBaseFontFace(void);
	System::Uitypes::TColor __fastcall GetBaseFontColor(void);
	System::Uitypes::TColor __fastcall GetFontColor(void);
	System::Uitypes::TFontStyles __fastcall GetFontStyle(void);
	void __fastcall SetFontStyle(System::Uitypes::TFontStyles aValue);
	System::Uitypes::TColor __fastcall GetShadowColor(void);
	System::Byte __fastcall GetShadowDepth(void);
	System::Uitypes::TColor __fastcall GetLightColor(void);
	System::Byte __fastcall GetLightDepth(void);
	Lmdtext::TLMDTextStyle __fastcall GetTextStyle(void);
	Lmdtext::TLMDTextSubscriptStyle __fastcall GetSubscriptStyle(void);
	bool __fastcall GetLink(void);
	System::UnicodeString __fastcall GetHREF(void);
	
public:
	__fastcall TLMDHTMLStyle(void);
	__fastcall virtual ~TLMDHTMLStyle(void);
	void __fastcall Clear(void);
	void __fastcall SetStyle(Lmdtext::TLMDText* aText);
	void __fastcall OpenFontFaceArea(const System::UnicodeString aFontFace);
	void __fastcall CloseFontFaceArea(void);
	void __fastcall OpenFontSizeArea(const System::UnicodeString aFontSize);
	void __fastcall CloseFontSizeArea(void);
	void __fastcall OpenBaseFontSizeArea(const System::UnicodeString aFontSize);
	void __fastcall CloseBaseFontSizeArea(void);
	void __fastcall OpenBaseFontFaceArea(const System::UnicodeString aFontFace);
	void __fastcall CloseBaseFontFaceArea(void);
	void __fastcall OpenBaseFontColorArea(System::Uitypes::TColor aFontColor);
	void __fastcall CloseBaseFontColorArea(void);
	void __fastcall OpenFontColorArea(System::Uitypes::TColor aFontColor);
	void __fastcall CloseFontColorArea(void);
	void __fastcall OpenFontStyleArea(System::Uitypes::TFontStyles aFontStyle);
	void __fastcall CloseFontStyleArea(void);
	void __fastcall OpenShadowColorArea(System::Uitypes::TColor aColor);
	void __fastcall CloseShadowColorArea(void);
	void __fastcall OpenShadowDepthArea(System::Byte aDepth);
	void __fastcall CloseShadowDepthArea(void);
	void __fastcall OpenLightColorArea(System::Uitypes::TColor aColor);
	void __fastcall CloseLightColorArea(void);
	void __fastcall OpenLightDepthArea(System::Byte aDepth);
	void __fastcall CloseLightDepthArea(void);
	void __fastcall OpenTextStyleArea(Lmdtext::TLMDTextStyle aTextStyle);
	void __fastcall CloseTextStyleArea(void);
	void __fastcall OpenSubscriptStyleArea(Lmdtext::TLMDTextSubscriptStyle aSStyle);
	void __fastcall CloseSubscriptStyleArea(void);
	void __fastcall OpenLinkArea(void);
	void __fastcall CloseLinkArea(void);
	void __fastcall OpenHREFArea(const System::UnicodeString aHREF);
	void __fastcall CloseHREFArea(void);
	__property System::UnicodeString FontFace = {read=GetFontFace};
	__property System::UnicodeString FontSize = {read=GetFontSize};
	__property System::UnicodeString BaseFontSize = {read=GetBaseFontSize};
	__property System::UnicodeString BaseFontFace = {read=GetBaseFontFace};
	__property System::Uitypes::TColor BaseFontColor = {read=GetBaseFontColor, nodefault};
	__property System::Uitypes::TColor FontColor = {read=GetFontColor, nodefault};
	__property System::Uitypes::TFontStyles FontStyle = {read=GetFontStyle, write=SetFontStyle, nodefault};
	__property System::Uitypes::TColor ShadowColor = {read=GetShadowColor, nodefault};
	__property System::Byte ShadowDepth = {read=GetShadowDepth, nodefault};
	__property System::Uitypes::TColor LightColor = {read=GetLightColor, nodefault};
	__property System::Byte LightDepth = {read=GetLightDepth, nodefault};
	__property Lmdtext::TLMDTextStyle TextStyle = {read=GetTextStyle, nodefault};
	__property Lmdtext::TLMDTextSubscriptStyle SubscriptStyle = {read=GetSubscriptStyle, nodefault};
	__property bool Link = {read=GetLink, nodefault};
	__property System::UnicodeString HREF = {read=GetHREF};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdhtmlstyle */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDHTMLSTYLE)
using namespace Lmdhtmlstyle;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdhtmlstyleHPP
