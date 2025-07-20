// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.AxisBreaks.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_AxisbreaksHPP
#define Fmxtee_Tools_AxisbreaksHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Graphics.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.ProConstants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Axisbreaks
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAxisBreak;
class DELPHICLASS TAxisBreaks;
class DELPHICLASS TAxisBreaksTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TAxisBreakStyle : unsigned char { tabSmallZigZag, tabZigZag, tabLine, tabNone };

class PASCALIMPLEMENTATION TAxisBreak : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TAxisBreakStyle FAxisBreakStyle;
	bool FEnabled;
	double FEnd;
	double FStart;
	void __fastcall SetAxisBreakStyle(TAxisBreakStyle Value);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetEndValue(const double Value);
	void __fastcall SetStartValue(const double Value);
	
public:
	__fastcall virtual TAxisBreak(System::Classes::TCollection* Collection);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TAxisBreakStyle AxisBreakStyle = {read=FAxisBreakStyle, write=SetAxisBreakStyle, default=1};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=1};
	__property double EndValue = {read=FEnd, write=SetEndValue};
	__property double StartValue = {read=FStart, write=SetStartValue};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TAxisBreak() { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TAxisBreaks : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TAxisBreak* operator[](int Index) { return this->Item[Index]; }
	
private:
	TAxisBreaksTool* ITool;
	TAxisBreak* __fastcall Get(int Index);
	void __fastcall Put(int Index, TAxisBreak* const Value);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TAxisBreak* __fastcall Add(const double AStart, const double AEnd)/* overload */;
	__property TAxisBreak* Item[int Index] = {read=Get, write=Put/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TAxisBreaks(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TAxisBreaks() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TAxisBreaksTool : public Fmxtee::Engine::TTeeCustomToolAxis
{
	typedef Fmxtee::Engine::TTeeCustomToolAxis inherited;
	
private:
	TAxisBreaks* FBreaks;
	int FGapSize;
	double FScaleAdjustment;
	Fmxtee::Canvas::TPointArray tmpPoints;
	Fmxtee::Engine::TAxisCalcPos OldCalcX;
	Fmxtee::Engine::TAxisCalcPos OldCalcY;
	Fmxtee::Engine::TAxisCalcPosPoint OldCalcPosPoint;
	Fmxtee::Engine::TAxisOnGetLabel IOldLabel;
	Fmxtee::Chart::TChartAllowScrollEvent IOldAxisAllowScroll;
	void __fastcall AxisCalcMaxLabel(Fmxtee::Engine::TChartAxis* Sender, int LabelIndex, double &LabelValue, bool &Stop);
	void __fastcall AxisDrawLine(System::TObject* Sender);
	int __fastcall BreakSizeUpTo(const double Value);
	int __fastcall CalcXBreaks(const double Value);
	int __fastcall CalcYBreaks(const double Value);
	void __fastcall ChartGetAxisLabel(Fmxtee::Engine::TChartAxis* Sender, Fmxtee::Engine::TChartSeries* Series, int ValueIndex, System::UnicodeString &LabelText);
	void __fastcall DrawValue(Fmxtee::Engine::TChartSeries* Series, int Index);
	void __fastcall GetMarkText(Fmxtee::Engine::TChartSeries* Sender, int ValueIndex, System::UnicodeString &MarkText);
	void __fastcall SetBreaks(TAxisBreaks* const Value);
	void __fastcall SetGapSize(const int Value);
	void __fastcall SetScaleAdjustment(const double Value);
	void __fastcall CheckNextLabelValue(Fmxtee::Engine::TChartAxis* Sender, double &tmpValue);
	
protected:
	virtual void __fastcall ChartEvent(Fmxtee::Engine::TChartToolEvent AEvent);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetAxis(Fmxtee::Engine::TChartAxis* const Value);
	double __fastcall AdjustCalcPosPoint(const int pixelVal);
	void __fastcall AxisBreakDoAllowScroll(Fmxtee::Engine::TChartAxis* Sender, double &AMin, double &AMax, bool &AllowScroll);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TAxisBreaksTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TAxisBreaksTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	double __fastcall TotalLength(const double AFrom, const double ATo);
	
__published:
	__property Brush;
	__property TAxisBreaks* Breaks = {read=FBreaks, write=SetBreaks};
	__property double ScaleAdjustment = {read=FScaleAdjustment, write=SetScaleAdjustment};
	__property int GapSize = {read=FGapSize, write=SetGapSize, default=5};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE int TeeMaxPixelPos;
}	/* namespace Axisbreaks */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_AXISBREAKS)
using namespace Fmxtee::Tools::Axisbreaks;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_AxisbreaksHPP
