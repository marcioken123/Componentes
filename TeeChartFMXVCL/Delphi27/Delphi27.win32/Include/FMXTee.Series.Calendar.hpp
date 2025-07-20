// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Calendar.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_CalendarHPP
#define Fmxtee_Series_CalendarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMX.Controls.hpp>
#include <FMX.Menus.hpp>
#include <FMX.Types.hpp>
#include <FMX.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Calendar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCalendarCell;
class DELPHICLASS TCalendarCellUpper;
class DELPHICLASS TCalendarSeries;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCalendarCell : public Fmxtee::Procs::TTeeShape
{
	typedef Fmxtee::Procs::TTeeShape inherited;
	
public:
	TCalendarSeries* Parent;
	
__published:
	__property Brush;
	__property Font;
	__property Gradient;
	__property Pen;
	__property Picture;
	__property Shadow;
	__property Transparency = {default=0};
	__property Transparent = {stored=true};
	__property Visible;
public:
	/* TTeeCustomShape.Create */ inline __fastcall virtual TCalendarCell(Fmxtee::Procs::TCustomTeePanel* const AOwner)/* overload */ : Fmxtee::Procs::TTeeShape(AOwner) { }
	/* TTeeCustomShape.Destroy */ inline __fastcall virtual ~TCalendarCell() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCalendarCellUpper : public TCalendarCell
{
	typedef TCalendarCell inherited;
	
private:
	bool FUpper;
	System::UnicodeString FFormat;
	void __fastcall SetUpperCase(const bool Value);
	void __fastcall SetFormat(const System::UnicodeString Value);
	
__published:
	__property System::UnicodeString Format = {read=FFormat, write=SetFormat};
	__property bool UpperCase = {read=FUpper, write=SetUpperCase, default=0};
public:
	/* TTeeCustomShape.Create */ inline __fastcall virtual TCalendarCellUpper(Fmxtee::Procs::TCustomTeePanel* const AOwner)/* overload */ : TCalendarCell(AOwner) { }
	/* TTeeCustomShape.Destroy */ inline __fastcall virtual ~TCalendarCellUpper() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TCalendarChangeEvent)(TCalendarSeries* Sender, System::TDateTime &Value);

typedef void __fastcall (__closure *TCalendarDrawCellEvent)(TCalendarSeries* Sender, int Column, int Row, const System::UnicodeString Text, bool &DrawText);

class PASCALIMPLEMENTATION TCalendarSeries : public Fmxtee::Engine::TChartSeries
{
	typedef Fmxtee::Engine::TChartSeries inherited;
	
private:
	System::TDateTime FDate;
	TCalendarCell* FDays;
	TCalendarCellUpper* FMonths;
	Fmx::Stdctrls::TSpeedButton* FNextMonth;
	TCalendarChangeEvent FOnChange;
	TCalendarDrawCellEvent FOnDrawCell;
	Fmx::Menus::TPopupMenu* FPopupMenu;
	Fmx::Stdctrls::TSpeedButton* FPreviousMonth;
	TCalendarCell* FSunday;
	TCalendarCell* FToday;
	TCalendarCell* FTrailing;
	TCalendarCellUpper* FWeekDays;
	int IColumns;
	int IFirstDay;
	int IRows;
	Fmx::Stdctrls::TSpeedButton* __fastcall CreateButton(const System::UnicodeString ACaption, int ALeftPos);
	void __fastcall ChangeMonthMenu(System::TObject* Sender);
	Fmx::Menus::TPopupMenu* __fastcall GetPopupMenu();
	void __fastcall MonthClick(System::TObject* Sender);
	void __fastcall SetDate(System::TDateTime Value);
	void __fastcall SetMonths(TCalendarCellUpper* const Value);
	void __fastcall SetToday(TCalendarCell* const Value);
	void __fastcall SetDays(TCalendarCell* const Value);
	void __fastcall SetSunday(TCalendarCell* const Value);
	void __fastcall SetTrailing(TCalendarCell* const Value);
	void __fastcall SetWeekDays(TCalendarCellUpper* const Value);
	Fmx::Stdctrls::TSpeedButton* __fastcall GetNextMonth();
	bool __fastcall GetNextVisible();
	Fmx::Stdctrls::TSpeedButton* __fastcall GetPreviousMonth();
	bool __fastcall GetPreviousVisible();
	void __fastcall SetNextVisible(const bool Value);
	void __fastcall SetPreviousVisible(const bool Value);
	
protected:
	virtual void __fastcall DrawAllValues();
	void __fastcall DrawCell(int Column, int Row, const System::UnicodeString Text);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	int __fastcall XCell(const double Column);
	int __fastcall YCell(const double Row);
	
public:
	int DayOneRow;
	int DayOneColumn;
	__fastcall virtual TCalendarSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCalendarSeries();
	bool __fastcall CellDate(int ACol, int ARow, /* out */ System::TDateTime &ADate);
	void __fastcall CheckClick(int x, int y);
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	bool __fastcall ClickedDate(int x, int y, /* out */ System::TDateTime &ADate);
	System::Word __fastcall Month();
	void __fastcall NextMonth();
	DYNAMIC int __fastcall NumSampleValues();
	void __fastcall PreviousMonth();
	System::Types::TRectF __fastcall RectCell(int Column, int Row);
	int __fastcall Rows();
	System::Types::TRectF __fastcall SeriesRect();
	virtual bool __fastcall UseAxis();
	__property int Columns = {read=IColumns, nodefault};
	__property Fmx::Stdctrls::TSpeedButton* NextMonthButton = {read=GetNextMonth};
	__property Fmx::Menus::TPopupMenu* PopupMenu = {read=GetPopupMenu};
	__property Fmx::Stdctrls::TSpeedButton* PreviousMonthButton = {read=GetPreviousMonth};
	
__published:
	__property Active = {default=1};
	__property Cursor = {default=0};
	__property HorizAxis = {default=1};
	__property ParentChart;
	__property Pen;
	__property ShowInLegend = {default=1};
	__property Title = {default=0};
	__property VertAxis = {default=0};
	__property System::TDateTime Date = {read=FDate, write=SetDate};
	__property TCalendarCell* Days = {read=FDays, write=SetDays};
	__property TCalendarCellUpper* Months = {read=FMonths, write=SetMonths};
	__property bool NextButtonVisible = {read=GetNextVisible, write=SetNextVisible, default=1};
	__property bool PreviousButtonVisible = {read=GetPreviousVisible, write=SetPreviousVisible, default=1};
	__property TCalendarCell* Sunday = {read=FSunday, write=SetSunday};
	__property TCalendarCell* Today = {read=FToday, write=SetToday};
	__property TCalendarCell* Trailing = {read=FTrailing, write=SetTrailing};
	__property TCalendarCellUpper* WeekDays = {read=FWeekDays, write=SetWeekDays};
	__property AfterDrawValues;
	__property BeforeDrawValues;
	__property TCalendarChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property OnClick;
	__property OnDblClick;
	__property TCalendarDrawCellEvent OnDrawCell = {read=FOnDrawCell, write=FOnDrawCell};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Calendar */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_CALENDAR)
using namespace Fmxtee::Series::Calendar;
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
#endif	// Fmxtee_Series_CalendarHPP
