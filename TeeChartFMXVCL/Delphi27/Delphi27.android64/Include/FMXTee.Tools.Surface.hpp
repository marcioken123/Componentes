// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Surface.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Tools_SurfaceHPP
#define Fmxtee_Tools_SurfaceHPP

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
#include <System.UIConsts.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Tools.hpp>
#include <FMXTee.Series.Surface.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Surface
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSurfaceNearestTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSurfaceNearestTool : public Fmxtee::Engine::TTeeCustomToolSeries
{
	typedef Fmxtee::Engine::TTeeCustomToolSeries inherited;
	
private:
	System::Uitypes::TAlphaColor FCell;
	System::Uitypes::TAlphaColor FColumn;
	System::Uitypes::TAlphaColor FRow;
	System::Classes::TNotifyEvent FOnSelect;
	void __fastcall SetCell(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetColumn(const System::Uitypes::TAlphaColor Value);
	void __fastcall SetRow(const System::Uitypes::TAlphaColor Value);
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	
public:
	int SelectedCell;
	__fastcall virtual TSurfaceNearestTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall GetRowCol(/* out */ double &Row, /* out */ double &Col);
	
__published:
	__property Active = {default=1};
	__property System::Uitypes::TAlphaColor CellColor = {read=FCell, write=SetCell, default=-65536};
	__property System::Uitypes::TAlphaColor ColumnColor = {read=FColumn, write=SetColumn, default=-16744448};
	__property System::Uitypes::TAlphaColor RowColor = {read=FRow, write=SetRow, default=-16776961};
	__property Series;
	__property System::Classes::TNotifyEvent OnSelectCell = {read=FOnSelect, write=FOnSelect};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TSurfaceNearestTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Surface */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_SURFACE)
using namespace Fmxtee::Tools::Surface;
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
#endif	// Fmxtee_Tools_SurfaceHPP
