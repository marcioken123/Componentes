// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartBackground.pas' rev: 31.00 (Windows)

#ifndef LmdchartbackgroundHPP
#define LmdchartbackgroundHPP

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
#include <LMDChartUtils.hpp>
#include <LMDChartLine.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartbackground
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartBackground;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartBackgroundStyle : unsigned char { cbsNone, cbsGradient, cbsImageStretched, cbsImageTiled, cbsSolid };

class PASCALIMPLEMENTATION TLMDChartBackground : public Lmdchartpersistent::TLMDChartSeriesCollectionAttribute
{
	typedef Lmdchartpersistent::TLMDChartSeriesCollectionAttribute inherited;
	
	
private:
	typedef System::DynamicArray<System::Uitypes::TColor> _TLMDChartBackground__1;
	
	
private:
	TLMDChartBackgroundStyle FStyle;
	Vcl::Graphics::TPicture* FImage;
	System::Uitypes::TColor FSolidColor;
	System::Uitypes::TColor FGradientColorBegin;
	System::Uitypes::TColor FGradientColorEnd;
	int FGradientAngle;
	int FGradientMaxLOD;
	_TLMDChartBackground__1 FGradientArray;
	void __fastcall SetImage(Vcl::Graphics::TPicture* Value);
	void __fastcall SetStyle(TLMDChartBackgroundStyle Value);
	void __fastcall SetSolidColor(System::Uitypes::TColor Value);
	void __fastcall SetGradientColorBegin(System::Uitypes::TColor Value);
	void __fastcall SetGradientColorEnd(System::Uitypes::TColor Value);
	void __fastcall SetGradientAngle(int Value);
	void __fastcall SetGradientMaxLOD(int Value);
	System::Types::TRect __fastcall GetBoundedRect(System::Types::TPoint *AReg, const int AReg_High);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartBackground(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDChartBackground(void);
	void __fastcall DrawBackgroundReg(Vcl::Graphics::TCanvas* ATarget, System::Types::TPoint *AAreaReg, const int AAreaReg_High);
	void __fastcall DrawBackground(Vcl::Graphics::TCanvas* ATarget, const System::Types::TRect &AArea);
	void __fastcall DrawRectangle(Vcl::Graphics::TCanvas* ATarget, Lmdchartline::TLMDChartLine* ALine, const System::Types::TRect &AArea)/* overload */;
	void __fastcall DrawRectangle(Vcl::Graphics::TCanvas* ATarget, Lmdchartline::TLMDChartLine* ALine, int Ax0, int Ay0, int Ax1, int Ay1)/* overload */;
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	
__published:
	__property TLMDChartBackgroundStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property Vcl::Graphics::TPicture* Image = {read=FImage, write=SetImage};
	__property System::Uitypes::TColor SolidColor = {read=FSolidColor, write=SetSolidColor, default=16777215};
	__property System::Uitypes::TColor GradientColorBegin = {read=FGradientColorBegin, write=SetGradientColorBegin, default=16777215};
	__property System::Uitypes::TColor GradientColorEnd = {read=FGradientColorEnd, write=SetGradientColorEnd, default=8421504};
	__property int GradientAngle = {read=FGradientAngle, write=SetGradientAngle, default=0};
	__property int GradientMaxLOD = {read=FGradientMaxLOD, write=SetGradientMaxLOD, default=50};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartbackground */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTBACKGROUND)
using namespace Lmdchartbackground;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartbackgroundHPP
