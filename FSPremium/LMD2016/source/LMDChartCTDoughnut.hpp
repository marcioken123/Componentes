// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartCTDoughnut.pas' rev: 31.00 (Windows)

#ifndef LmdchartctdoughnutHPP
#define LmdchartctdoughnutHPP

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
#include <LMDChartBackground.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartctdoughnut
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartCTDoughnut;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartCTDoughnut : public Lmdcharttypes::TLMDChartCTAbstract
{
	typedef Lmdcharttypes::TLMDChartCTAbstract inherited;
	
	
private:
	typedef System::DynamicArray<int> _TLMDChartCTDoughnut__1;
	
	
private:
	Lmdchartlabel::TLMDChartLabel* LLabel;
	Lmdchartmarker::TLMDChartMarker* LMarker;
	bool FProportion;
	System::Byte FPieTransparency;
	int FThisExplode;
	int FThisExplodeIndex;
	_TLMDChartCTDoughnut__1 FExplodes;
	bool FExplodeAutoScale;
	int FLabelsYDeviation;
	int FLabelsXDeviation;
	int FLabelsMargin;
	bool FShowPercent;
	Lmdchartlabel::TLMDChartLabelAlign FLabelAlign;
	void __fastcall SetLabelAlign(Lmdchartlabel::TLMDChartLabelAlign Value);
	void __fastcall SetPieTransparency(System::Byte Value);
	void __fastcall SetPiesLabels(Lmdchartlabel::TLMDChartLabel* Value);
	void __fastcall SetLabelsMargin(int Value);
	void __fastcall SetLabelsXDeviation(int Value);
	void __fastcall SetLabelsYDeviation(int Value);
	void __fastcall SetShowPercent(bool Value);
	
protected:
	void __fastcall DrawPie(Vcl::Graphics::TBitmap* ATarget, Lmdchartdata::TLMDChartData* AValues, const System::Types::TRect &AArea);
	
public:
	__fastcall virtual TLMDChartCTDoughnut(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDChartCTDoughnut(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABuffer, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues, Lmdchartpersistent::TLMDChartPersistent* AChartArea);
	virtual void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	virtual void __fastcall ResetMainOwner(System::Classes::TPersistent* AmainOwner);
	
__published:
	__property Lmdchartlabel::TLMDChartLabelAlign LabelAlign = {read=FLabelAlign, write=SetLabelAlign, default=2};
	__property bool ShowPercent = {read=FShowPercent, write=SetShowPercent, default=0};
	__property int LabelsXDeviation = {read=FLabelsXDeviation, write=SetLabelsXDeviation, default=0};
	__property int LabelsYDeviation = {read=FLabelsYDeviation, write=SetLabelsYDeviation, default=0};
	__property int LabelsMargin = {read=FLabelsMargin, write=SetLabelsMargin, default=0};
	__property Lmdchartlabel::TLMDChartLabel* PiesLabels = {read=LLabel, write=SetPiesLabels};
	__property System::Byte PieTransparency = {read=FPieTransparency, write=SetPieTransparency, default=250};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartctdoughnut */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTCTDOUGHNUT)
using namespace Lmdchartctdoughnut;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartctdoughnutHPP
