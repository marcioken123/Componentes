// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartMarker.pas' rev: 31.00 (Windows)

#ifndef LmdchartmarkerHPP
#define LmdchartmarkerHPP

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
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartmarker
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartMarker;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartMarkerTypes : unsigned char { cmtNone, cmtCustomImage, cmtSquare, cmtTriangle, cmtCircle, cmtDiamond, cmtFourPointStar, cmtFivePointStar, cmtSixPointStar, cmtSevenPointStar };

class PASCALIMPLEMENTATION TLMDChartMarker : public Lmdchartpersistent::TLMDChartSeriesCollectionAttribute
{
	typedef Lmdchartpersistent::TLMDChartSeriesCollectionAttribute inherited;
	
private:
	System::Uitypes::TColor FColor;
	Vcl::Graphics::TPicture* FCustomImage;
	int FSize;
	TLMDChartMarkerTypes FStyle;
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetCustomImage(Vcl::Graphics::TPicture* Value);
	void __fastcall SetSize(int Value);
	void __fastcall SetStyle(TLMDChartMarkerTypes Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartMarker(System::Classes::TPersistent* AMainOwner);
	__fastcall virtual ~TLMDChartMarker(void);
	void __fastcall Draw(Vcl::Graphics::TCanvas* ATarget, int AX, int AY);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	
__published:
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=0};
	__property Vcl::Graphics::TPicture* CustomImage = {read=FCustomImage, write=SetCustomImage};
	__property int Size = {read=FSize, write=SetSize, default=5};
	__property TLMDChartMarkerTypes Style = {read=FStyle, write=SetStyle, default=2};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartmarker */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTMARKER)
using namespace Lmdchartmarker;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartmarkerHPP
