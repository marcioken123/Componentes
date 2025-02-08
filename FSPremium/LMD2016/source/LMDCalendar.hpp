// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalendar.pas' rev: 31.00 (Windows)

#ifndef LmdcalendarHPP
#define LmdcalendarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCal.hpp>
#include <Vcl.Controls.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <System.Classes.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDFaceController.hpp>
#include <LMDBevel.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalendar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalendar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCalendar : public Lmdcal::TLMDCustomCalendar
{
	typedef Lmdcal::TLMDCustomCalendar inherited;
	
public:
	__property DockManager;
	
__published:
	__property Anchors = {default=3};
	__property AutoSize = {default=0};
	__property Constraints;
	__property UseDockManager = {default=0};
	__property DockSite = {default=0};
	__property DragKind = {default=0};
	__property BiDiMode;
	__property ParentBiDiMode = {default=1};
	__property OnCanResize;
	__property OnConstrainedResize;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
	__property OnGetSiteInfo;
	__property OnStartDock;
	__property OnUnDock;
	__property About = {default=0};
	__property Align = {default=0};
	__property BackFX;
	__property FaceController;
	__property Bevel;
	__property CellStyle;
	__property Cursor = {default=0};
	__property Date = {index=0, default=0};
	__property Day = {index=0, default=30};
	__property DayCaptionCellStyle;
	__property DayCaptions = {default=0};
	__property DayDirection = {default=0};
	__property DragMode = {default=0};
	__property DragCursor = {default=-12};
	__property FillObject;
	__property FixedDimens = {index=6, default=1};
	__property Flat = {default=0};
	__property GridPen;
	__property Header;
	__property Height;
	__property HelpContext = {default=0};
	__property Hint;
	__property ImageIndex = {index=0, default=0};
	__property ImageList;
	__property InactiveCellStyle;
	__property Left;
	__property ListIndex = {index=1, default=0};
	__property MarkedCellStyle;
	__property Marked2CellStyle;
	__property MarkedDay = {index=0, default=0};
	__property MarkedDay2 = {index=1, default=0};
	__property Month = {index=1, default=12};
	__property Name = {default=0};
	__property PopupMenu;
	__property ReadOnly = {index=7, default=0};
	__property SelectedCellStyle;
	__property ShowDayHint = {index=1, default=0};
	__property ShowGrid = {index=4, default=1};
	__property ShowHint;
	__property ShowSpecialDayHint = {index=3, default=1};
	__property SpecialDates;
	__property StartDay;
	__property StartWithActualDate = {index=0, default=0};
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Tag = {default=0};
	__property Top;
	__property Transparent = {default=0};
	__property UseLongDayNames = {index=2, default=0};
	__property Width;
	__property Year = {index=2, default=1899};
	__property OnClick;
	__property OnDayChange;
	__property OnDateSel;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDraw;
	__property OnEndDrag;
	__property OnKeyPressed;
	__property OnMonthChange;
	__property OnMouseClick;
	__property OnMouseDown;
	__property OnMouseEnter;
	__property OnMouseExit;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnMouseWheel;
	__property OnStartDrag;
	__property OnYearChange;
	__property OnGetCellSettings;
public:
	/* TLMDCustomCalendar.Create */ inline __fastcall virtual TLMDCalendar(System::Classes::TComponent* aOwner) : Lmdcal::TLMDCustomCalendar(aOwner) { }
	/* TLMDCustomCalendar.Destroy */ inline __fastcall virtual ~TLMDCalendar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCalendar(HWND ParentWindow) : Lmdcal::TLMDCustomCalendar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalendar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALENDAR)
using namespace Lmdcalendar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalendarHPP
