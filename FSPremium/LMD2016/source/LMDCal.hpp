// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCal.pas' rev: 31.00 (Windows)

#ifndef LmdcalHPP
#define LmdcalHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDClass.hpp>
#include <LMDProcs.hpp>
#include <LMDGraphUtils.hpp>
#include <LMDGraph.hpp>
#include <LMDDateL.hpp>
#include <LMDButtonBase.hpp>
#include <LMDFillObject.hpp>
#include <LMD3DCaption.hpp>
#include <LMDFXCaption.hpp>
#include <LMDBevel.hpp>
#include <LMDObject.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDTypes.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDDateUtils.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomControl.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcal
{
//-- forward type declarations -----------------------------------------------
struct TLMDCalendarRecord;
class DELPHICLASS TLMDAlarmObject;
class DELPHICLASS TLMDCalendarCell;
class DELPHICLASS TLMDHeaderObject;
class DELPHICLASS TLMDCalendarHeader;
class DELPHICLASS TLMDSpecialDates;
class DELPHICLASS TLMDSpecialDateGroups;
class DELPHICLASS TLMDCustomCalendar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDayCaptions : unsigned char { dpFirst, dpSecond, dpNone, dpBoth };

enum DECLSPEC_DENUM TLMDDayDirections : unsigned char { ddLeftRight, ddTopBottom };

enum DECLSPEC_DENUM TLMDCalendarStyle : unsigned char { clsSimple, clsWinXP, clsVista };

struct DECLSPEC_DRECORD TLMDCalendarRecord
{
public:
	int GoFurther;
	int X;
	int Y;
	int GoX;
	int GoY;
	int cols;
	int lines;
	System::Types::TPoint FirstDay;
	int FromTop;
	int FromLeft;
	System::Types::TRect DaysRect;
};


enum DECLSPEC_DENUM TLMDAlarmMode : unsigned char { amBefore, amOn, amAfter };

class PASCALIMPLEMENTATION TLMDAlarmObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	bool FRegHours;
	bool FRegMinutes;
	bool FEnabled;
	TLMDAlarmMode FAlarm;
	int FDays;
	int FMonths;
	int FHours;
	int FMinutes;
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetInteger(int index, int aValue);
	void __fastcall SetAlarm(TLMDAlarmMode aValue);
	
public:
	__fastcall virtual TLMDAlarmObject(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetBoolean, index=0, default=0};
	__property bool RegardHours = {read=FRegHours, write=SetBoolean, index=1, default=1};
	__property bool RegardMinutes = {read=FRegMinutes, write=SetBoolean, index=2, default=0};
	__property TLMDAlarmMode Alarm = {read=FAlarm, write=SetAlarm, default=1};
	__property int OffsetDays = {read=FDays, write=SetInteger, index=0, default=0};
	__property int OffsetMonths = {read=FMonths, write=SetInteger, index=1, default=0};
	__property int OffsetHours = {read=FHours, write=SetInteger, index=2, default=0};
	__property int OffsetMinutes = {read=FMinutes, write=SetInteger, index=3, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDAlarmObject(void) { }
	
};


typedef void __fastcall (__closure *TLMDDrawCellEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &aRect, int Day);

class PASCALIMPLEMENTATION TLMDCalendarCell : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Vcl::Graphics::TFont* FFont;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Lmdbevel::TLMDBevel* FBevel;
	Lmdfillobject::TLMDFillObject* FFillObject;
	System::UnicodeString FMask;
	Lmdgraph::TLMDAlignment FAlignment;
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetBevel(Lmdbevel::TLMDBevel* aValue);
	void __fastcall SetFillObject(Lmdfillobject::TLMDFillObject* aValue);
	void __fastcall SetMask(System::UnicodeString aValue);
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	
public:
	__fastcall virtual TLMDCalendarCell(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDCalendarCell(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Lmdbevel::TLMDBevel* Bevel = {read=FBevel, write=SetBevel};
	__property Lmdfillobject::TLMDFillObject* FillObject = {read=FFillObject, write=SetFillObject};
	__property System::UnicodeString Mask = {read=FMask, write=SetMask};
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, default=4};
};


enum DECLSPEC_DENUM TLMDHeaderElementAlignment : unsigned char { taLeftJustify, taRightJustify, taCenter };

class PASCALIMPLEMENTATION TLMDHeaderObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	TLMDHeaderElementAlignment FAlignment;
	Lmdgraph::TLMDAlignment FCaptionAlignment;
	int FIndex;
	int FImageIndex;
	Lmdtypes::TLMDString FCaption;
	bool FUseCaption;
	bool FUseGlyph;
	void __fastcall SetAlignment(TLMDHeaderElementAlignment aValue);
	void __fastcall SetIndex(int aValue);
	void __fastcall SetImageIndex(const int aValue);
	void __fastcall SetCaption(const Lmdtypes::TLMDString aValue);
	void __fastcall SetUseCaption(const bool Value);
	void __fastcall SetUseGlyph(const bool Value);
	void __fastcall SetCaptionAlignment(const Lmdgraph::TLMDAlignment Value);
	
public:
	__fastcall virtual TLMDHeaderObject(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TLMDHeaderElementAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property int Order = {read=FIndex, write=SetIndex, nodefault};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Lmdtypes::TLMDString Caption = {read=FCaption, write=SetCaption};
	__property Lmdgraph::TLMDAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=4};
	__property bool UseCaption = {read=FUseCaption, write=SetUseCaption, default=0};
	__property bool UseGlyph = {read=FUseGlyph, write=SetUseGlyph, default=1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDHeaderObject(void) { }
	
};


enum DECLSPEC_DENUM TLMDHeaderElement : unsigned char { heMonthName, heMonthBtns, heYear, heYearBtns, heMonthCombo, heYearCombo, heTodayBtn };

typedef System::Set<TLMDHeaderElement, TLMDHeaderElement::heMonthName, TLMDHeaderElement::heTodayBtn> TLMDHeaderElements;

class PASCALIMPLEMENTATION TLMDCalendarHeader : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	TLMDCalendarCell* FStyle;
	TLMDHeaderElements FElements;
	bool FRepeatedBtnClick;
	bool FBtnFitToOutput;
	bool FUseLongMonthNames;
	Lmdbuttonbase::TLMDUserButtonStyle FBtnStyle;
	Vcl::Graphics::TFont* FBtnFont;
	Lmdfxcaption::TLMDFxCaption* FBtnFontFX;
	System::Word FYearListDelta;
	int FBtnWidth;
	int FRepeatingInterval;
	int FMinHeight;
	System::Types::TRect FRect;
	TLMDHeaderObject* FTodayObj;
	TLMDHeaderObject* FMComboObj;
	TLMDHeaderObject* FYComboObj;
	TLMDHeaderObject* FMonthObj;
	TLMDHeaderObject* FYearObj;
	TLMDHeaderObject* FYearUpObj;
	TLMDHeaderObject* FYearDnObj;
	TLMDHeaderObject* FMonthUpObj;
	TLMDHeaderObject* FMonthDnObj;
	System::Uitypes::TColor FArrowsColor;
	void __fastcall SetStyle(TLMDCalendarCell* aValue);
	void __fastcall SetElements(TLMDHeaderElements aValue);
	void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetInteger(int aValue);
	void __fastcall SetBtnStyle(Lmdbuttonbase::TLMDUserButtonStyle aValue);
	void __fastcall SetMinHeight(int aValue);
	void __fastcall SetFont(Vcl::Graphics::TFont* aValue);
	void __fastcall SetFontFX(Lmdfxcaption::TLMDFxCaption* aValue);
	void __fastcall SetHeaderObject(int index, TLMDHeaderObject* aValue);
	void __fastcall SetArrowsColor(const System::Uitypes::TColor Value);
	
public:
	__fastcall virtual TLMDCalendarHeader(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDCalendarHeader(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property System::Uitypes::TColor ArrowsColor = {read=FArrowsColor, write=SetArrowsColor, default=0};
	__property TLMDCalendarCell* Style = {read=FStyle, write=SetStyle};
	__property TLMDHeaderElements Elements = {read=FElements, write=SetElements, default=1};
	__property bool UseLongMonthNames = {read=FUseLongMonthNames, write=SetBoolean, index=0, default=1};
	__property bool ButtonsToText = {read=FBtnFitToOutput, write=SetBoolean, index=1, default=0};
	__property bool RepeatedBtnClick = {read=FRepeatedBtnClick, write=SetBoolean, index=2, default=1};
	__property int RepeatingInterval = {read=FRepeatingInterval, write=FRepeatingInterval, default=100};
	__property Lmdbuttonbase::TLMDUserButtonStyle ButtonStyle = {read=FBtnStyle, write=SetBtnStyle, default=1};
	__property Vcl::Graphics::TFont* ButtonFont = {read=FBtnFont, write=SetFont};
	__property Lmdfxcaption::TLMDFxCaption* ButtonFontFX = {read=FBtnFontFX, write=SetFontFX};
	__property int ButtonWidth = {read=FBtnWidth, write=SetInteger, default=16};
	__property int MinHeight = {read=FMinHeight, write=SetMinHeight, default=16};
	__property TLMDHeaderObject* MonthName = {read=FMonthObj, write=SetHeaderObject, index=0};
	__property TLMDHeaderObject* YearValue = {read=FYearObj, write=SetHeaderObject, index=1};
	__property TLMDHeaderObject* MonthUp = {read=FMonthUpObj, write=SetHeaderObject, index=2};
	__property TLMDHeaderObject* MonthDn = {read=FMonthDnObj, write=SetHeaderObject, index=3};
	__property TLMDHeaderObject* YearUp = {read=FYearUpObj, write=SetHeaderObject, index=4};
	__property TLMDHeaderObject* YearDn = {read=FYearDnObj, write=SetHeaderObject, index=5};
	__property System::Word YearListDelta = {read=FYearListDelta, write=FYearListDelta, default=5};
	__property TLMDHeaderObject* MonthCombo = {read=FMComboObj, write=SetHeaderObject, index=6};
	__property TLMDHeaderObject* YearCombo = {read=FYComboObj, write=SetHeaderObject, index=7};
	__property TLMDHeaderObject* Today = {read=FTodayObj, write=SetHeaderObject, index=8};
};


enum DECLSPEC_DENUM TLMDVisibleMode : unsigned char { vmDefault, vmHintOnly, vmHidden, vmPaintOnly };

typedef System::Set<TLMDVisibleMode, TLMDVisibleMode::vmDefault, TLMDVisibleMode::vmPaintOnly> TLMDVisibleModes;

class PASCALIMPLEMENTATION TLMDSpecialDates : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDCalendarCell* FStyle;
	Lmddatel::TLMDDateList* FDates;
	TLMDAlarmObject* FAlarm;
	TLMDDrawCellEvent FOnDraw;
	System::UnicodeString FCaption;
	TLMDVisibleMode FVisibleMode;
	bool FAddTimeToHint;
	void __fastcall SetStyle(TLMDCalendarCell* aValue);
	void __fastcall SetDates(Lmddatel::TLMDDateList* aValue);
	void __fastcall SetCaption(System::UnicodeString aValue);
	void __fastcall SetVisibleMode(TLMDVisibleMode aValue);
	void __fastcall GetChange(System::TObject* Sender);
	void __fastcall ReadData(System::Classes::TReader* Reader);
	void __fastcall WriteData(System::Classes::TWriter* Writer);
	
protected:
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDSpecialDates(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDSpecialDates(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property TLMDCalendarCell* Style = {read=FStyle, write=SetStyle};
	__property Lmddatel::TLMDDateList* Dates = {read=FDates, write=SetDates};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property bool AddTimeToHintText = {read=FAddTimeToHint, write=FAddTimeToHint, default=0};
	__property TLMDVisibleMode VisibleMode = {read=FVisibleMode, write=SetVisibleMode, default=0};
	__property Index;
	__property DisplayName = {default=0};
	__property TLMDDrawCellEvent OnDraw = {read=FOnDraw, write=FOnDraw};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSpecialDateGroups : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDSpecialDates* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDCustomCalendar* FCalendar;
	HIDESBASE TLMDSpecialDates* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDSpecialDates* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDSpecialDateGroups(TLMDCustomCalendar* Calendar);
	__fastcall virtual ~TLMDSpecialDateGroups(void);
	HIDESBASE TLMDSpecialDates* __fastcall Add(void);
	__property TLMDSpecialDates* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDOnDateSelEvent)(System::TObject* Sender, System::TDateTime Date);

typedef void __fastcall (__closure *TLMDOnYearChange)(System::TObject* Sender, int Year);

typedef void __fastcall (__closure *TLMDOnMonthChange)(System::TObject* Sender, int Month);

typedef void __fastcall (__closure *TLMDOnDayChange)(System::TObject* Sender, int Day);

typedef void __fastcall (__closure *TLMDOnGetCellSettings)(System::TObject* Sender, int day, System::UnicodeString &Mask, Lmdgraph::TLMDAlignment &Alignment, Vcl::Graphics::TFont* Font, Lmd3dcaption::TLMD3DCaption* Font3D, Lmdbevel::TLMDBevel* Bevel, Lmdfillobject::TLMDFillObject* FillObject);

class PASCALIMPLEMENTATION TLMDCustomCalendar : public Lmdcustompanelfill::TLMDCustomPanelFill
{
	typedef Lmdcustompanelfill::TLMDCustomPanelFill inherited;
	
private:
	bool FPainting;
	System::TDateTime FMinDate;
	System::TDateTime FMaxDate;
	TLMDDayCaptions FDays;
	TLMDDayDirections FDayDirection;
	Lmdclass::TLMDTimer* FTimerId;
	System::Word FDay;
	System::Word FMonth;
	System::Word FYear;
	Vcl::Graphics::TPen* FGridPen;
	bool FAligning;
	bool FReadOnly;
	bool FModified;
	bool FFixedDimens;
	bool FAdjustSize;
	bool FShowGrid;
	bool FUseLongDayNames;
	bool FShowSpecialDayHint;
	bool FActualDate;
	bool FShowDayHint;
	System::Byte FMarkedDay;
	System::Byte FMarkedDay2;
	System::Byte FStartDay;
	TLMDCalendarRecord FCalInfos;
	int oday;
	Vcl::Controls::THintWindow* HintWnd;
	TLMDCalendarHeader* FHeader;
	TLMDCalendarCell* FDayCaptionCellStyle;
	TLMDCalendarCell* FMarkerCellStyle;
	TLMDCalendarCell* FMarker2CellStyle;
	TLMDCalendarCell* FDayCellStyle;
	TLMDCalendarCell* FInactiveCellStyle;
	TLMDCalendarCell* FSelectedCellStyle;
	TLMDSpecialDateGroups* FSpecialDates;
	System::Classes::TNotifyEvent FOnKeyPressed;
	Vcl::Controls::TMouseEvent FOnMouseClick;
	TLMDDrawCellEvent FOnDraw;
	TLMDOnDateSelEvent FOnDateSel;
	TLMDOnYearChange FOnYear;
	TLMDOnMonthChange FOnMonth;
	TLMDOnDayChange FOnDay;
	TLMDOnGetCellSettings FOnGetCellSettings;
	Lmddatel::TLMDDateList* FAlarmList;
	Lmdsimplelabel::TLMDSimpleLabel* FMLabel;
	Lmdsimplelabel::TLMDSimpleLabel* FYLabel;
	Lmdspeedbutton::TLMDSpeedButton* FTBtn;
	Lmdspeedbutton::TLMDSpeedButton* FYCombo;
	Lmdspeedbutton::TLMDSpeedButton* FMCombo;
	Lmdspeedbutton::TLMDSpeedButton* FYBtn1;
	Lmdspeedbutton::TLMDSpeedButton* FYBtn2;
	Lmdspeedbutton::TLMDSpeedButton* FMBtn1;
	Lmdspeedbutton::TLMDSpeedButton* FMBtn2;
	Vcl::Menus::TPopupMenu* FComboList;
	TLMDCalendarStyle FStyle;
	Lmdclass::TLMDColorScheme FColorScheme;
	void __fastcall SetGridPen(Vcl::Graphics::TPen* aValue);
	void __fastcall SetDays(TLMDDayCaptions aValue);
	void __fastcall SetDayDirection(TLMDDayDirections aValue);
	bool __fastcall checkDate(System::TDateTime dateval);
	void __fastcall SetWord(int index, System::Word aValue);
	void __fastcall SetStartDay(System::Byte aValue);
	void __fastcall SetMarkedDay(int index, System::Byte aValue);
	void __fastcall SetDate(int index, System::TDateTime aValue);
	System::TDateTime __fastcall GetDate(int index);
	HIDESBASE void __fastcall SetBoolean(int index, bool aValue);
	void __fastcall SetSpecialDates(TLMDSpecialDateGroups* aValue);
	void __fastcall SetCellStyle(int index, TLMDCalendarCell* aValue);
	void __fastcall SetHeader(TLMDCalendarHeader* aValue);
	MESSAGE void __fastcall CMLeftMouseClick(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	System::UnicodeString __fastcall MakeOutStr(System::UnicodeString aValue, System::UnicodeString Mask);
	void __fastcall PaintCell(TLMDCalendarCell* pStyle, const System::Types::TRect &aRect, int day);
	void __fastcall PaintTextCell(TLMDCalendarCell* pStyle, const System::Types::TRect &aRect, System::UnicodeString s);
	void __fastcall PaintADay(int pday, int x1, int y1)/* overload */;
	void __fastcall PaintADay(int AYear, int AMonth, int pday, int x1, int y1)/* overload */;
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	System::Types::TRect __fastcall getRect(int x1, int y1);
	void __fastcall GetPaintParams(int &x1f, int &y1f, int &x2f, int &y2f, int &CurDays, int &Days);
	void __fastcall PaintMonth(bool restoreBack);
	void __fastcall PaintMonthBack(bool restoreBack);
	void __fastcall SetCalendarStyle(const TLMDCalendarStyle Value);
	void __fastcall SetColorScheme(const Lmdclass::TLMDColorScheme Value);
	
protected:
	virtual void __fastcall AssignStandardGlyph(Lmdspeedbutton::TLMDSpeedButton* Btn, Lmdgraphutils::TLMDArrowDir aDir, bool aDoubleArrow);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	virtual void __fastcall DoDateChange(void);
	void __fastcall DoOnBtnClick(System::TObject* Sender);
	void __fastcall DoOnYearSelect(System::TObject* Sender);
	void __fastcall DoOnMonthSelect(System::TObject* Sender);
	virtual void __fastcall MouseClick(int XPos, int YPos);
	System::UnicodeString __fastcall GetDayStrings(System::Word y, System::Word m, System::Word d);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	void __fastcall TextOut(int x1, int y1, int w, int h, System::UnicodeString text, Lmd3dcaption::TLMD3DCaption* Effect, Lmdgraph::TLMDAlignment alignm);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &aRect);
	void __fastcall CalcAlarmList(void);
	void __fastcall DoOnTimer(System::TObject* Sender);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	virtual void __fastcall Loaded(void);
	void __fastcall RestoreCurrentBack(int pday);
	
public:
	__fastcall virtual TLMDCustomCalendar(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomCalendar(void);
	virtual bool __fastcall GetEmpty(void);
	System::Types::TPoint __fastcall DateInList(System::TDateTime Date, TLMDVisibleModes modeSet);
	int __fastcall DayAtPos(int &XPos, int &YPos);
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags);
	void __fastcall AddSpecialDate(int groupIndex, System::TDateTime datetime, System::UnicodeString des);
	void __fastcall RemoveSpecialDate(int groupIndex, int dateIndex);
	void __fastcall SetSpecialDateDescription(int groupIndex, int dateIndex, System::UnicodeString des);
	void __fastcall SetSpecialDateDT(int groupIndex, int dateIndex, System::TDateTime dt);
	__property TLMDCalendarCell* CellStyle = {read=FDayCellStyle, write=SetCellStyle, index=0};
	__property TLMDCalendarCell* SelectedCellStyle = {read=FSelectedCellStyle, write=SetCellStyle, index=1};
	__property TLMDSpecialDateGroups* SpecialDates = {read=FSpecialDates, write=SetSpecialDates};
	__property TLMDCalendarHeader* Header = {read=FHeader, write=SetHeader};
	__property TLMDDayDirections DayDirection = {read=FDayDirection, write=SetDayDirection, default=0};
	__property System::Word Day = {read=FDay, write=SetWord, index=0, default=30};
	__property System::Word Month = {read=FMonth, write=SetWord, index=1, default=12};
	__property System::Word Year = {read=FYear, write=SetWord, index=2, default=1899};
	__property bool StartWithActualDate = {read=FActualDate, write=SetBoolean, index=0, default=0};
	__property CtlXP = {default=0};
	__property TLMDDayCaptions DayCaptions = {read=FDays, write=SetDays, default=0};
	__property TLMDCalendarCell* DayCaptionCellStyle = {read=FDayCaptionCellStyle, write=SetCellStyle, index=3};
	__property bool ShowDayHint = {read=FShowDayHint, write=SetBoolean, index=1, default=0};
	__property bool UseLongDayNames = {read=FUseLongDayNames, write=SetBoolean, index=2, default=0};
	__property bool ShowSpecialDayHint = {read=FShowSpecialDayHint, write=SetBoolean, index=3, default=1};
	__property System::Byte StartDay = {read=FStartDay, write=SetStartDay, nodefault};
	__property System::TDateTime Date = {read=GetDate, write=SetDate, index=0};
	__property System::TDateTime MinDate = {read=FMinDate, write=SetDate, index=1};
	__property System::TDateTime MaxDate = {read=FMaxDate, write=SetDate, index=2};
	__property System::Byte MarkedDay = {read=FMarkedDay, write=SetMarkedDay, index=0, default=0};
	__property System::Byte MarkedDay2 = {read=FMarkedDay2, write=SetMarkedDay, index=1, default=0};
	__property TLMDCalendarCell* MarkedCellStyle = {read=FMarkerCellStyle, write=SetCellStyle, index=2};
	__property TLMDCalendarCell* Marked2CellStyle = {read=FMarker2CellStyle, write=SetCellStyle, index=4};
	__property TLMDCalendarCell* InactiveCellStyle = {read=FInactiveCellStyle, write=SetCellStyle, index=5};
	__property Vcl::Graphics::TPen* GridPen = {read=FGridPen, write=SetGridPen};
	__property bool ShowGrid = {read=FShowGrid, write=SetBoolean, index=4, default=1};
	__property bool ReadOnly = {read=FReadOnly, write=SetBoolean, index=7, default=0};
	__property bool Modified = {read=FModified, write=SetBoolean, index=8, default=0};
	__property bool FixedDimens = {read=FFixedDimens, write=SetBoolean, index=6, default=1};
	__property Vcl::Controls::TMouseEvent OnMouseClick = {read=FOnMouseClick, write=FOnMouseClick};
	__property System::Classes::TNotifyEvent OnKeyPressed = {read=FOnKeyPressed, write=FOnKeyPressed};
	__property TLMDDrawCellEvent OnDraw = {read=FOnDraw, write=FOnDraw};
	__property TLMDOnDateSelEvent OnDateSel = {read=FOnDateSel, write=FOnDateSel};
	__property TLMDOnYearChange OnYearChange = {read=FOnYear, write=FOnYear};
	__property TLMDOnMonthChange OnMonthChange = {read=FOnMonth, write=FOnMonth};
	__property TLMDOnDayChange OnDayChange = {read=FOnDay, write=FOnDay};
	__property TLMDOnGetCellSettings OnGetCellSettings = {read=FOnGetCellSettings, write=FOnGetCellSettings};
	
__published:
	__property TLMDCalendarStyle Style = {read=FStyle, write=SetCalendarStyle, default=0};
	__property Lmdclass::TLMDColorScheme ColorScheme = {read=FColorScheme, write=SetColorScheme, default=6};
	__property ParentBackground = {default=0};
	__property OnContextPopup;
	__property OnMouseActivate;
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomCalendar(HWND ParentWindow) : Lmdcustompanelfill::TLMDCustomPanelFill(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall ApplyCalendarStyleToHeader(TLMDCalendarHeader* &Header, TLMDCalendarStyle Style);
extern DELPHI_PACKAGE void __fastcall CalcCelebrationDays(Lmddatel::TLMDDateList* &table, System::Word Year);
}	/* namespace Lmdcal */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCAL)
using namespace Lmdcal;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalHPP
