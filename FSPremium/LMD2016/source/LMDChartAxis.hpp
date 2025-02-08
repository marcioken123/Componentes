// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartAxis.pas' rev: 31.00 (Windows)

#ifndef LmdchartaxisHPP
#define LmdchartaxisHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Variants.hpp>
#include <System.Types.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartData.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartFont.hpp>
#include <LMDChartScaleBreak.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartaxis
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartAxis;
class DELPHICLASS TLMDChartYAxis;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartAxisValuesTypes : unsigned char { avtDateTime, avtFloat };

class PASCALIMPLEMENTATION TLMDChartAxis : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
private:
	Lmdchartutils::TLMDChartTickTypes FMajorTick;
	Lmdchartutils::TLMDChartTickTypes FMinorTick;
	int FMajorTickSize;
	int FMinorTickSize;
	Lmdchartline::TLMDChartLine* FLine;
	Lmdchartfont::TLMDChartFont* FFont;
	TLMDChartAxisValuesTypes FValuesType;
	void __fastcall SetMajorTick(Lmdchartutils::TLMDChartTickTypes Value);
	void __fastcall SetMajorTickSize(int Value);
	void __fastcall SetMinorTick(Lmdchartutils::TLMDChartTickTypes Value);
	void __fastcall SetMinorTickSize(int Value);
	void __fastcall SetFont(Lmdchartfont::TLMDChartFont* Value);
	void __fastcall SetValuesType(TLMDChartAxisValuesTypes Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	__fastcall virtual TLMDChartAxis(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDChartAxis(void);
	
__published:
	__property Lmdchartfont::TLMDChartFont* Font = {read=FFont, write=SetFont};
	__property Lmdchartutils::TLMDChartTickTypes MajorTick = {read=FMajorTick, write=SetMajorTick, default=1};
	__property Lmdchartutils::TLMDChartTickTypes MinorTick = {read=FMinorTick, write=SetMinorTick, default=1};
	__property int MajorTickSize = {read=FMajorTickSize, write=SetMajorTickSize, default=2};
	__property int MinorTickSize = {read=FMinorTickSize, write=SetMinorTickSize, default=2};
	__property TLMDChartAxisValuesTypes ValuesType = {read=FValuesType, write=SetValuesType, default=1};
};


class PASCALIMPLEMENTATION TLMDChartYAxis : public TLMDChartAxis
{
	typedef TLMDChartAxis inherited;
	
private:
	System::Variant FMaxValue;
	System::Variant FMinValue;
	System::Variant FMajorStep;
	System::Variant FMinorStep;
	bool FInverted;
	bool FInvertedChanged;
	bool FAutoScale;
	Lmdchartdata::TLMDChartData* FSeries;
	bool FChartStacked;
	Lmdchartscalebreak::TLMDChartScaleBreak* FScaleBreak;
	void __fastcall SetMaxValue(const System::Variant &Value);
	void __fastcall SetMinValue(const System::Variant &Value);
	void __fastcall SetMajorStep(const System::Variant &Value);
	void __fastcall SetMinorStep(const System::Variant &Value);
	void __fastcall SetAutoScale(bool Value);
	void __fastcall SetChartStacked(bool Value);
	void __fastcall SetScaleBreak(Lmdchartscalebreak::TLMDChartScaleBreak* Value);
	System::Variant __fastcall GetMaxValue(void);
	System::Variant __fastcall GetMinValue(void);
	System::Variant __fastcall GetMajorStep(void);
	System::Variant __fastcall GetMinorStep(void);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	__fastcall virtual TLMDChartYAxis(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDChartYAxis(void);
	int __fastcall CalcPosFromBottom(int ASize, double AValue, int &AErrorBack);
	HIDESBASE void __fastcall SaveStateToXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	HIDESBASE void __fastcall LoadStateFromXML(Lmdxml::_di_ILMDXmlNode BaseNode, System::UnicodeString Comment);
	void __fastcall ChangeInverted(void);
	void __fastcall SetData(Lmdchartdata::TLMDChartData* AValue);
	virtual bool __fastcall IsChanged(void);
	virtual void __fastcall NoChanged(void);
	__property bool InvertedChanged = {read=FInvertedChanged, default=0};
	__property bool ChartStacked = {read=FChartStacked, write=SetChartStacked, default=0};
	
__published:
	__property System::Variant MaxValue = {read=GetMaxValue, write=SetMaxValue};
	__property System::Variant MinValue = {read=GetMinValue, write=SetMinValue};
	__property System::Variant MajorStep = {read=GetMajorStep, write=SetMajorStep};
	__property System::Variant MinorStep = {read=GetMinorStep, write=SetMinorStep};
	__property bool AutoScale = {read=FAutoScale, write=SetAutoScale, default=0};
	__property Lmdchartscalebreak::TLMDChartScaleBreak* ScaleBreak = {read=FScaleBreak, write=SetScaleBreak};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartaxis */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTAXIS)
using namespace Lmdchartaxis;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartaxisHPP
