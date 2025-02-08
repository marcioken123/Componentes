// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCalendar.pas' rev: 31.00 (Windows)

#ifndef ElcalendarHPP
#define ElcalendarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTypes.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Types.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Math.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Themes.hpp>
#include <ElVCLUtils.hpp>
#include <ElStyleMan.hpp>
#include <ElImgFrm.hpp>
#include <LMDUtils.hpp>
#include <ElCalendarDefs.hpp>
#include <LMDElConst.hpp>
#include <intfLMDBase.hpp>
#include <LMDObjectList.hpp>
#include <LMDGraph.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDDateUtils.hpp>
#include <LMDProcs.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcalendar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCalendar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElCalendar : public Vcl::Grids::TCustomGrid
{
	typedef Vcl::Grids::TCustomGrid inherited;
	
private:
	Elcalendardefs::TElCustomCalendarNames* FCustomCalendarNames;
	Lmdtypes::TLMDAboutVar FAbout;
	System::Uitypes::TColor FHolidayColor;
	bool FShowPeriods;
	System::TDateTime FPeriodStart;
	System::Word FPeriodLength;
	System::Word FPeriodInterval;
	System::Uitypes::TColor FPeriodColor;
	bool FShowHolidays;
	Elcalendardefs::TElHolidays* FHolidays;
	System::Uitypes::TColor FWeekEndColor;
	Elcalendardefs::TElWeekEndDays FWeekEndDays;
	bool FShowWeekNum;
	System::TDateTime FDate;
	int FMonthOffset;
	System::Classes::TNotifyEvent FOnChange;
	bool FReadOnly;
	Elcalendardefs::TDayOfWeek FStartOfWeek;
	bool FUpdating;
	bool FUserNavigation;
	bool FUseCurrentDate;
	bool FTranslateDays;
	Vcl::Graphics::TBitmap* FTmpBmp;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elimgfrm::TElImageForm* FImgForm;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	bool FMouseOver;
	Lmdtypes::TLMDString FHint;
	bool FFlat;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FUseLineColors;
	Lmdgraph::TLMDBorderSides FBorderSides;
	Elvclutils::TElFlatBorderType FSelectionBorder;
	Elvclutils::TElFlatBorderType FDayCellBorder;
	Elvclutils::TElFlatBorderType FCurrentDayBorder;
	Vcl::Graphics::TBitmap* FCurrentDayBitmap;
	bool FCurrentDayUseBitmap;
	Vcl::Grids::TGridCoord FLastHit;
	Elvclutils::TElFlatBorderType FWeekNumCellBorder;
	void __fastcall NamesChanged(System::TObject* Sender);
	void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	Lmdtypes::TLMDString __fastcall GetCellText(int ACol, int ARow);
	int __fastcall GetDateElement(int Index);
	void __fastcall SetCalendarDate(System::TDateTime Value);
	void __fastcall SetDateElement(int Index, int Value);
	void __fastcall SetStartOfWeek(Elcalendardefs::TDayOfWeek Value);
	void __fastcall SetUseCurrentDate(bool Value);
	bool __fastcall StoreCalendarDate(void);
	void __fastcall SetShowWeekNum(bool newValue);
	void __fastcall SetWeekEndDays(Elcalendardefs::TElWeekEndDays newValue);
	void __fastcall SetWeekEndColor(System::Uitypes::TColor newValue);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Msg);
	void __fastcall SetHolidays(Elcalendardefs::TElHolidays* newValue);
	void __fastcall FixHolidayDate(Elcalendardefs::TElHoliday* AHoliday, System::TDateTime &Date);
	void __fastcall SetShowHolidays(bool newValue);
	void __fastcall SetShowPeriods(bool newValue);
	void __fastcall SetPeriodStart(System::TDateTime newValue);
	void __fastcall SetPeriodLength(System::Word newValue);
	void __fastcall SetPeriodInterval(System::Word newValue);
	void __fastcall SetPeriodColor(System::Uitypes::TColor newValue);
	void __fastcall SetHolidayColor(System::Uitypes::TColor newValue);
	void __fastcall SetDate(System::TDateTime newValue);
	void __fastcall SetFlat(bool newValue);
	void __fastcall SetTranslateDays(bool value);
	virtual void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	virtual void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall UpdateStyle(void);
	void __fastcall DrawFlatBorder(void);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanging(Winapi::Messages::TWMWindowPosMsg &Message);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	bool __fastcall StoreDate(void);
	void __fastcall SetLineColorLight(System::Uitypes::TColor Value);
	void __fastcall SetLineColorDark(System::Uitypes::TColor Value);
	void __fastcall SetUseLineColors(bool Value);
	void __fastcall SetSelectionBorder(Elvclutils::TElFlatBorderType Value);
	void __fastcall SetDayCellBorder(Elvclutils::TElFlatBorderType Value);
	void __fastcall SetCurrentDayBitmap(Vcl::Graphics::TBitmap* Value);
	void __fastcall SetCurrentDayUseBitmap(bool Value);
	void __fastcall SetCurrentDayBorder(Elvclutils::TElFlatBorderType Value);
	void __fastcall SetWeekNumCellBorder(Elvclutils::TElFlatBorderType Value);
	void __fastcall SetCustomCalendarNames(Elcalendardefs::TElCustomCalendarNames* const Value);
	
protected:
	System::Uitypes::TColor FLineBorderColor;
	System::Uitypes::TColor FLineColorLight;
	System::Uitypes::TColor FLineColorDark;
	bool FUseSystemStartOfWeek;
	Elcalendardefs::TElHolidayEvent FOnDetermineHoliday;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectColor;
	bool FHideSelection;
	System::Uitypes::TColor FHideSelectTextColor;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	System::Uitypes::TColor FGradientEndColor;
	System::Uitypes::TColor FGradientStartColor;
	int FGradientSteps;
	System::Uitypes::TColor FGridLineColor;
	int FHighlightAlphaLevel;
	System::Uitypes::TColor FDayNameColor;
	System::Uitypes::TColor FWeekNumColor;
	System::Uitypes::TColor FDayNameTextColor;
	System::Uitypes::TColor FWeekNumTextColor;
	Elcalendardefs::TBeforeCellDrawEvent FOnBeforeCellDraw;
	bool FShowOtherMonthDays;
	System::Uitypes::TColor FOtherMonthDayColor;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	virtual void __fastcall SetAutoSize(bool Value);
	virtual void __fastcall CalcSizes(void);
	void __fastcall SetLineBorderColor(System::Uitypes::TColor Value);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	DYNAMIC void __fastcall Change(void);
	void __fastcall ChangeMonth(int Delta);
	DYNAMIC void __fastcall Click(void);
	virtual int __fastcall DaysThisMonth(void);
	virtual bool __fastcall IsLeapYear(int AYear);
	virtual bool __fastcall SelectCell(int ACol, int ARow);
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateFrame(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SetUseSystemStartOfWeek(bool Value);
	virtual void __fastcall TriggerDetermineHoliday(System::Word ADay, System::Word AMonth, System::Word AYear, bool &IsHoliday);
	void __fastcall SetFocusedSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelection(bool Value);
	void __fastcall SetHideSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	HIDESBASE void __fastcall SetGradientEndColor(System::Uitypes::TColor newValue);
	HIDESBASE void __fastcall SetGradientStartColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientSteps(int newValue);
	void __fastcall RedoTmpBmp(void);
	void __fastcall ImageChange(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall Paint(void);
	void __fastcall SetGridLineColor(System::Uitypes::TColor Value);
	void __fastcall DrawBackground(Vcl::Graphics::TCanvas* Canvas);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DrawCell(int ACol, int ARow, const System::Types::TRect &ARect, Vcl::Grids::TGridDrawState AState);
	void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall SetDayNameColor(System::Uitypes::TColor Value);
	void __fastcall SetWeekNumColor(System::Uitypes::TColor Value);
	void __fastcall SetDayNameTextColor(System::Uitypes::TColor Value);
	void __fastcall SetWeekNumTextColor(System::Uitypes::TColor Value);
	bool __fastcall GetGridVertLines(void);
	void __fastcall SetGridVertLines(bool Value);
	bool __fastcall GetGridHorzLines(void);
	void __fastcall SetGridHorzLines(bool Value);
	void __fastcall TriggerBeforeCellDraw(Vcl::Graphics::TCanvas* Canvas, int RowNum, int ColNum, System::TDateTime Date, Elcalendardefs::TElCalendarCellTypes CellType);
	virtual int __fastcall DaysPrevMonth(void);
	void __fastcall SetShowOtherMonthDays(bool Value);
	void __fastcall SetOtherMonthDayColor(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TElCalendar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElCalendar(void);
	void __fastcall NextMonth(void);
	void __fastcall NextYear(void);
	void __fastcall PrevMonth(void);
	void __fastcall PrevYear(void);
	virtual void __fastcall UpdateCalendar(void);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	void __fastcall MouseToCell(int X, int Y, int &ACol, int &ARow);
	__property System::TDateTime CalendarDate = {read=FDate, write=SetCalendarDate, stored=StoreCalendarDate};
	__property Lmdtypes::TLMDString CellText[int ACol][int ARow] = {read=GetCellText};
	bool __fastcall IsHoliday(int AYear, int AMonth, int ADay);
	bool __fastcall IsInPeriod(System::Word AYear, System::Word AMonth, System::Word ADay);
	bool __fastcall IsRestHoliday(System::Word AYear, System::Word AMonth, System::Word ADay);
	int __fastcall GetEffectiveHeight(void);
	int __fastcall GetEffectiveWidth(void);
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Elcalendardefs::TElCustomCalendarNames* CustomCalendarNames = {read=FCustomCalendarNames, write=SetCustomCalendarNames};
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	__property System::TDateTime Date = {read=FDate, write=SetDate, stored=StoreDate};
	__property int Day = {read=GetDateElement, write=SetDateElement, stored=false, index=3, nodefault};
	__property Elcalendardefs::TElHolidays* Holidays = {read=FHolidays, write=SetHolidays};
	__property int Month = {read=GetDateElement, write=SetDateElement, stored=false, index=2, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=FReadOnly, default=0};
	__property Elcalendardefs::TDayOfWeek StartOfWeek = {read=FStartOfWeek, write=SetStartOfWeek, default=0};
	__property bool TranslateDays = {read=FTranslateDays, write=SetTranslateDays, default=1};
	__property bool UseCurrentDate = {read=FUseCurrentDate, write=SetUseCurrentDate, default=1};
	__property int Year = {read=GetDateElement, write=SetDateElement, stored=false, index=1, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property bool ShowWeekNum = {read=FShowWeekNum, write=SetShowWeekNum, default=0};
	__property Elcalendardefs::TElWeekEndDays WeekEndDays = {read=FWeekEndDays, write=SetWeekEndDays, default=65};
	__property System::Uitypes::TColor WeekEndColor = {read=FWeekEndColor, write=SetWeekEndColor, default=255};
	__property bool ShowHolidays = {read=FShowHolidays, write=SetShowHolidays, default=1};
	__property bool ShowPeriods = {read=FShowPeriods, write=SetShowPeriods, default=0};
	__property System::TDateTime PeriodStart = {read=FPeriodStart, write=SetPeriodStart};
	__property System::Word PeriodLength = {read=FPeriodLength, write=SetPeriodLength, default=1};
	__property System::Word PeriodInterval = {read=FPeriodInterval, write=SetPeriodInterval, default=28};
	__property System::Uitypes::TColor PeriodColor = {read=FPeriodColor, write=SetPeriodColor, default=16776960};
	__property System::Uitypes::TColor HolidayColor = {read=FHolidayColor, write=SetHolidayColor, default=-16777208};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool UserNavigation = {read=FUserNavigation, write=FUserNavigation, default=0};
	__property System::Uitypes::TColor LineColorLight = {read=FLineColorLight, write=SetLineColorLight, stored=FUseLineColors, default=-16777211};
	__property System::Uitypes::TColor LineColorDark = {read=FLineColorDark, write=SetLineColorDark, stored=FUseLineColors, default=-16777201};
	__property System::Uitypes::TColor LineBorderColor = {read=FLineBorderColor, write=SetLineBorderColor, default=-16777208};
	__property bool UseSystemStartOfWeek = {read=FUseSystemStartOfWeek, write=SetUseSystemStartOfWeek, default=1};
	__property bool UseLineColors = {read=FUseLineColors, write=SetUseLineColors, default=0};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Elvclutils::TElFlatBorderType SelectionBorder = {read=FSelectionBorder, write=SetSelectionBorder, default=1};
	__property Elvclutils::TElFlatBorderType DayCellBorder = {read=FDayCellBorder, write=SetDayCellBorder, default=11};
	__property Elvclutils::TElFlatBorderType CurrentDayBorder = {read=FCurrentDayBorder, write=SetCurrentDayBorder, default=1};
	__property bool CurrentDayUseBitmap = {read=FCurrentDayUseBitmap, write=SetCurrentDayUseBitmap, default=0};
	__property Vcl::Graphics::TBitmap* CurrentDayBitmap = {read=FCurrentDayBitmap, write=SetCurrentDayBitmap};
	__property Elcalendardefs::TElHolidayEvent OnDetermineHoliday = {read=FOnDetermineHoliday, write=FOnDetermineHoliday};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=SetFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=SetFocusedSelectTextColor, default=-16777202};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=SetHideSelectColor, default=-16777201};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=1};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=SetHideSelectTextColor, default=-16777200};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, default=0};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, default=0};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, default=16};
	__property System::Uitypes::TColor GridLineColor = {read=FGridLineColor, write=SetGridLineColor, default=-16777201};
	__property int HighlightAlphaLevel = {read=FHighlightAlphaLevel, write=SetHighlightAlphaLevel, default=255};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property System::Uitypes::TColor DayNameColor = {read=FDayNameColor, write=SetDayNameColor, default=-16777201};
	__property System::Uitypes::TColor WeekNumColor = {read=FWeekNumColor, write=SetWeekNumColor, default=-16777201};
	__property System::Uitypes::TColor DayNameTextColor = {read=FDayNameTextColor, write=SetDayNameTextColor, default=-16777198};
	__property System::Uitypes::TColor WeekNumTextColor = {read=FWeekNumTextColor, write=SetWeekNumTextColor, default=-16777198};
	__property Elvclutils::TElFlatBorderType WeekNumCellBorder = {read=FWeekNumCellBorder, write=SetWeekNumCellBorder, default=13};
	__property bool GridVertLines = {read=GetGridVertLines, write=SetGridVertLines, default=1};
	__property bool GridHorzLines = {read=GetGridHorzLines, write=SetGridHorzLines, default=1};
	__property Elcalendardefs::TBeforeCellDrawEvent OnBeforeCellDraw = {read=FOnBeforeCellDraw, write=FOnBeforeCellDraw};
	__property bool ShowOtherMonthDays = {read=FShowOtherMonthDays, write=SetShowOtherMonthDays, default=0};
	__property System::Uitypes::TColor OtherMonthDayColor = {read=FOtherMonthDayColor, write=SetOtherMonthDayColor, default=-16777199};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
	__property AutoSize = {default=0};
	__property Align = {default=0};
	__property BorderStyle = {default=1};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=1};
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnMouseMove;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property Floating;
	__property BevelKind = {default=0};
	__property DoubleBuffered;
	__property DragKind = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCalendar(HWND ParentWindow) : Vcl::Grids::TCustomGrid(ParentWindow) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcalendar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCALENDAR)
using namespace Elcalendar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcalendarHPP
