// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sMonthCalendar.pas' rev: 27.00 (Windows)

#ifndef SmonthcalendarHPP
#define SmonthcalendarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.Grids.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sMessages.hpp>	// Pascal unit
#include <sDateUtils.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Smonthcalendar
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TGetCellParams)(System::TObject* Sender, System::TDateTime Date, Vcl::Graphics::TFont* AFont, System::Uitypes::TColor &Background);

class DELPHICLASS TsCalendGrid;
class DELPHICLASS TsMonthCalendar;
class PASCALIMPLEMENTATION TsCalendGrid : public Vcl::Grids::TDrawGrid
{
	typedef Vcl::Grids::TDrawGrid inherited;
	
private:
	TsMonthCalendar* FOwner;
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseActivate(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	
public:
	bool Clicked;
	DYNAMIC void __fastcall Click(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual void __fastcall DrawCell(int ACol, int ARow, const System::Types::TRect &ARect, Vcl::Grids::TGridDrawState AState);
	virtual void __fastcall Paint(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall AfterConstruction(void);
	__fastcall virtual TsCalendGrid(System::Classes::TComponent* AOwner);
	HIDESBASE void __fastcall MouseToCell(int X, int Y, int &ACol, int &ARow);
	__property GridLineWidth = {default=1};
	__property DefaultColWidth = {default=64};
	__property DefaultRowHeight = {default=24};
public:
	/* TCustomGrid.Destroy */ inline __fastcall virtual ~TsCalendGrid(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCalendGrid(HWND ParentWindow) : Vcl::Grids::TDrawGrid(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TsMonthCalendar : public Spanel::TsPanel
{
	typedef Spanel::TsPanel inherited;
	
private:
	System::TDateTime FDate;
	int FMonthOffset;
	System::Classes::TNotifyEvent FOnChange;
	bool FReadOnly;
	System::Uitypes::TCalDayOfWeek FStartOfWeek;
	bool FUpdating;
	bool FUseCurrentDate;
	Sconst::TDaysOfWeek FWeekends;
	System::Uitypes::TColor FWeekendColor;
	bool FShowTitle;
	TGetCellParams FOnGetCellParams;
	bool FShowCurrentDate;
	TGetCellParams FOnDrawDay;
	bool FShowWeeks;
	bool FShowTodayBtn;
	bool FShowSelectAlways;
	bool FShowYearBtns;
	bool FShowMonthBtns;
	System::TDateTime FMinDate;
	System::TDateTime FMaxDate;
	System::UnicodeString __fastcall GetCellText(int ACol, int ARow);
	int __fastcall GetDateElement(int Index);
	void __fastcall SetCalendarDate(System::TDateTime Value);
	void __fastcall SetDateElement(int Index, int Value);
	void __fastcall SetStartOfWeek(System::Uitypes::TCalDayOfWeek Value);
	void __fastcall SetUseCurrentDate(bool Value);
	void __fastcall SetWeekendColor(System::Uitypes::TColor Value);
	void __fastcall SetWeekends(Sconst::TDaysOfWeek Value);
	bool __fastcall IsWeekend(int ACol, int ARow);
	void __fastcall CalendarUpdate(bool DayOnly);
	bool __fastcall StoreCalendarDate(void);
	int __fastcall FirstDay(void);
	void __fastcall TopPanelDblClick(System::TObject* Sender);
	void __fastcall SetShowTitle(const bool Value);
	void __fastcall SetShowCurrentDate(const bool Value);
	void __fastcall SetShowWeeks(const bool Value);
	void __fastcall SetShowTodayBtn(const bool Value);
	void __fastcall SetShowSelectAlways(const bool Value);
	void __fastcall SetShowMonthBtns(const bool Value);
	void __fastcall SetShowYearBtns(const bool Value);
	void __fastcall SetMaxDate(const System::TDateTime Value);
	void __fastcall SetMinDate(const System::TDateTime Value);
	
protected:
	Vcl::Menus::TPopupMenu* PopMenu;
	void __fastcall Change(void);
	void __fastcall ChangeMonth(int Delta);
	int __fastcall DaysThisMonth(void);
	void __fastcall PrevMonthBtnClick(System::TObject* Sender);
	void __fastcall NextMonthBtnClick(System::TObject* Sender);
	void __fastcall PrevYearBtnClick(System::TObject* Sender);
	void __fastcall NextYearBtnClick(System::TObject* Sender);
	void __fastcall MenuClick(System::TObject* Sender);
	void __fastcall TodayClick(System::TObject* Sender);
	void __fastcall TitleClick(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MakePopup(void);
	void __fastcall UpdateProps(void);
	void __fastcall UpdateNavBtns(void);
	
public:
	TsCalendGrid* FGrid;
	Spanel::TsDragBar* FDragBar;
	Sspeedbutton::TsSpeedButton* FTodayBtn;
	System::StaticArray<Sspeedbutton::TsTimerSpeedButton*, 4> FBtns;
	__fastcall virtual TsMonthCalendar(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall Loaded(void);
	bool __fastcall IsValidDate(System::TDateTime Date);
	void __fastcall NextMonth(void);
	void __fastcall NextYear(void);
	void __fastcall PrevMonth(void);
	void __fastcall PrevYear(void);
	void __fastcall UpdateCalendar(void);
	__property System::UnicodeString CellText[int ACol][int ARow] = {read=GetCellText};
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	__property TGetCellParams OnDrawDay = {read=FOnDrawDay, write=FOnDrawDay};
	__property System::TDateTime MaxDate = {read=FMaxDate, write=SetMaxDate};
	__property System::TDateTime MinDate = {read=FMinDate, write=SetMinDate};
	
__published:
	__property Align = {default=0};
	__property BorderWidth = {default=0};
	__property BevelWidth = {default=5};
	__property Width = {default=178};
	__property Height = {default=139};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TGetCellParams OnGetCellParams = {read=FOnGetCellParams, write=FOnGetCellParams};
	__property System::TDateTime CalendarDate = {read=FDate, write=SetCalendarDate, stored=StoreCalendarDate};
	__property int Day = {read=GetDateElement, write=SetDateElement, stored=false, index=3, nodefault};
	__property int Month = {read=GetDateElement, write=SetDateElement, stored=false, index=2, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property System::Uitypes::TCalDayOfWeek StartOfWeek = {read=FStartOfWeek, write=SetStartOfWeek, default=7};
	__property bool ShowCurrentDate = {read=FShowCurrentDate, write=SetShowCurrentDate, default=1};
	__property bool ShowSelectAlways = {read=FShowSelectAlways, write=SetShowSelectAlways, default=1};
	__property bool ShowTitle = {read=FShowTitle, write=SetShowTitle, default=1};
	__property bool ShowTodayBtn = {read=FShowTodayBtn, write=SetShowTodayBtn, default=0};
	__property bool ShowWeeks = {read=FShowWeeks, write=SetShowWeeks, default=0};
	__property bool ShowYearBtns = {read=FShowYearBtns, write=SetShowYearBtns, default=1};
	__property bool ShowMonthBtns = {read=FShowMonthBtns, write=SetShowMonthBtns, default=1};
	__property bool UseCurrentDate = {read=FUseCurrentDate, write=SetUseCurrentDate, default=1};
	__property System::Uitypes::TColor WeekendColor = {read=FWeekendColor, write=SetWeekendColor, default=255};
	__property Sconst::TDaysOfWeek Weekends = {read=FWeekends, write=SetWeekends, default=64};
	__property int Year = {read=GetDateElement, write=SetDateElement, stored=false, index=1, nodefault};
public:
	/* TsPanel.Destroy */ inline __fastcall virtual ~TsMonthCalendar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsMonthCalendar(HWND ParentWindow) : Spanel::TsPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString s_WeeksTitle;
}	/* namespace Smonthcalendar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SMONTHCALENDAR)
using namespace Smonthcalendar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SmonthcalendarHPP
