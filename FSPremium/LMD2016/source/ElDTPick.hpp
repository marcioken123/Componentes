// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElDTPick.pas' rev: 31.00 (Windows)

#ifndef EldtpickHPP
#define EldtpickHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.TypInfo.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.Themes.hpp>
#include <System.Variants.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDDateUtils.hpp>
#include <LMDObjectList.hpp>
#include <LMDSysIn.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDThemes.hpp>
#include <LMDUnicode.hpp>
#include <LMDGlyphs.hpp>
#include <LMDStrings.hpp>
#include <LMDElConst.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDDropdownForm.hpp>
#include <ElImgFrm.hpp>
#include <ElSpinBtn.hpp>
#include <ElPopBtn.hpp>
#include <ElCalendarDefs.hpp>
#include <ElClock.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <ElPanel.hpp>
#include <ElGroupBox.hpp>
#include <ElCalendar.hpp>
#include <ElSpin.hpp>
#include <ElCombos.hpp>
#include <ElBtnCtl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eldtpick
{
//-- forward type declarations -----------------------------------------------
struct TDTFPart;
class DELPHICLASS TElDateTimePicker;
class DELPHICLASS TElTClock;
class DELPHICLASS TElCalendarForm;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TDTFPart
{
public:
	System::UnicodeString Text;
	int DPart;
	int TSPos;
	int TEPos;
	int SPos;
	int EPos;
};


typedef TDTFPart *PDTFPart;

enum DECLSPEC_DENUM TElDatePickerFormat : unsigned char { edfShortDateLongTime, edfShortDateShortTime, edfLongDate, edfShortDate, edfLongTime, edfShortTime, edfCustom };

enum DECLSPEC_DENUM TElCalendarStyle : unsigned char { csElCalendar, csMonthCalendar };

class PASCALIMPLEMENTATION TElDateTimePicker : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
private:
	bool FUserNavigation;
	bool __fastcall GetCalendarUserNavigation(void);
	void __fastcall SetCalendarUserNavigation(const bool Value);
	void __fastcall SetCalendarFormFont(Vcl::Graphics::TFont* const Value);
	
protected:
	Elcalendardefs::TElCustomCalendarNames* FCustomCalendarNames;
	bool FIgnoreReadOnlyState;
	System::WideChar FUnassignedChar;
	bool FHandleDialogKeys;
	bool FModified;
	bool FShowCheckBox;
	bool FChecked;
	bool FAltChangeMethod;
	bool FShowPopupCalendar;
	bool FNavigationInPopup;
	Vcl::Forms::TFormBorderStyle FBorderStyle;
	System::Classes::TNotifyEvent FOnChange;
	bool Use12Hours;
	Elpopbtn::TElGraphicButton* FCalButton;
	Elspinbtn::TElSpinButton* FButton;
	int FBtnWidth;
	Lmdobjectlist::TLMDObjectList* DTFParts;
	System::UnicodeString FFormatStr;
	TElDatePickerFormat FFormat;
	System::TDateTime FDate;
	bool FFocused;
	int FCurPart;
	System::Classes::TAlignment FAlignment;
	bool FMouseOver;
	TElCalendarForm* FForm;
	HDC TmpDC;
	System::Classes::TNotifyEvent FOnDropDown;
	int FGradientSteps;
	System::Uitypes::TColor FGradientStartColor;
	System::Uitypes::TColor FGradientEndColor;
	Vcl::Graphics::TBitmap* FTmpBmp;
	bool FTransparent;
	Vcl::Graphics::TBitmap* FBackground;
	Lmdgraph::TLMDBackgroundType FBackgroundType;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elimgfrm::TElImageForm* FImgForm;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FFlat;
	System::TDateTime FMinDate;
	System::TDateTime FMaxDate;
	int FFontMargin;
	System::UnicodeString FDI;
	Lmdtypes::TLMDString FText;
	bool FDroppedDown;
	bool InDblClick;
	System::Classes::TNotifyEvent FOnCheckBoxChange;
	Lmdgraph::TLMDBorderSides FBorderSides;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	bool FButtonVisible;
	bool FUnassigned;
	System::Uitypes::TColor FUnassignedColor;
	bool FUnassignedAllowed;
	bool FReadOnly;
	bool FButtonShowOnFocus;
	bool FUseCurrentDate;
	bool FButtonThinFrame;
	bool FAutoSize;
	bool FAlwaysResetUnassigned;
	Lmdtypes::TLMDString FHint;
	bool FShowBlankWhenZero;
	bool FAutoAdvance;
	System::Uitypes::TColor FFocusedSelectColor;
	System::Uitypes::TColor FFocusedSelectTextColor;
	System::Uitypes::TColor FHideSelectColor;
	System::Uitypes::TColor FHideSelectTextColor;
	bool FHideSelection;
	int FHighlightAlphaLevel;
	System::Uitypes::TColor FButtonColor;
	bool FButtonShowBorder;
	Elvclutils::TElLinkCtlPos FLinkedControlPosition;
	Vcl::Controls::TControl* FLinkedControl;
	int FLinkedControlSpacing;
	System::Classes::TAlignment FDropDownAlignment;
	bool FCalendarKeepWithinForm;
	bool FButtonFlat;
	bool FButtonOldStyled;
	System::Uitypes::TColor FDisabledColor;
	System::Uitypes::TColor FDisabledFontColor;
	bool FUseDisabledColors;
	bool FButtonUseSystemWidth;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	bool FCalendarShowClock;
	bool FShowTodayButton;
	System::Uitypes::TColor FLineColorLight;
	System::Uitypes::TColor FLineColorDark;
	System::Uitypes::TColor FCalendarBackColor;
	System::Uitypes::TColor FCalendarFormColor;
	Vcl::Graphics::TFont* FCalendarFormFont;
	Elcalendardefs::TDayOfWeek FStartOfWeek;
	Elcalendardefs::TElWeekEndDays FWeekEndDays;
	bool FUseSystemStartOfWeek;
	bool FUseLineColors;
	System::Uitypes::TColor FWeekendColor;
	bool FCalendarGridVertLines;
	Elvclutils::TElFlatBorderType FCurrentDayBorder;
	Elvclutils::TElFlatBorderType FCalendarDayCellBorder;
	Elvclutils::TElFlatBorderType FCalendarSelectionBorder;
	bool FTranslateDays;
	Elcalendardefs::TElHolidays* FCalendarHolidays;
	bool FCalendarShowWeekNum;
	Elcalendardefs::TElHolidayEvent FOnDetermineHoliday;
	System::Uitypes::TColor FCalendarHolidayColor;
	bool FCalendarGridHorzLines;
	System::Uitypes::TColor FCalendarGridLineColor;
	System::Uitypes::TColor FCalendarOtherMonthDayColor;
	Elcalendardefs::TBeforeCellDrawEvent FOnBeforeCellDraw;
	bool FCalendarShowOtherMonthDays;
	Elvclutils::TElDisplayOptions* FDisplayReadOnlyOptions;
	System::Uitypes::TColor FCalendarLineBorderColor;
	Vcl::Graphics::TBitmap* FCalendarCurrentDayBitmap;
	bool FCalendarCurrentDayUseBitmap;
	System::Classes::TNotifyEvent FOldFontChanged;
	bool FUseMonthCalendar;
	bool FCalendarFlatButtons;
	bool __fastcall GetCalendarLiveClock(void);
	void __fastcall SetCalendarLiveClock(bool AValue);
	Vcl::Themes::TThemedElementDetails __fastcall GetThemedElementDetails(void);
	void __fastcall NamesChanged(System::TObject* Sender);
	void __fastcall SetCustomCalendarNames(Elcalendardefs::TElCustomCalendarNames* const Value);
	void __fastcall ChangeBtnGlyph(void);
	TElCalendarStyle __fastcall GetCalendarStyle(void);
	void __fastcall SetCalendarStyle(const TElCalendarStyle Value);
	void __fastcall ChangeToNearValid(_SYSTEMTIME &ST, int Param);
	HIDESBASE void __fastcall FontChanged(System::TObject* Sender);
	void __fastcall CalendarFormFontChange(System::TObject* Sender);
	void __fastcall CalcFormSizes(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMSysKeyDown(Winapi::Messages::TWMKey &Msg);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Msg);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseWheel(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Msg);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SetDisplayReadOnlyOptions(Elvclutils::TElDisplayOptions* const Value);
	void __fastcall SetBorderStyle(Vcl::Forms::TBorderStyle Value);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetTransparent(bool newValue);
	void __fastcall SetBackground(Vcl::Graphics::TBitmap* newValue);
	void __fastcall SetBackgroundType(Lmdgraph::TLMDBackgroundType newValue);
	void __fastcall ImageChange(System::TObject* Sender);
	void __fastcall CurrDayImageChange(System::TObject* Sender);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall SetGradientStartColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientEndColor(System::Uitypes::TColor newValue);
	void __fastcall SetGradientSteps(int newValue);
	void __fastcall RedoTmpBmp(void);
	void __fastcall DrawFlatBorder(void);
	virtual void __fastcall PaintWindow(HDC DC);
	void __fastcall InvalidateEdit(void);
	virtual void __fastcall CloseUp(bool AcceptValue);
	void __fastcall CalendarDeactivate(System::TObject* Sender);
	void __fastcall SpinUpClick(System::TObject* Sender, double Increment);
	void __fastcall SpinDownClick(System::TObject* Sender, double Increment);
	void __fastcall CalBtnClick(System::TObject* Sender);
	void __fastcall IncValue(int Increment);
	void __fastcall ParseFormat(System::UnicodeString AFormat);
	void __fastcall UpdatePart(void);
	void __fastcall UpdateFrame(void);
	void __fastcall UpdateText(System::TDateTime ADate = 0.000000E+00)/* overload */;
	void __fastcall UpdateText(const _SYSTEMTIME &ST)/* overload */;
	void __fastcall OnDTFPartDelete(System::TObject* Sender, void * &Item);
	virtual System::Uitypes::TColor __fastcall GetTextColor(void);
	virtual System::Uitypes::TColor __fastcall GetBkColor(void);
	System::UnicodeString __fastcall GetStdFormat(TElDatePickerFormat Fmt);
	void __fastcall TuneupCalendarControls(void);
	bool __fastcall GetCalendarUseLineColors(void);
	void __fastcall SetCalendarUseLineColors(bool Value);
	bool __fastcall StoreStartOfWeek(void);
	System::Uitypes::TColor __fastcall GetCalendarWeekendColor(void);
	void __fastcall SetCalendarWeekendColor(System::Uitypes::TColor Value);
	void __fastcall DrawFlatFrame(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	void __fastcall SetBorderSides(Lmdgraph::TLMDBorderSides Value);
	virtual void __fastcall SetFormat(TElDatePickerFormat newValue);
	virtual void __fastcall SetFormatStr(System::UnicodeString newValue);
	virtual void __fastcall SetDateTime(System::TDateTime newValue);
	virtual void __fastcall SetAlignment(System::Classes::TAlignment Value);
	virtual int __fastcall GetBtnWidth(void);
	virtual int __fastcall GetCheckDims(void);
	virtual int __fastcall GetCheckWidth(void);
	void __fastcall SetEditRect(void);
	bool __fastcall GetShowTodayButton(void);
	void __fastcall SetShowTodayButton(bool Value);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DoDropDown(void);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerChangeEvent(void);
	virtual void __fastcall SetActiveBorderType(Elvclutils::TElFlatBorderType newValue);
	virtual void __fastcall SetInactiveBorderType(Elvclutils::TElFlatBorderType newValue);
	virtual void __fastcall SetFlat(bool newValue);
	virtual void __fastcall SetNavigationInPopup(bool newValue);
	virtual void __fastcall SetDate(System::TDateTime newValue);
	virtual System::TDateTime __fastcall GetDate(void);
	void __fastcall DisplayOptionsChange(System::TObject* Sender);
	virtual void __fastcall SetTime(System::TDateTime newValue);
	virtual System::TDateTime __fastcall GetTime(void);
	bool __fastcall GetDroppedDown(void);
	virtual void __fastcall SetDroppedDown(bool newValue);
	Elcalendardefs::TDayOfWeek __fastcall GetStartOfWeek(void);
	void __fastcall SetStartOfWeek(Elcalendardefs::TDayOfWeek Value);
	Elcalendardefs::TElWeekEndDays __fastcall GetWeekEndDays(void);
	void __fastcall SetWeekEndDays(Elcalendardefs::TElWeekEndDays Value);
	void __fastcall SetCalendarLineColorLight(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetCalendarLineColorDark(void);
	void __fastcall SetCalendarLineColorDark(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetCalendarLineColorLight(void);
	System::Uitypes::TColor __fastcall GetCalendarBackColor(void);
	void __fastcall SetCalendarBackColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetCalendarFormColor(void);
	void __fastcall SetCalendarFormColor(System::Uitypes::TColor Value);
	void __fastcall SetCalendarFlatBtn(bool Value);
	bool __fastcall GetCalendarFlatBtn(void);
	bool __fastcall GetUseSystemStartOfWeek(void);
	void __fastcall SetUseSystemStartOfWeek(bool Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation operation);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	void __fastcall AdjustHeight(void);
	void __fastcall UpdateHeight(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall SetShowPopupCalendar(bool newValue);
	void __fastcall CalendarKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall CalendarChange(System::TObject* Sender);
	DYNAMIC void __fastcall DblClick(void);
	virtual void __fastcall SetShowCheckBox(bool newValue);
	virtual void __fastcall SetChecked(bool newValue);
	virtual void __fastcall SetModified(bool newValue);
	void __fastcall TriggerCheckboxChangeEvent(void);
	Elvclutils::TElFlatBorderType __fastcall GetCalendarCurrentDayBorder(void);
	void __fastcall SetCalendarCurrentDayBorder(Elvclutils::TElFlatBorderType Value);
	Elvclutils::TElFlatBorderType __fastcall GetCalendarDayCellBorder(void);
	void __fastcall SetCalendarDayCellBorder(Elvclutils::TElFlatBorderType Value);
	Elvclutils::TElFlatBorderType __fastcall GetCalendarSelectionBorder(void);
	void __fastcall SetCalendarSelectionBorder(Elvclutils::TElFlatBorderType Value);
	void __fastcall SetMinDate(System::TDateTime Value);
	void __fastcall SetMaxDate(System::TDateTime Value);
	bool __fastcall DoSetDateTime(System::TDateTime ADate);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual void __fastcall SetUseXPThemes(const bool Value);
	virtual void __fastcall DoThemeChanged(void);
	Elspinbtn::TElSpinBtnDir __fastcall GetButtonDir(void);
	void __fastcall SetButtonDir(Elspinbtn::TElSpinBtnDir Value);
	Elspinbtn::TElSpinBtnType __fastcall GetButtonType(void);
	void __fastcall SetButtonType(Elspinbtn::TElSpinBtnType Value);
	void __fastcall SetButtonWidth(int Value);
	void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall UpdateButtonStyles(void);
	void __fastcall SetButtonVisible(bool Value);
	void __fastcall SetUnassigned(bool Value);
	void __fastcall SetUnassignedColor(System::Uitypes::TColor Value);
	void __fastcall SetUnassignedAllowed(bool Value);
	virtual bool __fastcall GetReadOnly(void);
	virtual void __fastcall SetReadOnly(bool Value);
	void __fastcall SetButtonShowOnFocus(bool Value);
	bool __fastcall IsDateTimeStored(void);
	void __fastcall SetButtonThinFrame(bool Value);
	HIDESBASE void __fastcall SetAutoSize(bool Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	Lmdtypes::TLMDString __fastcall GetUnassignedChar(void);
	void __fastcall SetUnassignedChar(Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall MakeUnassignedString(int Length);
	bool __fastcall GetTranslateDays(void);
	void __fastcall SetTranslateDays(bool Value);
	Elcalendardefs::TElHolidays* __fastcall GetCalendarHolidays(void);
	void __fastcall SetCalendarHolidays(Elcalendardefs::TElHolidays* Value);
	System::WideChar __fastcall SeparatorValue(System::WideChar Symbol);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	bool __fastcall GetCalendarShowWeekNum(void);
	void __fastcall SetCalendarShowWeekNum(bool Value);
	Elcalendardefs::TElHolidayEvent __fastcall GetOnDetermineHoliday(void);
	void __fastcall SetOnDetermineHoliday(Elcalendardefs::TElHolidayEvent Value);
	System::Uitypes::TColor __fastcall GetCalendarHolidayColor(void);
	void __fastcall SetCalendarHolidayColor(System::Uitypes::TColor Value);
	void __fastcall AdvancePosition(void);
	void __fastcall SetFocusedSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetFocusedSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelectTextColor(System::Uitypes::TColor newValue);
	void __fastcall SetHideSelection(bool Value);
	void __fastcall SetHighlightAlphaLevel(int Value);
	void __fastcall SetButtonColor(System::Uitypes::TColor Value);
	void __fastcall SetButtonShowBorder(bool Value);
	void __fastcall SetLinkedControlPosition(Elvclutils::TElLinkCtlPos Value);
	void __fastcall SetLinkedControl(Vcl::Controls::TControl* Value);
	void __fastcall SetLinkedControlSpacing(int Value);
	void __fastcall UpdateLinkedControl(void);
	bool __fastcall GetCalendarGridVertLines(void);
	void __fastcall SetCalendarGridVertLines(bool Value);
	bool __fastcall GetCalendarGridHorzLines(void);
	void __fastcall SetCalendarGridHorzLines(bool Value);
	System::Uitypes::TColor __fastcall GetCalendarGridLineColor(void);
	void __fastcall SetCalendarGridLineColor(System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetCalendarLineBorderColor(void);
	void __fastcall SetCalendarLineBorderColor(System::Uitypes::TColor Value);
	Vcl::Graphics::TBitmap* __fastcall GetCalendarCurrentDayBitmap(void);
	void __fastcall SetCalendarCurrentDayBitmap(Vcl::Graphics::TBitmap* Value);
	bool __fastcall GetCalendarCurrentDayUseBitmap(void);
	void __fastcall SetCalendarCurrentDayUseBitmap(bool Value);
	void __fastcall SetButtonFlat(bool Value);
	void __fastcall SetButtonOldStyled(bool Value);
	void __fastcall SetDisabledColor(System::Uitypes::TColor Value);
	void __fastcall SetDisabledFontColor(System::Uitypes::TColor Value);
	void __fastcall SetUseDisabledColors(bool Value);
	void __fastcall ReadChangeDisabledText(System::Classes::TReader* Reader);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall SetButtonUseSystemWidth(bool Value);
	int __fastcall GetActiveButtonWidth(void);
	HIDESBASE System::UnicodeString __fastcall GetText(void);
	virtual void __fastcall DestroyWnd(void);
	System::Uitypes::TColor __fastcall GetCalendarOtherMonthDayColor(void);
	void __fastcall SetCalendarOtherMonthDayColor(System::Uitypes::TColor Value);
	Elcalendardefs::TBeforeCellDrawEvent __fastcall GetOnBeforeCellDraw(void);
	void __fastcall SetOnBeforeCellDraw(Elcalendardefs::TBeforeCellDrawEvent Value);
	bool __fastcall GetCalendarShowOtherMonthDays(void);
	void __fastcall SetCalendarShowOtherMonthDays(bool Value);
	void __fastcall SetCalendarShowClock(bool Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	void __fastcall Clipbrd_Copy(void);
	void __fastcall Clipbrd_Paste(void);
	void __fastcall Clipbrd_Cut(void);
	HIDESBASE MESSAGE void __fastcall WMSetRedraw(Winapi::Messages::TWMSetRedraw &Message);
	
public:
	__fastcall virtual TElDateTimePicker(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElDateTimePicker(void);
	void __fastcall SetCalendarDate(System::TDateTime Date);
	__property bool MouseOver = {read=FMouseOver, nodefault};
	__property bool DroppedDown = {read=GetDroppedDown, write=SetDroppedDown, nodefault};
	__property bool AlwaysResetUnassigned = {read=FAlwaysResetUnassigned, write=FAlwaysResetUnassigned, default=0};
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	__property System::TDateTime Time = {read=GetTime, write=SetTime};
	__property bool ShowBlankWhenZero = {read=FShowBlankWhenZero, write=FShowBlankWhenZero, default=0};
	__property Elcalendardefs::TElHolidays* CalendarHolidays = {read=GetCalendarHolidays, write=SetCalendarHolidays};
	__property System::UnicodeString Text = {read=GetText};
	
__published:
	__property Elcalendardefs::TElCustomCalendarNames* CustomCalendarNames = {read=FCustomCalendarNames, write=SetCustomCalendarNames};
	__property Elvclutils::TElDisplayOptions* DisplayReadOnlyOptions = {read=FDisplayReadOnlyOptions, write=SetDisplayReadOnlyOptions};
	__property TElDatePickerFormat Format = {read=FFormat, write=SetFormat, default=0};
	__property System::UnicodeString FormatString = {read=FFormatStr, write=SetFormatStr};
	__property System::TDateTime DateTime = {read=FDate, write=SetDateTime, stored=IsDateTimeStored};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property bool AutoSize = {read=FAutoSize, write=SetAutoSize, default=1};
	__property System::Uitypes::TColor GradientStartColor = {read=FGradientStartColor, write=SetGradientStartColor, default=0};
	__property System::Uitypes::TColor GradientEndColor = {read=FGradientEndColor, write=SetGradientEndColor, default=0};
	__property int GradientSteps = {read=FGradientSteps, write=SetGradientSteps, default=16};
	__property Vcl::Graphics::TBitmap* Background = {read=FBackground, write=SetBackground};
	__property Lmdgraph::TLMDBackgroundType BackgroundType = {read=FBackgroundType, write=SetBackgroundType, default=2};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=FBorderStyle, write=SetBorderStyle, default=1};
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property int FontMargin = {read=FFontMargin, write=FFontMargin, default=1};
	__property bool ShowPopupCalendar = {read=FShowPopupCalendar, write=SetShowPopupCalendar, default=0};
	__property bool NavigationInPopup = {read=FNavigationInPopup, write=SetNavigationInPopup, default=1};
	__property bool AltChangeMethod = {read=FAltChangeMethod, write=FAltChangeMethod, default=0};
	__property bool ShowCheckBox = {read=FShowCheckBox, write=SetShowCheckBox, default=0};
	__property bool ShowTodayButton = {read=GetShowTodayButton, write=SetShowTodayButton, stored=true, default=1};
	__property bool Checked = {read=FChecked, write=SetChecked, default=1};
	__property bool Modified = {read=FModified, write=SetModified, default=0};
	__property int HighlightAlphaLevel = {read=FHighlightAlphaLevel, write=SetHighlightAlphaLevel, default=255};
	__property int BtnWidth = {read=GetBtnWidth, nodefault};
	__property System::Uitypes::TColor DisabledColor = {read=FDisabledColor, write=SetDisabledColor, default=-16777201};
	__property System::Uitypes::TColor DisabledFontColor = {read=FDisabledFontColor, write=SetDisabledFontColor, default=-16777199};
	__property bool UseDisabledColors = {read=FUseDisabledColors, write=SetUseDisabledColors, default=0};
	__property System::Uitypes::TColor CalendarLineColorDark = {read=GetCalendarLineColorDark, write=SetCalendarLineColorDark, stored=true, default=-16777201};
	__property System::Uitypes::TColor CalendarLineColorLight = {read=GetCalendarLineColorLight, write=SetCalendarLineColorLight, stored=true, default=-16777211};
	__property System::Uitypes::TColor CalendarBackColor = {read=GetCalendarBackColor, write=SetCalendarBackColor, stored=true, default=-16777211};
	__property System::Uitypes::TColor CalendarFormColor = {read=GetCalendarFormColor, write=SetCalendarFormColor, stored=true, default=-16777201};
	__property Vcl::Graphics::TFont* CalendarFormFont = {read=FCalendarFormFont, write=SetCalendarFormFont};
	__property Elcalendardefs::TDayOfWeek StartOfWeek = {read=GetStartOfWeek, write=SetStartOfWeek, stored=true, default=0};
	__property bool UseSystemStartOfWeek = {read=GetUseSystemStartOfWeek, write=SetUseSystemStartOfWeek, stored=true, default=1};
	__property Elcalendardefs::TElWeekEndDays WeekEndDays = {read=GetWeekEndDays, write=SetWeekEndDays, stored=true, nodefault};
	__property bool CalendarUseLineColors = {read=GetCalendarUseLineColors, write=SetCalendarUseLineColors, stored=true, default=0};
	__property System::Uitypes::TColor CalendarWeekendColor = {read=GetCalendarWeekendColor, write=SetCalendarWeekendColor, stored=true, default=255};
	__property Lmdgraph::TLMDBorderSides BorderSides = {read=FBorderSides, write=SetBorderSides, default=15};
	__property Elvclutils::TElFlatBorderType CalendarCurrentDayBorder = {read=GetCalendarCurrentDayBorder, write=SetCalendarCurrentDayBorder, default=1};
	__property bool CalendarCurrentDayUseBitmap = {read=GetCalendarCurrentDayUseBitmap, write=SetCalendarCurrentDayUseBitmap, default=0};
	__property Vcl::Graphics::TBitmap* CalendarCurrentDayBitmap = {read=GetCalendarCurrentDayBitmap, write=SetCalendarCurrentDayBitmap};
	__property System::Uitypes::TColor CalendarLineBorderColor = {read=GetCalendarLineBorderColor, write=SetCalendarLineBorderColor, default=-16777208};
	__property Elvclutils::TElFlatBorderType CalendarDayCellBorder = {read=GetCalendarDayCellBorder, write=SetCalendarDayCellBorder, default=11};
	__property Elvclutils::TElFlatBorderType CalendarSelectionBorder = {read=GetCalendarSelectionBorder, write=SetCalendarSelectionBorder, default=1};
	__property System::TDateTime MinDate = {read=FMinDate, write=SetMinDate};
	__property System::TDateTime MaxDate = {read=FMaxDate, write=SetMaxDate};
	__property bool HandleDialogKeys = {read=FHandleDialogKeys, write=FHandleDialogKeys, default=0};
	__property Elspinbtn::TElSpinBtnDir ButtonDir = {read=GetButtonDir, write=SetButtonDir, default=0};
	__property Elspinbtn::TElSpinBtnType ButtonType = {read=GetButtonType, write=SetButtonType, default=0};
	__property int ButtonWidth = {read=FBtnWidth, write=SetButtonWidth, nodefault};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=-16777201};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=-16777201};
	__property bool ButtonVisible = {read=FButtonVisible, write=SetButtonVisible, default=1};
	__property bool Unassigned = {read=FUnassigned, write=SetUnassigned, default=0};
	__property System::Uitypes::TColor UnassignedColor = {read=FUnassignedColor, write=SetUnassignedColor, default=255};
	__property bool UnassignedAllowed = {read=FUnassignedAllowed, write=SetUnassignedAllowed, default=0};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool ButtonShowOnFocus = {read=FButtonShowOnFocus, write=SetButtonShowOnFocus, default=0};
	__property bool UseCurrentDate = {read=FUseCurrentDate, write=FUseCurrentDate, default=0};
	__property bool ButtonThinFrame = {read=FButtonThinFrame, write=SetButtonThinFrame, default=1};
	__property Lmdtypes::TLMDString UnassignedChar = {read=GetUnassignedChar, write=SetUnassignedChar};
	__property bool TranslateDays = {read=GetTranslateDays, write=SetTranslateDays, default=0};
	__property bool CalendarShowWeekNum = {read=GetCalendarShowWeekNum, write=SetCalendarShowWeekNum, default=0};
	__property bool CalendarFlatButtons = {read=GetCalendarFlatBtn, write=SetCalendarFlatBtn, default=1};
	__property Elcalendardefs::TElHolidayEvent OnDetermineHoliday = {read=GetOnDetermineHoliday, write=SetOnDetermineHoliday};
	__property System::Uitypes::TColor CalendarHolidayColor = {read=GetCalendarHolidayColor, write=SetCalendarHolidayColor, default=-16777208};
	__property bool AutoAdvance = {read=FAutoAdvance, write=FAutoAdvance, default=0};
	__property System::Uitypes::TColor FocusedSelectColor = {read=FFocusedSelectColor, write=SetFocusedSelectColor, default=-16777203};
	__property System::Uitypes::TColor FocusedSelectTextColor = {read=FFocusedSelectTextColor, write=SetFocusedSelectTextColor, default=-16777202};
	__property System::Uitypes::TColor HideSelectColor = {read=FHideSelectColor, write=SetHideSelectColor, default=-16777201};
	__property System::Uitypes::TColor HideSelectTextColor = {read=FHideSelectTextColor, write=SetHideSelectTextColor, default=-16777200};
	__property bool HideSelection = {read=FHideSelection, write=SetHideSelection, default=1};
	__property System::Uitypes::TColor ButtonColor = {read=FButtonColor, write=SetButtonColor, default=-16777201};
	__property bool ButtonShowBorder = {read=FButtonShowBorder, write=SetButtonShowBorder, default=1};
	__property Elvclutils::TElLinkCtlPos LinkedControlPosition = {read=FLinkedControlPosition, write=SetLinkedControlPosition, default=3};
	__property Vcl::Controls::TControl* LinkedControl = {read=FLinkedControl, write=SetLinkedControl};
	__property int LinkedControlSpacing = {read=FLinkedControlSpacing, write=SetLinkedControlSpacing, default=0};
	__property System::Classes::TAlignment DropDownAlignment = {read=FDropDownAlignment, write=FDropDownAlignment, default=1};
	__property bool CalendarKeepWithinForm = {read=FCalendarKeepWithinForm, write=FCalendarKeepWithinForm, default=0};
	__property bool CalendarGridVertLines = {read=GetCalendarGridVertLines, write=SetCalendarGridVertLines, stored=true, default=1};
	__property bool CalendarGridHorzLines = {read=GetCalendarGridHorzLines, write=SetCalendarGridHorzLines, stored=true, default=1};
	__property System::Uitypes::TColor CalendarGridLineColor = {read=GetCalendarGridLineColor, write=SetCalendarGridLineColor, default=-16777201};
	__property bool ButtonFlat = {read=FButtonFlat, write=SetButtonFlat, default=0};
	__property bool ButtonOldStyled = {read=FButtonOldStyled, write=SetButtonOldStyled, default=0};
	__property bool ButtonUseSystemWidth = {read=FButtonUseSystemWidth, write=SetButtonUseSystemWidth, default=0};
	__property System::Uitypes::TColor CalendarOtherMonthDayColor = {read=GetCalendarOtherMonthDayColor, write=SetCalendarOtherMonthDayColor, default=-16777199};
	__property bool CalendarShowOtherMonthDays = {read=GetCalendarShowOtherMonthDays, write=SetCalendarShowOtherMonthDays, default=0};
	__property bool CalendarUserNavigation = {read=GetCalendarUserNavigation, write=SetCalendarUserNavigation, default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Elcalendardefs::TBeforeCellDrawEvent OnBeforeCellDraw = {read=GetOnBeforeCellDraw, write=SetOnBeforeCellDraw};
	__property System::Classes::TNotifyEvent OnCheckBoxChange = {read=FOnCheckBoxChange, write=FOnCheckBoxChange};
	__property bool CalendarShowClock = {read=FCalendarShowClock, write=SetCalendarShowClock, default=0};
	__property TElCalendarStyle CalendarStyle = {read=GetCalendarStyle, write=SetCalendarStyle, default=0};
	__property bool CalendarLiveClock = {read=GetCalendarLiveClock, write=SetCalendarLiveClock, default=0};
	__property Anchors = {default=3};
	__property Constraints;
	__property DockOrientation;
	__property DragKind = {default=0};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ImeMode = {default=3};
	__property ImeName = {default=0};
	__property ParentCtl3D = {default=1};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
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
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDock;
	__property OnEndDock;
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElDateTimePicker(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElTClock : public Elclock::TElClock
{
	typedef Elclock::TElClock inherited;
	
protected:
	System::Classes::TNotifyEvent FOnKick;
	
public:
	virtual void __fastcall Kick(void);
	__property System::Classes::TNotifyEvent OnKick = {read=FOnKick, write=FOnKick};
public:
	/* TElClock.Create */ inline __fastcall virtual TElTClock(System::Classes::TComponent* AOwner) : Elclock::TElClock(AOwner) { }
	/* TElClock.Destroy */ inline __fastcall virtual ~TElTClock(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTClock(HWND ParentWindow) : Elclock::TElClock(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TElCalendarForm : public Lmddropdownform::TLMDDropDownForm
{
	typedef Lmddropdownform::TLMDDropDownForm inherited;
	
__published:
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TodayBtnClick(System::TObject* Sender);
	void __fastcall CalendarChange(System::TObject* Sender);
	void __fastcall CalendarClick(System::TObject* Sender);
	void __fastcall ClearBtnClick(System::TObject* Sender);
	void __fastcall RangeButtons(void);
	
private:
	Elcalendardefs::TElCustomCalendarNames* FCustomCalendarNames;
	bool FFlatButtons;
	bool FShowTodayButton;
	bool FShowClock;
	bool FUseMonthCalendar;
	bool FCalendarLiveClock;
	int FTag;
	HIDESBASE MESSAGE void __fastcall WMNotify(Winapi::Messages::TWMNotify &Msg);
	HIDESBASE MESSAGE void __fastcall WMActivate(Winapi::Messages::TWMActivate &Msg);
	void __fastcall SetShowTodayButton(const bool Value);
	void __fastcall SetShowClock(const bool Value);
	void __fastcall SetFlatButtons(const bool Value);
	void __fastcall SetUseMonthCalendar(const bool Value);
	void __fastcall SetCustomCalendarNames(Elcalendardefs::TElCustomCalendarNames* const Value);
	
public:
	bool Unassigned;
	Elpopbtn::TElPopupButton* TodayBtn;
	Elpopbtn::TElPopupButton* ClearBtn;
	Elpanel::TElPanel* Panel3;
	Elpopbtn::TElPopupButton* OkBtn;
	Elpopbtn::TElPopupButton* CancelBtn;
	Elgroupbox::TElGroupBox* CalendarGB;
	Elgroupbox::TElGroupBox* ClockGB;
	Elpanel::TElPanel* ClockPanel;
	Elpanel::TElPanel* CalendarPanel;
	Elcalendar::TElCalendar* Calendar;
	Elpanel::TElPanel* Panel1;
	Elpopbtn::TElPopupButton* PrevMonBtn;
	Elpopbtn::TElPopupButton* PrevYearBtn;
	Elpopbtn::TElPopupButton* NextMonBtn;
	Elpopbtn::TElPopupButton* NextYearBtn;
	Elspin::TElSpinEdit* YearSpin;
	Elcombos::TElComboBox* MonthCombo;
	TElTClock* Clock;
	Elpanel::TElPanel* PanelCl;
	TElDateTimePicker* TimeDTP;
	Vcl::Comctrls::TMonthCalendar* MCalendar;
	virtual void __fastcall SetFormThemed(bool Value);
	virtual void __fastcall SetThemeMode(Lmdclass::TLMDThemeMode AMode);
	void __fastcall CalcFormSizes(void);
	void __fastcall ClockKick(System::TObject* Sender);
	void __fastcall TimeChange(System::TObject* Sender);
	void __fastcall PrevYearBtnClick(System::TObject* Sender);
	void __fastcall PrevMonBtnClick(System::TObject* Sender);
	void __fastcall MonthComboChange(System::TObject* Sender);
	void __fastcall NextMonBtnClick(System::TObject* Sender);
	void __fastcall NextYearBtnClick(System::TObject* Sender);
	void __fastcall YearSpinChange(System::TObject* Sender);
	void __fastcall SetNames(void);
	void __fastcall UpdateLabel(void);
	__fastcall virtual ~TElCalendarForm(void);
	__fastcall virtual TElCalendarForm(System::Classes::TComponent* AOwner, int Dummy);
	__property bool FlatButtons = {read=FFlatButtons, write=SetFlatButtons, default=1};
	__property bool ShowTodayButton = {read=FShowTodayButton, write=SetShowTodayButton, default=1};
	__property bool ShowClock = {read=FShowClock, write=SetShowClock, default=1};
	__property bool UseMonthCalendar = {read=FUseMonthCalendar, write=SetUseMonthCalendar, default=0};
	__property Elcalendardefs::TElCustomCalendarNames* CustomCalendarNames = {read=FCustomCalendarNames, write=SetCustomCalendarNames};
	__property bool CalendarLiveClock = {read=FCalendarLiveClock, write=FCalendarLiveClock, nodefault};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElCalendarForm(System::Classes::TComponent* AOwner) : Lmddropdownform::TLMDDropDownForm(AOwner) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCalendarForm(HWND ParentWindow) : Lmddropdownform::TLMDDropDownForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdtypes::TLMDString ClearCap;
extern DELPHI_PACKAGE Lmdtypes::TLMDString TodayCap;
extern DELPHI_PACKAGE Lmdtypes::TLMDString OkCap;
extern DELPHI_PACKAGE Lmdtypes::TLMDString CancelCap;
extern DELPHI_PACKAGE Lmdtypes::TLMDString CalendarCap;
extern DELPHI_PACKAGE Lmdtypes::TLMDString CapCalendarGB;
extern DELPHI_PACKAGE Lmdtypes::TLMDString CapClockGB;
extern DELPHI_PACKAGE Lmdtypes::TLMDString NextYearHint;
extern DELPHI_PACKAGE Lmdtypes::TLMDString NextMonthHint;
extern DELPHI_PACKAGE Lmdtypes::TLMDString PrevYearHint;
extern DELPHI_PACKAGE Lmdtypes::TLMDString PrevMonthHint;
}	/* namespace Eldtpick */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELDTPICK)
using namespace Eldtpick;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EldtpickHPP
