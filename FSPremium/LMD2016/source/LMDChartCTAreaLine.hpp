// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartCTAreaLine.pas' rev: 31.00 (Windows)

#ifndef LmdchartctarealineHPP
#define LmdchartctarealineHPP

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
#include <LMDChartTypes.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartAxis.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartctarealine
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartCTAreaLine;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartCTAreaLine : public Lmdcharttypes::TLMDChartCTAbstract
{
	typedef Lmdcharttypes::TLMDChartCTAbstract inherited;
	
private:
	System::Byte FAreaTransparency;
	Lmdchartlabel::TLMDChartLabel* FAreaLabels;
	bool FShowAreaLabels;
	int FLabelsYDeviation;
	int FLabelsXDeviation;
	int FLabelsMargin;
	bool FAreaStacked;
	Lmdchartline::TLMDChartLine* FXLine;
	Lmdchartline::TLMDChartLine* FYLine;
	void __fastcall SetAreaLabels(Lmdchartlabel::TLMDChartLabel* Value);
	void __fastcall SetAreaTransparency(System::Byte Value);
	void __fastcall SetLabelsMargin(int Value);
	void __fastcall SetLabelsXDeviation(int Value);
	void __fastcall SetLabelsYDeviation(int Value);
	void __fastcall SetShowAreaLabels(bool Value);
	void __fastcall SetAreaStacked(const bool Value);
	void __fastcall SetXLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetYLine(Lmdchartline::TLMDChartLine* Value);
	
protected:
	void __fastcall DrawAreaLines(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	void __fastcall DrawAreaLinesStacked(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual ~TLMDChartCTAreaLine(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABuffer, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues, Lmdchartpersistent::TLMDChartPersistent* AChartAr);
	__fastcall virtual TLMDChartCTAreaLine(System::Classes::TComponent* AMainOwner);
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
	__property bool ShowAreaLabels = {read=FShowAreaLabels, write=SetShowAreaLabels, default=1};
	__property Lmdchartlabel::TLMDChartLabel* AreaLabels = {read=FAreaLabels, write=SetAreaLabels};
	__property System::Byte AreaTransparency = {read=FAreaTransparency, write=SetAreaTransparency, default=150};
	__property bool AreaStacked = {read=FAreaStacked, write=SetAreaStacked, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartctarealine */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTCTAREALINE)
using namespace Lmdchartctarealine;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartctarealineHPP
