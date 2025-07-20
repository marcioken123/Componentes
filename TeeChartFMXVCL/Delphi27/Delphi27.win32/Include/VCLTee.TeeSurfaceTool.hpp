// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSurfaceTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesurfacetoolHPP
#define Vcltee_TeesurfacetoolHPP

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
#include <System.UIConsts.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesurfacetool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSurfaceNearestTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSurfaceNearestTool : public Vcltee::Teengine::TTeeCustomToolSeries
{
	typedef Vcltee::Teengine::TTeeCustomToolSeries inherited;
	
private:
	System::Uitypes::TColor FCell;
	System::Uitypes::TColor FColumn;
	System::Uitypes::TColor FRow;
	System::Classes::TNotifyEvent FOnSelect;
	void __fastcall SetCell(const System::Uitypes::TColor Value);
	void __fastcall SetColumn(const System::Uitypes::TColor Value);
	void __fastcall SetRow(const System::Uitypes::TColor Value);
	
protected:
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetSeries(Vcltee::Teengine::TChartSeries* const Value);
	
public:
	int SelectedCell;
	__fastcall virtual TSurfaceNearestTool(System::Classes::TComponent* AOwner);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall GetRowCol(/* out */ double &Row, /* out */ double &Col);
	
__published:
	__property Active = {default=1};
	__property System::Uitypes::TColor CellColor = {read=FCell, write=SetCell, default=255};
	__property System::Uitypes::TColor ColumnColor = {read=FColumn, write=SetColumn, default=32768};
	__property System::Uitypes::TColor RowColor = {read=FRow, write=SetRow, default=16711680};
	__property Series;
	__property System::Classes::TNotifyEvent OnSelectCell = {read=FOnSelect, write=FOnSelect};
public:
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TSurfaceNearestTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesurfacetool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESURFACETOOL)
using namespace Vcltee::Teesurfacetool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesurfacetoolHPP
