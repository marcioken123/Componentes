// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCalendDlg.pas' rev: 31.00 (Windows)

#ifndef ElcalenddlgHPP
#define ElcalenddlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <System.TypInfo.hpp>
#include <ElCalendarDefs.hpp>
#include <ElDTPick.hpp>
#include <ElClock.hpp>
#include <ElStyleMan.hpp>
#include <ElComponent.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcalenddlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCalendarDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElCalendarDialog : public Elcomponent::TElBaseDlgComponent
{
	typedef Elcomponent::TElBaseDlgComponent inherited;
	
private:
	System::TDateTime FDate;
	Vcl::Graphics::TBitmap* FCurrentDayBitmap;
	bool FCurrentDayUseBitmap;
	System::Uitypes::TColor FLineBorderColor;
	bool FShowHolidays;
	bool FShowPeriods;
	Elcalendardefs::TDayOfWeek FStartOfWeek;
	bool FUseCurrentDate;
	bool FShowWeekNum;
	Elcalendardefs::TElWeekEndDays FWeekEndDays;
	System::TDateTime FPeriodStart;
	System::Word FPeriodLength;
	System::Word FPeriodInterval;
	System::Uitypes::TColor FPeriodColor;
	System::Uitypes::TColor FHolidayColor;
	System::Uitypes::TColor FWeekEndColor;
	bool FUseSystemStartOfWeek;
	Elcalendardefs::TElHolidays* FHolidays;
	bool FShowClock;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall PrepareDialog(Eldtpick::TElCalendarForm* FrmDialogComponent);
	
protected:
	Elvclutils::TElFlatBorderType FSelectionBorder;
	Elvclutils::TElFlatBorderType FDayCellBorder;
	Elvclutils::TElFlatBorderType FCurrentDayBorder;
	bool FUseLineColors;
	System::Uitypes::TColor FLineColorDark;
	System::Uitypes::TColor FLineColorLight;
	bool FTranslateDays;
	Elcalendardefs::TElHolidayEvent FOnDetermineHoliday;
	bool FUseXPThemes;
	bool FFlatButtons;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FGridVertLines;
	bool FGridHorzLines;
	System::Uitypes::TColor FGridLineColor;
	Elcalendardefs::TBeforeCellDrawEvent FOnBeforeCellDraw;
	System::Uitypes::TColor FOtherMonthDayColor;
	bool FShowOtherMonthDays;
	void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	void __fastcall SetStyleName(const System::UnicodeString Value);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetCurrentDayBitmap(Vcl::Graphics::TBitmap* Value);
	
public:
	__fastcall virtual TElCalendarDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElCalendarDialog(void);
	virtual bool __fastcall Execute(void);
	
__published:
	__property bool ShowClock = {read=FShowClock, write=FShowClock, nodefault};
	__property System::TDateTime Date = {read=FDate, write=FDate};
	__property bool FlatButtons = {read=FFlatButtons, write=FFlatButtons, default=1};
	__property bool ShowHolidays = {read=FShowHolidays, write=FShowHolidays, default=1};
	__property bool ShowPeriods = {read=FShowPeriods, write=FShowPeriods, nodefault};
	__property Elcalendardefs::TDayOfWeek StartOfWeek = {read=FStartOfWeek, write=FStartOfWeek, nodefault};
	__property bool UseCurrentDate = {read=FUseCurrentDate, write=FUseCurrentDate, nodefault};
	__property bool ShowWeekNum = {read=FShowWeekNum, write=FShowWeekNum, default=0};
	__property Elcalendardefs::TElWeekEndDays WeekEndDays = {read=FWeekEndDays, write=FWeekEndDays, nodefault};
	__property System::TDateTime PeriodStart = {read=FPeriodStart, write=FPeriodStart};
	__property System::Word PeriodLength = {read=FPeriodLength, write=FPeriodLength, default=1};
	__property System::Word PeriodInterval = {read=FPeriodInterval, write=FPeriodInterval, default=28};
	__property System::Uitypes::TColor PeriodColor = {read=FPeriodColor, write=FPeriodColor, default=16776960};
	__property System::Uitypes::TColor HolidayColor = {read=FHolidayColor, write=FHolidayColor, nodefault};
	__property System::Uitypes::TColor WeekEndColor = {read=FWeekEndColor, write=FWeekEndColor, default=-16777198};
	__property Elcalendardefs::TElHolidays* Holidays = {read=FHolidays};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property bool UseSystemStartOfWeek = {read=FUseSystemStartOfWeek, write=FUseSystemStartOfWeek, nodefault};
	__property Elvclutils::TElFlatBorderType SelectionBorder = {read=FSelectionBorder, write=FSelectionBorder, nodefault};
	__property Elvclutils::TElFlatBorderType DayCellBorder = {read=FDayCellBorder, write=FDayCellBorder, nodefault};
	__property Elvclutils::TElFlatBorderType CurrentDayBorder = {read=FCurrentDayBorder, write=FCurrentDayBorder, nodefault};
	__property bool CurrentDayUseBitmap = {read=FCurrentDayUseBitmap, write=FCurrentDayUseBitmap, default=0};
	__property Vcl::Graphics::TBitmap* CurrentDayBitmap = {read=FCurrentDayBitmap, write=SetCurrentDayBitmap};
	__property bool UseLineColors = {read=FUseLineColors, write=FUseLineColors, nodefault};
	__property System::Uitypes::TColor LineColorDark = {read=FLineColorDark, write=FLineColorDark, default=-16777200};
	__property System::Uitypes::TColor LineColorLight = {read=FLineColorLight, write=FLineColorLight, default=-16777211};
	__property System::Uitypes::TColor LineBorderColor = {read=FLineBorderColor, write=FLineBorderColor, default=-16777208};
	__property bool TranslateDays = {read=FTranslateDays, write=FTranslateDays, default=1};
	__property Elcalendardefs::TElHolidayEvent OnDetermineHoliday = {read=FOnDetermineHoliday, write=FOnDetermineHoliday};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property bool UseXPThemes = {read=FUseXPThemes, write=FUseXPThemes, default=1};
	__property bool GridVertLines = {read=FGridVertLines, write=FGridVertLines, default=1};
	__property bool GridHorzLines = {read=FGridHorzLines, write=FGridHorzLines, default=1};
	__property System::Uitypes::TColor GridLineColor = {read=FGridLineColor, write=FGridLineColor, default=-16777201};
	__property Elcalendardefs::TBeforeCellDrawEvent OnBeforeCellDraw = {read=FOnBeforeCellDraw, write=FOnBeforeCellDraw};
	__property System::Uitypes::TColor OtherMonthDayColor = {read=FOtherMonthDayColor, write=FOtherMonthDayColor, default=-16777199};
	__property bool ShowOtherMonthDays = {read=FShowOtherMonthDays, write=FShowOtherMonthDays, default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcalenddlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCALENDDLG)
using namespace Elcalenddlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcalenddlgHPP
