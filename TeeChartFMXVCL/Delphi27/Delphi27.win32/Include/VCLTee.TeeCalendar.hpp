// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCalendar.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecalendarHPP
#define Vcltee_TeecalendarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <System.UIConsts.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecalendar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCalendarCell;
class DELPHICLASS TCalendarCellUpper;
class DELPHICLASS TCalendarSeries;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TCalendarCell : public Vcltee::Teeprocs::TTeeShape
{
	typedef Vcltee::Teeprocs::TTeeShape inherited;
	
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
	/* TTeeCustomShape.Create */ inline __fastcall virtual TCalendarCell(Vcltee::Teeprocs::TCustomTeePanel* const AOwner)/* overload */ : Vcltee::Teeprocs::TTeeShape(AOwner) { }
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
	/* TTeeCustomShape.Create */ inline __fastcall virtual TCalendarCellUpper(Vcltee::Teeprocs::TCustomTeePanel* const AOwner)/* overload */ : TCalendarCell(AOwner) { }
	/* TTeeCustomShape.Destroy */ inline __fastcall virtual ~TCalendarCellUpper() { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TCalendarChangeEvent)(TCalendarSeries* Sender, System::TDateTime &Value);

typedef void __fastcall (__closure *TCalendarDrawCellEvent)(TCalendarSeries* Sender, int Column, int Row, const System::UnicodeString Text, bool &DrawText);

class PASCALIMPLEMENTATION TCalendarSeries : public Vcltee::Teengine::TChartSeries
{
	typedef Vcltee::Teengine::TChartSeries inherited;
	
private:
	System::TDateTime FDate;
	TCalendarCell* FDays;
	TCalendarCellUpper* FMonths;
	Vcl::Buttons::TSpeedButton* FNextMonth;
	TCalendarChangeEvent FOnChange;
	TCalendarDrawCellEvent FOnDrawCell;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	Vcl::Buttons::TSpeedButton* FPreviousMonth;
	TCalendarCell* FSunday;
	TCalendarCell* FToday;
	TCalendarCell* FTrailing;
	TCalendarCellUpper* FWeekDays;
	int IColumns;
	int IFirstDay;
	int IRows;
	Vcl::Buttons::TSpeedButton* __fastcall CreateButton(const System::UnicodeString ACaption, int ALeftPos);
	void __fastcall ChangeMonthMenu(System::TObject* Sender);
	Vcl::Menus::TPopupMenu* __fastcall GetPopupMenu();
	void __fastcall MonthClick(System::TObject* Sender);
	void __fastcall SetDate(System::TDateTime Value);
	void __fastcall SetMonths(TCalendarCellUpper* const Value);
	void __fastcall SetToday(TCalendarCell* const Value);
	void __fastcall SetDays(TCalendarCell* const Value);
	void __fastcall SetSunday(TCalendarCell* const Value);
	void __fastcall SetTrailing(TCalendarCell* const Value);
	void __fastcall SetWeekDays(TCalendarCellUpper* const Value);
	Vcl::Buttons::TSpeedButton* __fastcall GetNextMonth();
	bool __fastcall GetNextVisible();
	Vcl::Buttons::TSpeedButton* __fastcall GetPreviousMonth();
	bool __fastcall GetPreviousVisible();
	void __fastcall SetNextVisible(const bool Value);
	void __fastcall SetPreviousVisible(const bool Value);
	
protected:
	virtual void __fastcall DrawAllValues();
	void __fastcall DrawCell(int Column, int Row, const System::UnicodeString Text);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetActive(bool Value);
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	void __fastcall TeeEvent(Vcltee::Teeprocs::TTeeEvent* Event);
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
	System::Types::TRect __fastcall RectCell(int Column, int Row);
	int __fastcall Rows();
	System::Types::TRect __fastcall SeriesRect();
	virtual bool __fastcall UseAxis();
	__property int Columns = {read=IColumns, nodefault};
	__property Vcl::Buttons::TSpeedButton* NextMonthButton = {read=GetNextMonth};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=GetPopupMenu};
	__property Vcl::Buttons::TSpeedButton* PreviousMonthButton = {read=GetPreviousMonth};
	
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
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
private:
	void *__ITeeEventListener;	// Vcltee::Teeprocs::ITeeEventListener 
	
public:
	operator Vcltee::Teeprocs::ITeeEventListener*(void) { return (Vcltee::Teeprocs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecalendar */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECALENDAR)
using namespace Vcltee::Teecalendar;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecalendarHPP
