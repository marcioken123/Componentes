// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBCal.pas' rev: 31.00 (Windows)

#ifndef LmddbcalHPP
#define LmddbcalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.DBCtrls.hpp>
#include <Data.DB.hpp>
#include <LMDCal.hpp>
#include <LMDDBBase.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDControl.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <System.UITypes.hpp>
#include <LMDTypes.hpp>
#include <LMDBevel.hpp>
#include <LMDFillObject.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbcal
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBCalendar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBCalendar : public Lmdcal::TLMDCustomCalendar
{
	typedef Lmdcal::TLMDCustomCalendar inherited;
	
private:
	Vcl::Dbctrls::TFieldDataLink* FDataLink;
	System::Classes::TNotifyEvent FOnDataChange;
	void __fastcall SetDataField(const System::UnicodeString aValue);
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	System::UnicodeString __fastcall GetDataField(void);
	Data::Db::TDataSource* __fastcall GetDataSource(void);
	Data::Db::TField* __fastcall GetField(void);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall EditingChange(System::TObject* Sender);
	void __fastcall UpDateData(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Msg);
	MESSAGE void __fastcall CMGetDataLink(Winapi::Messages::TMessage &Message);
	
protected:
	Data::Db::TDataLink* __fastcall GetDataLink(void);
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoDateChange(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDDBCalendar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDDBCalendar(void);
	__property DockManager;
	DYNAMIC bool __fastcall ExecuteAction(System::Classes::TBasicAction* AAction);
	virtual bool __fastcall UpdateAction(System::Classes::TBasicAction* AAction);
	__property Data::Db::TField* Field = {read=GetField};
	
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
	__property Bevel;
	__property CellStyle;
	__property Cursor = {default=0};
	__property System::UnicodeString DataField = {read=GetDataField, write=SetDataField};
	__property Data::Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property DayCaptionCellStyle;
	__property DayCaptions = {default=0};
	__property DayDirection = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
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
	__property Left;
	__property ListIndex = {index=1, default=0};
	__property MarkedCellStyle;
	__property MarkedDay = {index=0, default=0};
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
	__property Tag = {default=0};
	__property Top;
	__property Transparent = {default=0};
	__property UseLongDayNames = {index=2, default=0};
	__property Width;
	__property OnClick;
	__property OnDateSel;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnDraw;
	__property OnEndDrag;
	__property OnGetCellSettings;
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
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBCalendar(HWND ParentWindow) : Lmdcal::TLMDCustomCalendar(ParentWindow) { }
	
private:
	void *__IDataControl;	// Lmddbbase::IDataControl 
	
public:
	operator Lmddbbase::IDataControl*(void) { return (Lmddbbase::IDataControl*)&__IDataControl; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbcal */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBCAL)
using namespace Lmddbcal;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbcalHPP
