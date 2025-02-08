// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartRectangular2DCT.pas' rev: 31.00 (Windows)

#ifndef Lmdchartrectangular2dctHPP
#define Lmdchartrectangular2dctHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Variants.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartData.hpp>
#include <LMDChartArea.hpp>
#include <LMDChartTypes.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartAxis.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartrectangular2dct
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartRectangular2DCT;
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<System::Types::TPoint> TLMDChartPoints;

class PASCALIMPLEMENTATION TLMDChartRectangular2DCT : public Lmdcharttypes::TLMDChartCTAbstract
{
	typedef Lmdcharttypes::TLMDChartCTAbstract inherited;
	
protected:
	System::Byte FElementsTransparency;
	Lmdchartlabel::TLMDChartLabel* FLabels;
	bool FShowLabels;
	int FLabelsYDeviation;
	int FLabelsXDeviation;
	int FLabelsMargin;
	Lmdchartline::TLMDChartLine* FXLine;
	Lmdchartline::TLMDChartLine* FYLine;
	Lmdchartarea::TLMDChartArea* FChartArea;
	void __fastcall SetLabels(Lmdchartlabel::TLMDChartLabel* Value);
	void __fastcall SetElementsTransparency(System::Byte Value);
	void __fastcall SetLabelsMargin(int Value);
	void __fastcall SetLabelsXDeviation(int Value);
	void __fastcall SetLabelsYDeviation(int Value);
	void __fastcall SetShowLabels(bool Value);
	void __fastcall SetXLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetYLine(Lmdchartline::TLMDChartLine* Value);
	virtual void __fastcall DrawChart(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	virtual TLMDChartPoints __fastcall GenerateBasicElementsPoints(Lmdchartdata::TLMDChartData* AValues, int ASeriesIndex, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis);
	virtual void __fastcall DrawChartMarkers(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int ASeriesIndex, TLMDChartPoints AElementsPoints);
	virtual void __fastcall DrawChartElements(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int ASeriesIndex, TLMDChartPoints AElementsPoints, int AStartX, int AEndX, int AStartY, int AEndY) = 0 ;
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual ~TLMDChartRectangular2DCT(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABuffer, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues, Lmdchartpersistent::TLMDChartPersistent* AChartAr);
	__fastcall virtual TLMDChartRectangular2DCT(System::Classes::TComponent* AMainOwner);
	virtual void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	virtual void __fastcall ResetMainOwner(System::Classes::TPersistent* AmainOwner);
	
__published:
	__property Lmdchartline::TLMDChartLine* YLine = {read=FYLine, write=SetYLine};
	__property Lmdchartline::TLMDChartLine* XLine = {read=FXLine, write=SetXLine};
	__property int LabelsXDeviation = {read=FLabelsXDeviation, write=SetLabelsXDeviation, default=0};
	__property int LabelsYDeviation = {read=FLabelsYDeviation, write=SetLabelsYDeviation, default=0};
	__property int LabelsMargin = {read=FLabelsMargin, write=SetLabelsMargin, default=4};
	__property bool ShowLabels = {read=FShowLabels, write=SetShowLabels, default=1};
	__property Lmdchartlabel::TLMDChartLabel* Labels = {read=FLabels, write=SetLabels};
	__property System::Byte ElementsTransparency = {read=FElementsTransparency, write=SetElementsTransparency, default=150};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartrectangular2dct */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTRECTANGULAR2DCT)
using namespace Lmdchartrectangular2dct;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmdchartrectangular2dctHPP
