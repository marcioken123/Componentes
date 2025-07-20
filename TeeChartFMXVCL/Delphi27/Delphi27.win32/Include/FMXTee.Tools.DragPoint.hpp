// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.DragPoint.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_DragpointHPP
#define Fmxtee_Tools_DragpointHPP

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
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Dragpoint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDragPointTool;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TDragPointToolEvent)(TDragPointTool* Sender, int Index);

typedef void __fastcall (__closure *TDragPointStartEvent)(TDragPointTool* Sender, int Index, bool &Start);

enum DECLSPEC_DENUM TDragPointStyle : unsigned char { dsX, dsY, dsBoth };

class PASCALIMPLEMENTATION TDragPointTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	TDragPointStyle FDragStyle;
	TDragPointToolEvent FOnDrag;
	TDragPointToolEvent FOnEndDrag;
	TDragPointStartEvent FOnStartDrag;
	int IDragging;
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TDragPointTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Active = {default=1};
	__property TDragPointStyle DragStyle = {read=FDragStyle, write=FDragStyle, default=2};
	__property Series;
	__property TDragPointToolEvent OnDragPoint = {read=FOnDrag, write=FOnDrag};
	__property TDragPointToolEvent OnEndDrag = {read=FOnEndDrag, write=FOnEndDrag};
	__property TDragPointStartEvent OnStartDrag = {read=FOnStartDrag, write=FOnStartDrag};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TDragPointTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Dragpoint */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_DRAGPOINT)
using namespace Fmxtee::Tools::Dragpoint;
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
#endif	// Fmxtee_Tools_DragpointHPP
