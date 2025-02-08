// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartCTColumn3D.pas' rev: 31.00 (Windows)

#ifndef Lmdchartctcolumn3dHPP
#define Lmdchartctcolumn3dHPP

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
#include <LMDChartBackground.hpp>
#include <LMDChartScaleBreak.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartctcolumn3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartCTColumn3D;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartCTColumn3D : public Lmdcharttypes::TLMDChartCTAbstract
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
	int FChartDepth;
	Lmdchartline::TLMDChartLine* FLeftPlaneLine;
	Lmdchartline::TLMDChartLine* FBackPlaneLine;
	Lmdchartline::TLMDChartLine* FBottomPlaneLine;
	Lmdchartbackground::TLMDChartBackground* FBottomPlaneFill;
	Lmdchartbackground::TLMDChartBackground* FLeftPlaneFill;
	Lmdchartline::TLMDChartLine* FBottomZMajorGrid;
	Lmdchartline::TLMDChartLine* FBottomZMinorGrid;
	Lmdchartline::TLMDChartLine* FLeftZGrid;
	bool FMultiRow;
	int FMultiRowIndent;
	bool FShadedBoxes;
	bool FNoEdge;
	Lmdchartbackground::TLMDChartBackground* FBackPlaneFill;
	bool FStacked;
	bool FFullStacked;
	void __fastcall SetColumnAutoSize(bool Value);
	void __fastcall SetColumnAutoSizeValue(int Value);
	void __fastcall SetColumnCustomSize(int Value);
	void __fastcall SetColumnsTransparency(System::Byte Value);
	void __fastcall SetColumnsLabels(Lmdchartlabel::TLMDChartLabel* Value);
	void __fastcall SetShowColumnsLabels(bool Value);
	void __fastcall SetLabelsMargin(int Value);
	void __fastcall SetLabelsXDeviation(int Value);
	void __fastcall SetLabelsYDeviation(int Value);
	void __fastcall SetChartDepth(int Value);
	void __fastcall SetBottomPlaneLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetLeftPlaneLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetBackPlaneLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetBottomPlaneFill(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetLeftPlaneFill(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetBottomZMajorGrid(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetBottomZMinorGrid(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetLeftZGrid(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetMultiRow(bool Value);
	void __fastcall SetMultiRowIndent(int Value);
	void __fastcall SetShadedBoxes(bool Value);
	void __fastcall SetNoEdge(bool Value);
	void __fastcall SetStacked(bool Value);
	void __fastcall SetFullStacked(bool Value);
	void __fastcall SetBackPlaneFill(Lmdchartbackground::TLMDChartBackground* Value);
	
protected:
	void __fastcall DrawColumns(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	void __fastcall DrawColumnsNegative(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	void __fastcall DrawMultiRowColumns(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	void __fastcall DrawMultiRowColumnsNegative(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	void __fastcall DrawPlaneLines(Vcl::Graphics::TCanvas* ATarget, bool Negative, const Lmdchartutils::TPointsArr &leftPoly, const Lmdchartutils::TPointsArr &bottomPoly, const System::Types::TRect &backRect, bool b, bool d, bool l);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartCTColumn3D(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDChartCTColumn3D(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABuffer, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues, Lmdchartpersistent::TLMDChartPersistent* AChartAr);
	virtual void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall DrawColumnsStacked(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	virtual void __fastcall ResetMainOwner(System::Classes::TPersistent* AmainOwner);
	
__published:
	__property int LabelsXDeviation = {read=FLabelsXDeviation, write=SetLabelsXDeviation, default=0};
	__property int LabelsYDeviation = {read=FLabelsYDeviation, write=SetLabelsYDeviation, default=0};
	__property int LabelsMargin = {read=FLabelsMargin, write=SetLabelsMargin, default=4};
	__property bool ShowColumnsLabels = {read=FShowColumnsLabels, write=SetShowColumnsLabels, default=1};
	__property Lmdchartlabel::TLMDChartLabel* ColumnsLabels = {read=FColumnsLabels, write=SetColumnsLabels};
	__property System::Byte ColumnsTransparency = {read=FColumnsTransparency, write=SetColumnsTransparency, default=200};
	__property bool ColumnAutoSize = {read=FColumnAutoSize, write=SetColumnAutoSize, default=1};
	__property int ColumnAutoSizeValue = {read=FColumnAutoSizeValue, write=SetColumnAutoSizeValue, default=30};
	__property int ColumnCustomSize = {read=FColumnCustomSize, write=SetColumnCustomSize, default=40};
	__property int ChartDepth = {read=FChartDepth, write=SetChartDepth, default=100};
	__property Lmdchartline::TLMDChartLine* BottomPlaneLine = {read=FBottomPlaneLine, write=SetBottomPlaneLine};
	__property Lmdchartline::TLMDChartLine* BackPlaneLine = {read=FBackPlaneLine, write=SetBackPlaneLine};
	__property Lmdchartbackground::TLMDChartBackground* BottomPlaneFill = {read=FBottomPlaneFill, write=SetBottomPlaneFill};
	__property Lmdchartline::TLMDChartLine* LeftPlaneLine = {read=FLeftPlaneLine, write=SetLeftPlaneLine};
	__property Lmdchartbackground::TLMDChartBackground* LeftPlaneFill = {read=FLeftPlaneFill, write=SetLeftPlaneFill};
	__property Lmdchartline::TLMDChartLine* BottomZMajorGrid = {read=FBottomZMajorGrid, write=SetBottomZMajorGrid};
	__property Lmdchartline::TLMDChartLine* BottomZMinorGrid = {read=FBottomZMinorGrid, write=SetBottomZMinorGrid};
	__property Lmdchartline::TLMDChartLine* LeftZGrid = {read=FLeftZGrid, write=SetLeftZGrid};
	__property bool MultiRow = {read=FMultiRow, write=SetMultiRow, default=0};
	__property int MultiRowIndent = {read=FMultiRowIndent, write=SetMultiRowIndent, default=5};
	__property bool ShadedBoxes = {read=FShadedBoxes, write=SetShadedBoxes, default=1};
	__property bool NoEdge = {read=FNoEdge, write=SetNoEdge, default=0};
	__property bool Stacked = {read=FStacked, write=SetStacked, default=0};
	__property bool FullStacked = {read=FFullStacked, write=SetFullStacked, default=0};
	__property Lmdchartbackground::TLMDChartBackground* BackPlaneFill = {read=FBackPlaneFill, write=SetBackPlaneFill};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartctcolumn3d */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTCTCOLUMN3D)
using namespace Lmdchartctcolumn3d;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmdchartctcolumn3dHPP
