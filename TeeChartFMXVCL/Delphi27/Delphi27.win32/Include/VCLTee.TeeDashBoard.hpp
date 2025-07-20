// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDashBoard.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedashboardHPP
#define Vcltee_TeedashboardHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeSubChart.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <System.UITypes.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedashboard
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDashBoard;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDashBoard : public Vcltee::Chart::TCustomChart
{
	typedef Vcltee::Chart::TCustomChart inherited;
	
private:
	int ChartIndex;
	Vcltee::Teesubchart::TSubChartTool* FContainer;
	void __fastcall DrawChartCorners(Vcltee::Chart::TChart* const Chart);
	void __fastcall DashBoardDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall DashBoardMouseMove(System::TObject* Sender, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall ChartMouseDown(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DashBoardDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall DashBoardMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall DeletingChart(Vcltee::Teesubchart::TSubChartTool* Sender, Vcltee::Teesubchart::TSubChart* Item);
	void __fastcall AddedChart(Vcltee::Teesubchart::TSubChartTool* Sender, Vcltee::Teesubchart::TSubChart* Item);
	
protected:
	bool IDontResetCanvas;
	DYNAMIC void __fastcall Resize();
	
public:
	__fastcall virtual TDashBoard(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDashBoard();
	Vcltee::Chart::TChart* __fastcall AddChart(const System::UnicodeString AName = System::UnicodeString());
	void __fastcall ResetPositions();
	Vcltee::Teesubchart::TChartCollection* __fastcall GetCharts();
	System::Uitypes::TModalResult __fastcall ShowEditor();
	
__published:
	__property Tools;
	__property BackImage;
	__property BackImageMode = {default=0};
	__property Border;
	__property BorderRound = {default=0};
	__property Emboss;
	__property Gradient;
	__property OnAfterDraw;
	__property BufferedDisplay = {default=1};
	__property MarginLeft = {index=0, default=3};
	__property MarginTop = {index=1, default=4};
	__property MarginRight = {index=2, default=3};
	__property MarginBottom = {index=3, default=4};
	__property MarginUnits = {default=0};
	__property Monochrome = {default=0};
	__property PrintProportional = {default=1};
	__property PrintResolution = {default=0};
	__property Shadow;
	__property View3D = {default=1};
	__property View3DOptions;
	__property Align = {default=0};
	__property BevelInner = {default=0};
	__property BevelOuter = {default=2};
	__property BevelWidth = {default=1};
	__property BorderWidth = {default=0};
	__property Color = {default=-16777201};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property ParentColor = {default=0};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property DragKind = {default=0};
	__property Locked = {default=0};
	__property OnClick;
	__property OnContextPopup;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnMouseWheel;
	__property OnMouseWheelDown;
	__property OnMouseWheelUp;
	__property OnStartDrag;
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property OnMouseEnter;
	__property OnMouseLeave;
	__property Vcltee::Teesubchart::TChartCollection* Charts = {read=GetCharts};
	__property Vcltee::Teesubchart::TSubChartTool* Container = {read=FContainer};
public:
	/* TWinControl.CreateParented */ inline __fastcall TDashBoard(HWND ParentWindow) : Vcltee::Chart::TCustomChart(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedashboard */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDASHBOARD)
using namespace Vcltee::Teedashboard;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedashboardHPP
