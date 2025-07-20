// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Gantt.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Series_GanttHPP
#define Fmxtee_Series_GanttHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Engine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Gantt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGanttSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGanttSeries : public Fmxtee::Series::TPointSeries
{
	typedef Fmxtee::Series::TPointSeries inherited;
	
private:
	Fmxtee::Engine::TMarksCallout* FCallout;
	Fmxtee::Engine::TChartValueList* FEndValues;
	Fmxtee::Engine::TChartValueList* FNextTask;
	Fmxtee::Engine::TMarksCallout* __fastcall GetCallout();
	Fmxtee::Canvas::TTeePen* __fastcall GetConnectingPen();
	Fmxtee::Engine::TChartValueList* __fastcall GetStartValues();
	void __fastcall SetCallout(Fmxtee::Engine::TMarksCallout* const Value);
	void __fastcall SetConnectingPen(Fmxtee::Canvas::TTeePen* Value);
	void __fastcall SetEndValues(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetNextTask(Fmxtee::Engine::TChartValueList* const Value);
	void __fastcall SetStartValues(Fmxtee::Engine::TChartValueList* const Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual bool __fastcall ClickedPointer(int ValueIndex, int tmpX, int tmpY, int x, int y)/* overload */;
	virtual void __fastcall DrawValue(int ValueIndex);
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Fmxtee::Engine::TSeriesMarkPosition* APosition);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TGanttSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TGanttSeries();
	int __fastcall AddGantt(const double AStart, const double AEnd, const double AY, const System::UnicodeString AXLabel = System::UnicodeString());
	int __fastcall AddGanttColor(const double AStart, const double AEnd, const double AY, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual int __fastcall AddXY(const double AXValue, const double AYValue, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	DYNAMIC bool __fastcall IsValidSourceOf(Fmxtee::Engine::TChartSeries* Value);
	virtual double __fastcall MaxXValue();
	
__published:
	__property Fmxtee::Engine::TMarksCallout* Callout = {read=GetCallout, write=SetCallout};
	__property ColorEachPoint = {default=1};
	__property Fmxtee::Canvas::TTeePen* ConnectingPen = {read=GetConnectingPen, write=SetConnectingPen};
	__property Fmxtee::Engine::TChartValueList* StartValues = {read=GetStartValues, write=SetStartValues};
	__property Fmxtee::Engine::TChartValueList* EndValues = {read=FEndValues, write=SetEndValues};
	__property Fmxtee::Engine::TChartValueList* NextTask = {read=FNextTask, write=SetNextTask};
	/* Hoisted overloads: */
	
protected:
	inline bool __fastcall  ClickedPointer(int ValueIndex, int tmpX, int tmpY, const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::ClickedPointer(ValueIndex, tmpX, tmpY, P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Gantt */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_GANTT)
using namespace Fmxtee::Series::Gantt;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES)
using namespace Fmxtee::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Series_GanttHPP
