// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomDateTimePicker.pas' rev: 31.00 (Windows)

#ifndef LmdcustomdatetimepickerHPP
#define LmdcustomdatetimepickerHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDDropdownForm.hpp>
#include <LMDCalendar.hpp>
#include <LMDSpinButton.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCal.hpp>
#include <LMDButton.hpp>
#include <LMDPanelFill.hpp>
#include <LMDMaskEdit.hpp>
#include <LMDClock.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>
#include <LMDSBtn.hpp>
#include <LMDDateFormat.hpp>
#include <LMDTimeFormat.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomdatetimepicker
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalendarForm;
class DELPHICLASS TLMDCustomDateTimePicker;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnValueChangingEvent)(System::TObject* Sender, double &Val, bool &CanModify);

typedef void __fastcall (__closure *TLMDOnValueChangedEvent)(System::TObject* Sender, double OldVal, double NewVal);

enum DECLSPEC_DENUM TLMDCalendarFormOption : unsigned char { cfoShowOkCancelBtns, cfoShowClock, cfoCloseupOnDayClick };

typedef System::Set<TLMDCalendarFormOption, TLMDCalendarFormOption::cfoShowOkCancelBtns, TLMDCalendarFormOption::cfoCloseupOnDayClick> TLMDCalendarFormOptions;

class PASCALIMPLEMENTATION TLMDCalendarForm : public Lmddropdownform::TLMDDropDownForm
{
	typedef Lmddropdownform::TLMDDropDownForm inherited;
	
private:
	Lmdcalendar::TLMDCalendar* FCalendar;
	Lmdpanelfill::TLMDPanelFill* FCalendarPanel;
	Lmdpanelfill::TLMDPanelFill* FClockPanel;
	Lmdpanelfill::TLMDPanelFill* FButtonPanel;
	Lmdbutton::TLMDButton* FOkBtn;
	Lmdbutton::TLMDButton* FCancelBtn;
	Lmdmaskedit::TLMDMaskEdit* FTimePicker;
	Lmdclock::TLMDClock* FClock;
	void __fastcall CalendarClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TimeChanged(System::TObject* Sender);
	HIDESBASE MESSAGE void __fastcall CMDeactivate(Winapi::Messages::TMessage &Msg);
	
protected:
	TLMDCalendarFormOptions __fastcall Options(void);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall WMActivate(Winapi::Messages::TWMActivate &Msg);
	
public:
	__fastcall virtual TLMDCalendarForm(System::Classes::TComponent* AOwner, int Dummy);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall InitCalendar(void);
	virtual void __fastcall InitClock(void);
	virtual void __fastcall InitButtons(void);
	__property Lmdcalendar::TLMDCalendar* Calendar = {read=FCalendar};
	__property Lmdpanelfill::TLMDPanelFill* CalendarPanel = {read=FCalendarPanel};
	__property Lmdclock::TLMDClock* Clock = {read=FClock};
	__property Lmdpanelfill::TLMDPanelFill* ClockPanel = {read=FClockPanel};
	__property Lmdpanelfill::TLMDPanelFill* ButtonPanel = {read=FButtonPanel};
	__property Lmdbutton::TLMDButton* OkBtn = {read=FOkBtn};
	__property Lmdbutton::TLMDButton* CancelBtn = {read=FCancelBtn};
	__property Lmdmaskedit::TLMDMaskEdit* TimePicker = {read=FTimePicker};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDCalendarForm(System::Classes::TComponent* AOwner) : Lmddropdownform::TLMDDropDownForm(AOwner) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDCalendarForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCalendarForm(HWND ParentWindow) : Lmddropdownform::TLMDDropDownForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomDateTimePicker : public Lmdcustommaskedit::TLMDCustomMaskEdit
{
	typedef Lmdcustommaskedit::TLMDCustomMaskEdit inherited;
	
private:
	TLMDCalendarFormOptions FCalendarFormOptions;
	bool FDroppedDown;
	System::Classes::TAlignment FDropDownAlignment;
	TLMDCalendarForm* FForm;
	int FFormWidth;
	int FFormHeight;
	bool FAutoDisableButtons;
	Lmdspinbutton::TLMDSpinButton* FSpinBtn;
	int FSpinBtnWidth;
	bool FEditorEnabled;
	bool FShowPopupCalendar;
	System::Classes::TNotifyEvent FOnUpClick;
	System::Classes::TNotifyEvent FOnDownClick;
	System::Classes::TNotifyEvent FOnDropDown;
	TLMDOnValueChangedEvent FOnValueChanged;
	TLMDOnValueChangingEvent FOnValueChanging;
	System::Uitypes::TColor FCalendarFormColor;
	System::Uitypes::TColor FCalendarPanelColor;
	System::Uitypes::TColor FClockPanelColor;
	System::Uitypes::TColor FButtonPanelColor;
	Lmdcal::TLMDCalendarStyle FCalendarStyle;
	Lmdclass::TLMDColorScheme FCalendarColorScheme;
	Lmdclock::TLMDClockStyle FClockStyle;
	Lmdclass::TLMDColorScheme FClockColorScheme;
	bool FKeepCalendarWithinForm;
	Lmdtypes::TLMDString FOkCaption;
	Lmdtypes::TLMDString FCancelCaption;
	Lmdcal::TLMDCalendarHeader* FCalendarHeader;
	System::Byte FStartDay;
	HIDESBASE void __fastcall SetInteger(int index, int aValue);
	HIDESBASE void __fastcall SetColor(int Index, const System::Uitypes::TColor Value);
	void __fastcall SetDiag(const bool Value);
	System::Uitypes::TColor __fastcall GetColor(int Index);
	bool __fastcall GetDiag(void);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKILLFOCUS(Winapi::Messages::TWMKillFocus &Message);
	void __fastcall SetAutoDisableButtons(const bool Value);
	bool __fastcall GetSpinBtnVisible(void);
	void __fastcall SetSpinBtnVisible(const bool Value);
	virtual void __fastcall SetShowPopupCalendar(const bool Value);
	void __fastcall SetCalendarFormOptions(const TLMDCalendarFormOptions Value);
	System::TDateTime __fastcall GetMaxDateTime(void);
	System::TDateTime __fastcall GetMinDateTime(void);
	void __fastcall SetMaxDateTime(const System::TDateTime Value);
	void __fastcall SetMinDateTime(const System::TDateTime Value);
	void __fastcall SetCalendarStyle(const Lmdcal::TLMDCalendarStyle Value);
	void __fastcall SetStartDay(const System::Byte Value);
	
protected:
	virtual bool __fastcall AllowedOperation(Lmdtypes::TLMDString textToInsert);
	virtual void __fastcall DoAClick(System::TObject* Btn, int index);
	virtual void __fastcall DoDropDown(void);
	virtual void __fastcall DropDown(void);
	virtual void __fastcall DoInc(System::TObject* Sender);
	virtual void __fastcall DoDec(System::TObject* Sender);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall CloseUp(bool AcceptValue);
	virtual void __fastcall CalendarFormDeactivate(System::TObject* Sender);
	void __fastcall CalendarChange(System::TObject* Sender);
	MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Msg);
	virtual void __fastcall DestroyWnd(void);
	virtual void __fastcall DoValueChanging(System::TObject* Sender, double &Val, bool &CanModify);
	virtual void __fastcall DoValueChanged(System::TObject* Sender, double OldVal, double NewVal);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	virtual void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall ModifyPaintRect(void);
	virtual void __fastcall Loaded(void);
	void __fastcall UpdateSpinButtons(void);
	__property bool SpinBtnVisible = {read=GetSpinBtnVisible, write=SetSpinBtnVisible, default=1};
	
public:
	__fastcall virtual TLMDCustomDateTimePicker(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomDateTimePicker(void);
	__property bool DroppedDown = {read=FDroppedDown, nodefault};
	TLMDCalendarForm* __fastcall CalendarForm(void);
	Lmdcalendar::TLMDCalendar* __fastcall Calendar(void);
	
__published:
	__property AutoSize = {default=0};
	__property bool AutoDisableButtons = {read=FAutoDisableButtons, write=SetAutoDisableButtons, default=0};
	__property Alignment = {default=0};
	__property TLMDCalendarFormOptions CalendarFormOptions = {read=FCalendarFormOptions, write=SetCalendarFormOptions, nodefault};
	__property CustomButtons;
	__property CustomButtonsStyle = {default=10};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property System::TDateTime MinDateTime = {read=GetMinDateTime, write=SetMinDateTime};
	__property System::TDateTime MaxDateTime = {read=GetMaxDateTime, write=SetMaxDateTime};
	__property System::Uitypes::TColor CalendarFormColor = {read=FCalendarFormColor, write=FCalendarFormColor, default=16777215};
	__property int CalendarFormWidth = {read=FFormWidth, write=FFormWidth, default=-1};
	__property int CalendarFormHeight = {read=FFormHeight, write=FFormHeight, default=-1};
	__property System::Uitypes::TColor CalendarPanelColor = {read=FCalendarPanelColor, write=FCalendarPanelColor, default=16777215};
	__property System::Uitypes::TColor ClockPanelColor = {read=FClockPanelColor, write=FClockPanelColor, default=16777215};
	__property DateSettings;
	__property System::Uitypes::TColor ButtonPanelColor = {read=FButtonPanelColor, write=FButtonPanelColor, default=16777215};
	__property Lmdcal::TLMDCalendarStyle CalendarStyle = {read=FCalendarStyle, write=SetCalendarStyle, default=2};
	__property Lmdclass::TLMDColorScheme CalendarColorScheme = {read=FCalendarColorScheme, write=FCalendarColorScheme, default=6};
	__property Lmdclock::TLMDClockStyle ClockStyle = {read=FClockStyle, write=FClockStyle, default=3};
	__property Lmdclass::TLMDColorScheme ClockColorScheme = {read=FClockColorScheme, write=FClockColorScheme, default=6};
	__property bool KeepCalendarWithinForm = {read=FKeepCalendarWithinForm, write=FKeepCalendarWithinForm, default=0};
	__property bool ShowPopupCalendar = {read=FShowPopupCalendar, write=SetShowPopupCalendar, default=1};
	__property int SpinBtnWidth = {read=FSpinBtnWidth, write=SetInteger, index=0, default=-1};
	__property System::Uitypes::TColor SpinBtnColor = {read=GetColor, write=SetColor, index=0, default=-16777201};
	__property bool SpinBtnDiag = {read=GetDiag, write=SetDiag, default=0};
	__property System::Uitypes::TColor SpinBtnHotColor = {read=GetColor, write=SetColor, index=1, default=8421376};
	__property System::Byte StartDay = {read=FStartDay, write=SetStartDay, nodefault};
	__property bool EditorEnabled = {read=FEditorEnabled, write=FEditorEnabled, default=1};
	__property Lmdtypes::TLMDString OkCaption = {read=FOkCaption, write=FOkCaption};
	__property Lmdtypes::TLMDString CancelCaption = {read=FCancelCaption, write=FCancelCaption};
	__property Lmdcal::TLMDCalendarHeader* CalendarHeader = {read=FCalendarHeader, write=FCalendarHeader};
	__property ReadOnly = {index=1, default=0};
	__property System::Classes::TNotifyEvent OnSpinBtnUpClick = {read=FOnUpClick, write=FOnUpClick};
	__property System::Classes::TNotifyEvent OnSpinBtnDownClick = {read=FOnDownClick, write=FOnDownClick};
	__property System::Classes::TNotifyEvent OnDropDownClick = {read=FOnDropDown, write=FOnDropDown};
	__property TLMDOnValueChangedEvent OnValueChanged = {read=FOnValueChanged, write=FOnValueChanged};
	__property TLMDOnValueChangingEvent OnValueChanging = {read=FOnValueChanging, write=FOnValueChanging};
	__property Options = {default=56};
	__property TimeSettings;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomDateTimePicker(HWND ParentWindow) : Lmdcustommaskedit::TLMDCustomMaskEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomdatetimepicker */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMDATETIMEPICKER)
using namespace Lmdcustomdatetimepicker;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomdatetimepickerHPP
