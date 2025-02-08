// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwdbdatetimepicker.pas' rev: 6.00

#ifndef wwdbdatetimepickerHPP
#define wwdbdatetimepickerHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Menus.hpp>	// Pascal unit
#include <wwcombobutton.hpp>	// Pascal unit
#include <wwframe.hpp>	// Pascal unit
#include <Wwtypes.hpp>	// Pascal unit
#include <Grids.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <wwSystem.hpp>	// Pascal unit
#include <Wwintl.hpp>	// Pascal unit
#include <Buttons.hpp>	// Pascal unit
#include <DBCtrls.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <CommCtrl.hpp>	// Pascal unit
#include <wwmonthcalendar.hpp>	// Pascal unit
#include <Mask.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdbdatetimepicker
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwDTCalAlignment { wwdtaLeft, wwdtaRight, wwdtaCenter };
#pragma option pop

#pragma option push -b-
enum TwwDTEditDataType { wwDTEdtDateTime, wwDTEdtDate, wwDTEdtTime };
#pragma option pop

#pragma option push -b-
enum TwwDTOption { wwDTOAutoAdvance };
#pragma option pop

typedef Set<TwwDTOption, wwDTOAutoAdvance, wwDTOAutoAdvance>  TwwDTOptions;

class DELPHICLASS TwwDTInterval;
class PASCALIMPLEMENTATION TwwDTInterval : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	int FMinutesInterval;
	bool FRoundMinutes;
	
public:
	__fastcall TwwDTInterval(void);
	
__published:
	__property int MinutesInterval = {read=FMinutesInterval, write=FMinutesInterval, default=1};
	__property bool RoundMinutes = {read=FRoundMinutes, write=FRoundMinutes, default=0};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwDTInterval(void) { }
	#pragma option pop
	
};


class DELPHICLASS TwwPopupCalendar;
class DELPHICLASS TwwDBDateTimePicker;
class DELPHICLASS TwwDBCustomDateTimePicker;
class DELPHICLASS TwwCalendarOptions;
class PASCALIMPLEMENTATION TwwCalendarOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	TwwDTCalAlignment FAlignment;
	Wwmonthcalendar::TwwDateTimeColors* FColors;
	Graphics::TFont* FFont;
	int FWidth;
	int FHeight;
	Wwmonthcalendar::TwwMonthOptions FOptions;
	Wwmonthcalendar::TwwPopupYearOptions* FPopupYearOptions;
	Wwmonthcalendar::TwwCalDayOfWeek FFirstDayOfWeek;
	void __fastcall SetPopupYearOptions(Wwmonthcalendar::TwwPopupYearOptions* Value);
	int __fastcall GetHeight(void);
	void __fastcall SetHeight(int Value);
	int __fastcall GetWidth(void);
	void __fastcall SetWidth(int Value);
	Graphics::TFont* __fastcall GetFont(void);
	void __fastcall SetFont(Graphics::TFont* Value);
	void __fastcall SetAlignment(TwwDTCalAlignment Value);
	void __fastcall SetColors(Wwmonthcalendar::TwwDateTimeColors* Value);
	void __fastcall SetFirstDayOfWeek(Wwmonthcalendar::TwwCalDayOfWeek Value);
	
protected:
	void __fastcall SetOptions(Wwmonthcalendar::TwwMonthOptions Value);
	
public:
	__fastcall TwwCalendarOptions(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwCalendarOptions(void);
	__property int Width = {read=GetWidth, write=SetWidth, nodefault};
	__property int Height = {read=GetHeight, write=SetHeight, nodefault};
	
__published:
	__property TwwDTCalAlignment Alignment = {read=FAlignment, write=SetAlignment, default=0};
	__property Wwmonthcalendar::TwwDateTimeColors* Colors = {read=FColors, write=SetColors};
	__property Graphics::TFont* Font = {read=GetFont, write=SetFont};
	__property Wwmonthcalendar::TwwMonthOptions Options = {read=FOptions, write=SetOptions, default=1};
	__property Wwmonthcalendar::TwwPopupYearOptions* PopupYearOptions = {read=FPopupYearOptions, write=SetPopupYearOptions};
	__property Wwmonthcalendar::TwwCalDayOfWeek FirstDayOfWeek = {read=FFirstDayOfWeek, write=SetFirstDayOfWeek, default=7};
};


class PASCALIMPLEMENTATION TwwDBCustomDateTimePicker : public Stdctrls::TCustomEdit 
{
	typedef Stdctrls::TCustomEdit inherited;
	
private:
	Classes::TAlignment FAlignment;
	TwwPopupCalendar* FCalendar;
	TwwCalendarOptions* FCalendarOptions;
	Wwmonthcalendar::TCalcBoldDayEvent FOnCalcBoldDay;
	Comctrls::TDTDateFormat FDateFormat;
	TDate FMaxDate;
	TDate FMinDate;
	bool FInCloseUp;
	Classes::TNotifyEvent FOnCloseUp;
	Classes::TNotifyEvent FOnDropDown;
	Classes::TNotifyEvent FOnMouseEnter;
	Classes::TNotifyEvent FOnMouseLeave;
	System::TDateTime FOldDateTime;
	System::TDateTime FDateTime;
	Dbctrls::TFieldDataLink* FDataLink;
	Wwcombobutton::TwwComboButton* FButton;
	Controls::TWinControl* FBtnControl;
	Controls::TControlCanvas* FCanvas;
	bool FFocused;
	int FPos;
	TwwDTEditDataType FUnboundDataType;
	AnsiString FDisplayFormat;
	bool FInDigitEdit;
	bool FIsCleared;
	int FTextMargin;
	bool FInfoPower;
	int FEpoch;
	TwwDTOptions FOptions;
	bool SkipDrawSetFocus;
	System::TDateTime DateTimeBeforeDropDown;
	bool SkipEscapeReset;
	bool FShowButton;
	Wwframe::TwwEditFrame* FFrame;
	Wwframe::TwwButtonEffects* FButtonEffects;
	TwwDTInterval* FInterval;
	Wwframe::TwwComboButtonStyle FButtonStyle;
	int FButtonWidth;
	bool FAutoFillDateAndTime;
	bool skipUpdate;
	bool FMouseInButtonControl;
	bool OldShowHint;
	bool SetModifiedInChangeEvent;
	System::TDateTime CurrentDigitEditDateTime;
	TDate __fastcall GetDate(void);
	TTime __fastcall GetTime(void);
	void __fastcall SetDate(TDate Value);
	void __fastcall SetTime(TTime Value);
	void __fastcall SetDateTime(System::TDateTime Value);
	Db::TField* __fastcall GetField(void);
	AnsiString __fastcall GetDataField();
	void __fastcall SetDataField(const AnsiString Value);
	Db::TDataSource* __fastcall GetDataSource(void);
	void __fastcall SetDataSource(Db::TDataSource* Value);
	void __fastcall SetUnboundDataType(const TwwDTEditDataType Value);
	void __fastcall DataChange(System::TObject* Sender);
	void __fastcall UpdateData(System::TObject* Sender);
	void __fastcall SetMaxDate(TDate Value);
	void __fastcall SetMinDate(TDate Value);
	void __fastcall SetDateFormat(Comctrls::TDTDateFormat Value);
	void __fastcall SetEpoch(int Value);
	void __fastcall UpdateButtonPosition(void);
	MESSAGE void __fastcall CMCancelMode(Controls::TCMCancelMode &Message);
	HIDESBASE MESSAGE void __fastcall CMEnter(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Messages::TMessage &Message);
	MESSAGE void __fastcall CMGetDataLink(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNKeyDown(Messages::TWMKey &Message);
	MESSAGE void __fastcall WMCut(Messages::TMessage &Message);
	MESSAGE void __fastcall WMPaste(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMSetFont(Messages::TWMSetFont &Message);
	void __fastcall SetFocused(bool Value);
	AnsiString __fastcall GetDatetimeToken(System::TDateTime datetime1, int index, int &pos, int &len, AnsiString &s);
	void __fastcall GetCompleteToken(char val, AnsiString formatstr, AnsiString &s, int &pos);
	AnsiString __fastcall GetFormatStr();
	bool __fastcall isDateField(void);
	bool __fastcall IsDateOnlyField(void);
	bool __fastcall isTimeOnlyField(void);
	bool __fastcall isDateTimeField(void);
	bool __fastcall isAMPM(AnsiString str);
	void __fastcall InDigitEditUpdateRecord(void);
	bool __fastcall IscFormat(void);
	bool __fastcall TimeShowing(void);
	int __fastcall GetMaxVisibleToken(void);
	bool __fastcall isvalid2year(int newnum);
	void __fastcall ReEncodeDateTime(Word y, Word m, Word d, Word h, Word n, Word sec, Word msec);
	TDate __fastcall GetValidMaxDate(void);
	TDate __fastcall GetValidMinDate(void);
	bool __fastcall GetReadOnly(void);
	HIDESBASE void __fastcall SetReadOnly(bool Value);
	void __fastcall SetDisplayFormat(AnsiString value);
	void __fastcall SetButtonGlyph(Graphics::TBitmap* Value);
	Graphics::TBitmap* __fastcall GetButtonGlyph(void);
	void __fastcall SetButtonStyle(Wwframe::TwwComboButtonStyle val);
	void __fastcall SetButtonWidth(int val);
	int __fastcall GetButtonWidth(void);
	int __fastcall GetNewHour(int oldhour, int digit);
	
protected:
	__property Controls::TControlCanvas* ControlCanvas = {read=FCanvas};
	virtual bool __fastcall IsCustom(void);
	virtual void __fastcall DrawButton(Graphics::TCanvas* Canvas, const Types::TRect &R, Buttons::TButtonState State, Controls::TControlState ControlState, bool &DefaultPaint);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall CloseUp(bool Accept);
	virtual bool __fastcall IsDroppedDown(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyUp(Word &Key, Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(char &Key);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall EnableEdit(void);
	void __fastcall HandleDropDownKeys(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall Notification(Classes::TComponent* AComponent, Classes::TOperation Operation);
	void __fastcall BtnClick(System::TObject* sender);
	void __fastcall BtnMouseDown(System::TObject* Sender, Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual bool __fastcall EditCanModify(void);
	HIDESBASE void __fastcall SetModified(bool val);
	virtual void __fastcall SetShowButton(bool sel);
	virtual Types::TRect __fastcall GetClientEditRect();
	virtual void __fastcall SetEditRect(void);
	HIDESBASE MESSAGE void __fastcall WMSize(Messages::TWMSize &msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Messages::TWMSetFocus &Message);
	virtual bool __fastcall Editable(void);
	void __fastcall ShowText(Graphics::TCanvas* ACanvas, const Types::TRect &ARect, int indentLeft, int indentTop, AnsiString AText);
	DYNAMIC int __fastcall GetIconIndent(void);
	DYNAMIC int __fastcall GetIconLeft(void);
	void __fastcall HighlightToken(System::TDateTime mDateTime);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DoExit(void);
	void __fastcall Reset(void);
	bool __fastcall CanEdit(void);
	AnsiString __fastcall GetEffectiveDisplayFormat(bool ExpandNativeFormat);
	void __fastcall GetFirstLastDayOfWeek(int &first, int &last);
	int __fastcall GetMaxTokens(AnsiString formatstr);
	AnsiString __fastcall GetDateTimeStoredText(System::TDateTime ADateTime);
	AnsiString __fastcall GetDateTimeDisplayText(System::TDateTime ADateTime);
	bool __fastcall DateTokenInString(AnsiString formatStr);
	bool __fastcall TimeTokenInString(AnsiString formatStr);
	void __fastcall UpdateButtonGlyph(void);
	virtual void __fastcall DrawFrame(Graphics::TCanvas* Canvas);
	bool __fastcall Is3DBorder(void);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall WndProc(Messages::TMessage &Message);
	void __fastcall InvalidateTransparentButton(void);
	virtual void __fastcall DoMouseEnter(void);
	virtual void __fastcall DoMouseLeave(void);
	
public:
	Variant Patch;
	__fastcall virtual TwwDBCustomDateTimePicker(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwDBCustomDateTimePicker(void);
	DYNAMIC bool __fastcall ExecuteAction(Classes::TBasicAction* Action);
	DYNAMIC bool __fastcall UpdateAction(Classes::TBasicAction* Action);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall DropDown(void);
	void __fastcall UpdateRecord(void);
	void __fastcall RefreshText(void);
	void __fastcall ClearDateTime(void);
	bool __fastcall isTransparentEffective(void);
	__property TwwPopupCalendar* Calendar = {read=FCalendar};
	__property bool DroppedDown = {read=IsDroppedDown, nodefault};
	__property Db::TField* Field = {read=GetField};
	__property Wwframe::TwwEditFrame* Frame = {read=FFrame, write=FFrame};
	__property bool ShowButton = {read=FShowButton, write=SetShowButton, nodefault};
	__property Wwcombobutton::TwwComboButton* Button = {read=FButton};
	__property System::TDateTime DateTime = {read=FDateTime, write=SetDateTime};
	__property TwwDTOptions Options = {read=FOptions, write=FOptions, default=1};
	__property TwwDTInterval* Interval = {read=FInterval, write=FInterval};
	__property bool AutoFillDateAndTime = {read=FAutoFillDateAndTime, write=FAutoFillDateAndTime, default=0};
	__property TwwCalendarOptions* CalendarAttributes = {read=FCalendarOptions, write=FCalendarOptions};
	__property AnsiString DataField = {read=GetDataField, write=SetDataField};
	__property Comctrls::TDTDateFormat DateFormat = {read=FDateFormat, write=SetDateFormat, default=0};
	__property Db::TDataSource* DataSource = {read=GetDataSource, write=SetDataSource};
	__property TDate Date = {read=GetDate, write=SetDate};
	__property int Epoch = {read=FEpoch, write=SetEpoch, nodefault};
	__property TTime Time = {read=GetTime, write=SetTime};
	__property TDate MaxDate = {read=FMaxDate, write=SetMaxDate};
	__property TDate MinDate = {read=FMinDate, write=SetMinDate};
	__property TwwDTEditDataType UnboundDataType = {read=FUnboundDataType, write=SetUnboundDataType, default=0};
	__property AnsiString DisplayFormat = {read=FDisplayFormat, write=SetDisplayFormat};
	__property Wwmonthcalendar::TCalcBoldDayEvent OnCalcBoldDay = {read=FOnCalcBoldDay, write=FOnCalcBoldDay};
	__property Classes::TNotifyEvent OnCloseUp = {read=FOnCloseUp, write=FOnCloseUp};
	__property Classes::TNotifyEvent OnDropDown = {read=FOnDropDown, write=FOnDropDown};
	__property Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property bool ReadOnly = {read=GetReadOnly, write=SetReadOnly, default=0};
	__property bool InfoPower = {read=FInfoPower, nodefault};
	__property Wwframe::TwwComboButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, nodefault};
	__property Wwframe::TwwButtonEffects* ButtonEffects = {read=FButtonEffects, write=FButtonEffects};
	__property Graphics::TBitmap* ButtonGlyph = {read=GetButtonGlyph, write=SetButtonGlyph, stored=IsCustom};
	__property int ButtonWidth = {read=GetButtonWidth, write=SetButtonWidth, default=0};
	__property AutoSize  = {default=1};
	__property BorderStyle  = {default=1};
	__property Color  = {default=-16777211};
	__property Enabled  = {default=1};
	__property Font ;
	__property ParentColor  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ShowHint ;
	__property TabOrder  = {default=-1};
	__property Visible  = {default=1};
	__property int TokenPos = {read=FPos, write=FPos, nodefault};
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBCustomDateTimePicker(HWND ParentWindow) : Stdctrls::TCustomEdit(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwDBDateTimePicker : public TwwDBCustomDateTimePicker 
{
	typedef TwwDBCustomDateTimePicker inherited;
	
__published:
	__property Anchors  = {default=3};
	__property BiDiMode ;
	__property AutoFillDateAndTime  = {default=0};
	__property AutoSize  = {default=1};
	__property BorderStyle  = {default=1};
	__property CalendarAttributes ;
	__property Color  = {default=-16777211};
	__property Constraints ;
	__property ButtonStyle  = {default=1};
	__property DataField ;
	__property DateFormat  = {default=0};
	__property DataSource ;
	__property Date ;
	__property Epoch ;
	__property ButtonEffects ;
	__property Frame ;
	__property ButtonWidth  = {default=0};
	__property ButtonGlyph ;
	__property Time ;
	__property DragMode  = {default=0};
	__property DragCursor  = {default=-12};
	__property Enabled  = {default=1};
	__property Font ;
	__property ImeMode  = {default=3};
	__property ImeName ;
	__property MaxDate ;
	__property MinDate ;
	__property Interval ;
	__property ParentBiDiMode  = {default=1};
	__property ParentColor  = {default=0};
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property PopupMenu ;
	__property ReadOnly  = {default=0};
	__property ShowHint ;
	__property ShowButton ;
	__property TabOrder  = {default=-1};
	__property UnboundDataType  = {default=0};
	__property DisplayFormat ;
	__property Visible  = {default=1};
	__property OnCalcBoldDay ;
	__property OnClick ;
	__property OnCloseUp ;
	__property OnChange ;
	__property OnDropDown ;
	__property OnDblClick ;
	__property OnDragDrop ;
	__property OnDragOver ;
	__property OnEndDrag ;
	__property OnEnter ;
	__property OnExit ;
	__property OnKeyDown ;
	__property OnKeyPress ;
	__property OnKeyUp ;
	__property OnMouseEnter ;
	__property OnMouseLeave ;
	__property OnStartDrag ;
	__property InfoPower ;
public:
	#pragma option push -w-inl
	/* TwwDBCustomDateTimePicker.Create */ inline __fastcall virtual TwwDBDateTimePicker(Classes::TComponent* AOwner) : TwwDBCustomDateTimePicker(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwDBCustomDateTimePicker.Destroy */ inline __fastcall virtual ~TwwDBDateTimePicker(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBDateTimePicker(HWND ParentWindow) : TwwDBCustomDateTimePicker(ParentWindow) { }
	#pragma option pop
	
};


class PASCALIMPLEMENTATION TwwPopupCalendar : public Wwmonthcalendar::TwwMonthCalendar 
{
	typedef Wwmonthcalendar::TwwMonthCalendar inherited;
	
private:
	TwwDBDateTimePicker* FCombo;
	
protected:
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall CreateParams(Controls::TCreateParams &Params);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Messages::TWMMouse &Message);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(Word &Key, Classes::TShiftState Shift);
	virtual void __fastcall GetFocus(void);
	
public:
	__fastcall virtual TwwPopupCalendar(Classes::TComponent* AOwner);
public:
	#pragma option push -w-inl
	/* TwwMonthCalendar.Destroy */ inline __fastcall virtual ~TwwPopupCalendar(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwPopupCalendar(HWND ParentWindow) : Wwmonthcalendar::TwwMonthCalendar(ParentWindow) { }
	#pragma option pop
	
};


class DELPHICLASS TwwDateComboButton;
class PASCALIMPLEMENTATION TwwDateComboButton : public Wwcombobutton::TwwComboButton 
{
	typedef Wwcombobutton::TwwComboButton inherited;
	
protected:
	virtual void __fastcall Paint(void);
public:
	#pragma option push -w-inl
	/* TwwComboButton.Create */ inline __fastcall virtual TwwDateComboButton(Classes::TComponent* AOwner) : Wwcombobutton::TwwComboButton(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwComboButton.Destroy */ inline __fastcall virtual ~TwwDateComboButton(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwdbdatetimepicker)

}	/* namespace Wwdbdatetimepicker */
using namespace Wwdbdatetimepicker;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwdbdatetimepicker
