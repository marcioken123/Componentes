// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartCTColumn.pas' rev: 31.00 (Windows)

#ifndef LmdchartctcolumnHPP
#define LmdchartctcolumnHPP

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
#include <LMDChartLabel.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartScaleBreak.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartctcolumn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartCTColumn;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartCTColumn : public Lmdcharttypes::TLMDChartCTAbstract
{
	typedef Lmdcharttypes::TLMDChartCTAbstract inherited;
	
private:
	bool FColumnAutoSize;
	int FColumnAutoSizeValue;
	int FColumnCustomSize;
	System::Byte FColumnsTransparency;
	Lmdchartlabel::TLMDChartLabel* FColumnsLabels;
	bool FShowColumnsLabels;
	int FLabelsYDeviation;
	int FLabelsXDeviation;
	int FLabelsMargin;
	bool FColumnsStacked;
	bool FFullStacked;
	Lmdchartline::TLMDChartLine* FXLine;
	Lmdchartline::TLMDChartLine* FYLine;
	void __fastcall SetColumnAutoSize(bool Value);
	void __fastcall SetColumnAutoSizeValue(int Value);
	void __fastcall SetColumnCustomSize(int Value);
	void __fastcall SetColumnsTransparency(System::Byte Value);
	void __fastcall SetColumnsLabels(Lmdchartlabel::TLMDChartLabel* Value);
	void __fastcall SetShowColumnsLabels(bool Value);
	void __fastcall SetLabelsMargin(int Value);
	void __fastcall SetLabelsXDeviation(int Value);
	void __fastcall SetLabelsYDeviation(int Value);
	void __fastcall SetColumnsStacked(bool Value);
	void __fastcall SetFullStacked(bool Value);
	void __fastcall SetXLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetYLine(Lmdchartline::TLMDChartLine* Value);
	
protected:
	void __fastcall DrawColumns(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	void __fastcall DrawColumnsStacked(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartCTColumn(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDChartCTColumn(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABuffer, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues, Lmdchartpersistent::TLMDChartPersistent* AChartAr);
	virtual void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	virtual void __fastcall ResetMainOwner(System::Classes::TPersistent* AmainOwner);
	
__published:
	__property Lmdchartline::TLMDChartLine* YLine = {read=FYLine, write=SetYLine};
	__property Lmdchartline::TLMDChartLine* XLine = {read=FXLine, write=SetXLine};
	__property int LabelsXDeviation = {read=FLabelsXDeviation, write=SetLabelsXDeviation, default=0};
	__property int LabelsYDeviation = {read=FLabelsYDeviation, write=SetLabelsYDeviation, default=5};
	__property int LabelsMargin = {read=FLabelsMargin, write=SetLabelsMargin, default=4};
	__property bool ShowColumnsLabels = {read=FShowColumnsLabels, write=SetShowColumnsLabels, default=1};
	__property Lmdchartlabel::TLMDChartLabel* ColumnsLabels = {read=FColumnsLabels, write=SetColumnsLabels};
	__property System::Byte ColumnsTransparency = {read=FColumnsTransparency, write=SetColumnsTransparency, default=150};
	__property bool ColumnAutoSize = {read=FColumnAutoSize, write=SetColumnAutoSize, default=1};
	__property int ColumnAutoSizeValue = {read=FColumnAutoSizeValue, write=SetColumnAutoSizeValue, default=10};
	__property int ColumnCustomSize = {read=FColumnCustomSize, write=SetColumnCustomSize, default=40};
	__property bool ColumnsStacked = {read=FColumnsStacked, write=SetColumnsStacked, default=0};
	__property bool FullStacked = {read=FFullStacked, write=SetFullStacked, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartctcolumn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTCTCOLUMN)
using namespace Lmdchartctcolumn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartctcolumnHPP
