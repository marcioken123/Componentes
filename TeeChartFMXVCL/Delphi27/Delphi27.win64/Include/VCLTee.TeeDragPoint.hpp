// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDragPoint.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedragpointHPP
#define Vcltee_TeedragpointHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedragpoint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDragPointTool;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TDragPointToolEvent)(TDragPointTool* Sender, int Index);

typedef void __fastcall (__closure *TDragPointStartEvent)(TDragPointTool* Sender, int Index, bool &Start);

enum DECLSPEC_DENUM TDragPointStyle : unsigned char { dsX, dsY, dsBoth };

class PASCALIMPLEMENTATION TDragPointTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	TDragPointStyle FDragStyle;
	TDragPointToolEvent FOnDrag;
	TDragPointToolEvent FOnEndDrag;
	TDragPointStartEvent FOnStartDrag;
	int IDragging;
	
protected:
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
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
}	/* namespace Teedragpoint */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDRAGPOINT)
using namespace Vcltee::Teedragpoint;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedragpointHPP
