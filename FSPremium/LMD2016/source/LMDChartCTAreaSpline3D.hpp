// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartCTAreaSpline3D.pas' rev: 31.00 (Windows)

#ifndef Lmdchartctareaspline3dHPP
#define Lmdchartctareaspline3dHPP

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

//-- user supplied -----------------------------------------------------------

namespace Lmdchartctareaspline3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartCTAreaSpline3D;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartCTAreaSpline3D : public Lmdcharttypes::TLMDChartCTAbstract
{
	typedef Lmdcharttypes::TLMDChartCTAbstract inherited;
	
private:
	System::Byte FAreaTransparency;
	Lmdchartlabel::TLMDChartLabel* FAreaLabels;
	bool FShowAreaLabels;
	int FLabelsYDeviation;
	int FLabelsXDeviation;
	int FLabelsMargin;
	int FChartDepth;
	Lmdchartline::TLMDChartLine* FLeftPlaneLine;
	Lmdchartline::TLMDChartLine* FBackPlaneLine;
	Lmdchartline::TLMDChartLine* FBottomPlaneLine;
	Lmdchartbackground::TLMDChartBackground* FBottomPlaneFill;
	Lmdchartbackground::TLMDChartBackground* FLeftPlaneFill;
	Lmdchartline::TLMDChartLine* FLeftZGrid;
	int FIndent3D;
	bool FShaded;
	bool FNoEdge;
	Lmdchartbackground::TLMDChartBackground* FBackPlaneFill;
	bool FStacked;
	void __fastcall SetAreaLabels(Lmdchartlabel::TLMDChartLabel* Value);
	void __fastcall SetAreaTransparency(System::Byte Value);
	void __fastcall SetLabelsMargin(int Value);
	void __fastcall SetLabelsXDeviation(int Value);
	void __fastcall SetLabelsYDeviation(int Value);
	void __fastcall SetShowAreaLabels(bool Value);
	void __fastcall SetChartDepth(const int Value);
	void __fastcall SetBottomPlaneLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetLeftPlaneLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetBackPlaneLine(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetBottomPlaneFill(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetLeftPlaneFill(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetLeftZGrid(Lmdchartline::TLMDChartLine* Value);
	void __fastcall SetIndent3D(int Value);
	void __fastcall SetShaded(bool Value);
	void __fastcall SetNoEdge(bool Value);
	void __fastcall SetBackPlaneFill(Lmdchartbackground::TLMDChartBackground* Value);
	void __fastcall SetStacked(bool Value);
	void __fastcall DrawPlaneLines(Vcl::Graphics::TCanvas* ATarget, bool Negative, const Lmdchartutils::TPointsArr &leftPoly, const Lmdchartutils::TPointsArr &bottomPoly, const System::Types::TRect &backRect, bool b, bool d, bool l);
	
protected:
	void __fastcall DrawAreaLines(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	void __fastcall DrawAreaLinesStacked(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int AStartX, int AEndX, int AStartY, int AEndY, Lmdchartaxis::TLMDChartYAxis* AYAxis, bool AShowMarkers);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual ~TLMDChartCTAreaSpline3D(void);
	virtual void __fastcall Draw(Vcl::Graphics::TBitmap* ABuffer, const System::Types::TRect &AArea, Lmdchartdata::TLMDChartData* AValues, Lmdchartpersistent::TLMDChartPersistent* AChartAr);
	__fastcall virtual TLMDChartCTAreaSpline3D(System::Classes::TComponent* AMainOwner);
	virtual void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	virtual void __fastcall ResetMainOwner(System::Classes::TPersistent* AmainOwner);
	
__published:
	__property int LabelsXDeviation = {read=FLabelsXDeviation, write=SetLabelsXDeviation, default=0};
	__property int LabelsYDeviation = {read=FLabelsYDeviation, write=SetLabelsYDeviation, default=0};
	__property int LabelsMargin = {read=FLabelsMargin, write=SetLabelsMargin, default=4};
	__property bool ShowAreaLabels = {read=FShowAreaLabels, write=SetShowAreaLabels, default=1};
	__property Lmdchartlabel::TLMDChartLabel* AreaLabels = {read=FAreaLabels, write=SetAreaLabels};
	__property System::Byte AreaTransparency = {read=FAreaTransparency, write=SetAreaTransparency, default=200};
	__property int ChartDepth = {read=FChartDepth, write=SetChartDepth, default=100};
	__property Lmdchartline::TLMDChartLine* BottomPlaneLine = {read=FBottomPlaneLine, write=SetBottomPlaneLine};
	__property Lmdchartline::TLMDChartLine* BackPlaneLine = {read=FBackPlaneLine, write=SetBackPlaneLine};
	__property Lmdchartbackground::TLMDChartBackground* BottomPlaneFill = {read=FBottomPlaneFill, write=SetBottomPlaneFill};
	__property Lmdchartline::TLMDChartLine* LeftPlaneLine = {read=FLeftPlaneLine, write=SetLeftPlaneLine};
	__property Lmdchartbackground::TLMDChartBackground* LeftPlaneFill = {read=FLeftPlaneFill, write=SetLeftPlaneFill};
	__property Lmdchartline::TLMDChartLine* LeftZGrid = {read=FLeftZGrid, write=SetLeftZGrid};
	__property int Indent3D = {read=FIndent3D, write=SetIndent3D, default=10};
	__property bool Shaded = {read=FShaded, write=SetShaded, default=1};
	__property bool NoEdge = {read=FNoEdge, write=SetNoEdge, default=0};
	__property bool Stacked = {read=FStacked, write=SetStacked, default=0};
	__property Lmdchartbackground::TLMDChartBackground* BackPlaneFill = {read=FBackPlaneFill, write=SetBackPlaneFill};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartctareaspline3d */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTCTAREASPLINE3D)
using namespace Lmdchartctareaspline3d;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Lmdchartctareaspline3dHPP
