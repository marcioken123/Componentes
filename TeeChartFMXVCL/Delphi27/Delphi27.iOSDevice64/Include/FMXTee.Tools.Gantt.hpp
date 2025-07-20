// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Gantt.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Tools_GanttHPP
#define Fmxtee_Tools_GanttHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Series.Gantt.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Gantt
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGanttTool;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TGanttToolBarPart : unsigned char { pbStart, pbAll, pbEnd };

typedef void __fastcall (__closure *TGanttDragEvent)(TGanttTool* Sender, int GanttBar);

typedef void __fastcall (__closure *TGanttResizeEvent)(TGanttTool* Sender, int GanttBar, TGanttToolBarPart BarPart);

class PASCALIMPLEMENTATION TGanttTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	bool FAllowDrag;
	bool FAllowResize;
	int FBar;
	TGanttToolBarPart FBarPart;
	System::Uitypes::TCursor FCursorDrag;
	System::Uitypes::TCursor FCursorResize;
	int FMinPixels;
	double FXOriginal;
	TGanttDragEvent FOnDragBar;
	TGanttResizeEvent FOnResizeBar;
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TGanttTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	Fmxtee::Series::Gantt::TGanttSeries* __fastcall Gantt();
	
__published:
	__property Active = {default=1};
	__property bool AllowDrag = {read=FAllowDrag, write=FAllowDrag, default=1};
	__property bool AllowResize = {read=FAllowResize, write=FAllowResize, default=1};
	__property System::Uitypes::TCursor CursorDrag = {read=FCursorDrag, write=FCursorDrag, default=-21};
	__property System::Uitypes::TCursor CursorResize = {read=FCursorResize, write=FCursorResize, default=-9};
	__property int MinPixels = {read=FMinPixels, write=FMinPixels, default=5};
	__property Series;
	__property TGanttDragEvent OnDragBar = {read=FOnDragBar, write=FOnDragBar};
	__property TGanttResizeEvent OnResizeBar = {read=FOnResizeBar, write=FOnResizeBar};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TGanttTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Gantt */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_GANTT)
using namespace Fmxtee::Tools::Gantt;
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
#endif	// Fmxtee_Tools_GanttHPP
