// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sToolEdit.pas' rev: 27.00 (Windows)

#ifndef StooleditHPP
#define StooleditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.Mask.hpp>	// Pascal unit
#include <Vcl.FileCtrl.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <System.Variants.hpp>	// Pascal unit
#include <sDialogs.hpp>	// Pascal unit
#include <sDateUtils.hpp>	// Pascal unit
#include <sCustomComboEdit.hpp>	// Pascal unit
#include <sPopupClndr.hpp>	// Pascal unit
#include <sMonthCalendar.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.MaskUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Stooledit
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TExecOpenDialogEvent)(System::TObject* Sender, System::UnicodeString &Name, bool &Action);

class DELPHICLASS TsFileDirEdit;
class PASCALIMPLEMENTATION TsFileDirEdit : public Scustomcomboedit::TsCustomComboEdit
{
	typedef Scustomcomboedit::TsCustomComboEdit inherited;
	
private:
	bool FAcceptFiles;
	System::Classes::TNotifyEvent FOnDropFiles;
	TExecOpenDialogEvent FOnBeforeDialog;
	TExecOpenDialogEvent FOnAfterDialog;
	void __fastcall SetDragAccept(bool Value);
	void __fastcall SetAcceptFiles(bool Value);
	MESSAGE void __fastcall WMDropFiles(Winapi::Messages::TWMDropFiles &Msg);
	
protected:
	bool FMultipleDirs;
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall DestroyWindowHandle(void);
	virtual System::UnicodeString __fastcall GetLongName(void) = 0 ;
	virtual System::UnicodeString __fastcall GetShortName(void) = 0 ;
	void __fastcall DoAfterDialog(System::UnicodeString &FileName, bool &Action);
	void __fastcall DoBeforeDialog(System::UnicodeString &FileName, bool &Action);
	virtual void __fastcall ReceptFileDir(const System::UnicodeString AFileName) = 0 ;
	virtual void __fastcall ClearFileList(void);
	__property MaxLength = {default=255};
	
public:
	__fastcall virtual TsFileDirEdit(System::Classes::TComponent* AOwner);
	__property System::UnicodeString LongName = {read=GetLongName};
	__property System::UnicodeString ShortName = {read=GetShortName};
	__property bool AcceptFiles = {read=FAcceptFiles, write=SetAcceptFiles, default=0};
	
__published:
	__property TExecOpenDialogEvent OnBeforeDialog = {read=FOnBeforeDialog, write=FOnBeforeDialog};
	__property TExecOpenDialogEvent OnAfterDialog = {read=FOnAfterDialog, write=FOnAfterDialog};
	__property System::Classes::TNotifyEvent OnDropFiles = {read=FOnDropFiles, write=FOnDropFiles};
public:
	/* TsCustomComboEdit.Destroy */ inline __fastcall virtual ~TsFileDirEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsFileDirEdit(HWND ParentWindow) : Scustomcomboedit::TsCustomComboEdit(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TFileDialogKind : unsigned char { dkOpen, dkSave, dkOpenPicture, dkSavePicture };

class DELPHICLASS TsFilenameEdit;
class PASCALIMPLEMENTATION TsFilenameEdit : public TsFileDirEdit
{
	typedef TsFileDirEdit inherited;
	
private:
	Vcl::Dialogs::TOpenDialog* FDialog;
	TFileDialogKind FDialogKind;
	void __fastcall CreateEditDialog(void);
	System::UnicodeString __fastcall GetFileName(void);
	System::UnicodeString __fastcall GetDefaultExt(void);
	Vcl::Dialogs::TFileEditStyle __fastcall GetFileEditStyle(void);
	System::UnicodeString __fastcall GetFilter(void);
	int __fastcall GetFilterIndex(void);
	System::UnicodeString __fastcall GetInitialDir(void);
	System::Classes::TStrings* __fastcall GetHistoryList(void);
	System::Uitypes::TOpenOptions __fastcall GetOptions(void);
	System::UnicodeString __fastcall GetDialogTitle(void);
	System::Classes::TStrings* __fastcall GetDialogFiles(void);
	void __fastcall SetDialogKind(TFileDialogKind Value);
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetDefaultExt(const System::UnicodeString Value);
	void __fastcall SetFileEditStyle(Vcl::Dialogs::TFileEditStyle Value);
	void __fastcall SetFilter(const System::UnicodeString Value);
	void __fastcall SetFilterIndex(int Value);
	void __fastcall SetInitialDir(const System::UnicodeString Value);
	void __fastcall SetHistoryList(System::Classes::TStrings* Value);
	void __fastcall SetOptions(System::Uitypes::TOpenOptions Value);
	void __fastcall SetDialogTitle(const System::UnicodeString Value);
	bool __fastcall IsCustomTitle(void);
	bool __fastcall IsCustomFilter(void);
	
protected:
	DYNAMIC void __fastcall ButtonClick(void);
	virtual void __fastcall ReceptFileDir(const System::UnicodeString AFileName);
	virtual void __fastcall ClearFileList(void);
	virtual System::UnicodeString __fastcall GetLongName(void);
	virtual System::UnicodeString __fastcall GetShortName(void);
	__property Vcl::Dialogs::TFileEditStyle FileEditStyle = {read=GetFileEditStyle, write=SetFileEditStyle, default=0};
	
public:
	__fastcall virtual TsFilenameEdit(System::Classes::TComponent* AOwner);
	__property Vcl::Dialogs::TOpenDialog* Dialog = {read=FDialog};
	__property System::Classes::TStrings* DialogFiles = {read=GetDialogFiles};
	__property System::UnicodeString DialogTitle = {read=GetDialogTitle, write=SetDialogTitle, stored=IsCustomTitle};
	
__published:
	__property AcceptFiles = {default=0};
	__property System::UnicodeString DefaultExt = {read=GetDefaultExt, write=SetDefaultExt};
	__property int FilterIndex = {read=GetFilterIndex, write=SetFilterIndex, default=1};
	__property System::UnicodeString InitialDir = {read=GetInitialDir, write=SetInitialDir};
	__property TFileDialogKind DialogKind = {read=FDialogKind, write=SetDialogKind, default=0};
	__property System::UnicodeString FileName = {read=GetFileName, write=SetFileName, stored=false};
	__property System::UnicodeString Filter = {read=GetFilter, write=SetFilter, stored=IsCustomFilter};
	__property System::Classes::TStrings* HistoryList = {read=GetHistoryList, write=SetHistoryList};
	__property System::Uitypes::TOpenOptions DialogOptions = {read=GetOptions, write=SetOptions, default=524292};
public:
	/* TsCustomComboEdit.Destroy */ inline __fastcall virtual ~TsFilenameEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsFilenameEdit(HWND ParentWindow) : TsFileDirEdit(ParentWindow) { }
	
};


class DELPHICLASS TsDirectoryEdit;
class PASCALIMPLEMENTATION TsDirectoryEdit : public TsFileDirEdit
{
	typedef TsFileDirEdit inherited;
	
private:
	Vcl::Filectrl::TSelectDirOpts FOptions;
	System::UnicodeString FInitialDir;
	System::UnicodeString FDialogText;
	Sconst::TacRoot FRoot;
	bool FNoChangeDir;
	bool FShowRootBtns;
	
protected:
	DYNAMIC void __fastcall ButtonClick(void);
	virtual void __fastcall ReceptFileDir(const System::UnicodeString AFileName);
	virtual System::UnicodeString __fastcall GetLongName(void);
	virtual System::UnicodeString __fastcall GetShortName(void);
	
public:
	__fastcall virtual TsDirectoryEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property AcceptFiles = {default=0};
	__property System::UnicodeString InitialDir = {read=FInitialDir, write=FInitialDir};
	__property Vcl::Filectrl::TSelectDirOpts DialogOptions = {read=FOptions, write=FOptions, default=7};
	__property System::UnicodeString DialogText = {read=FDialogText, write=FDialogText};
	__property bool MultipleDirs = {read=FMultipleDirs, write=FMultipleDirs, default=0};
	__property bool NoChangeDir = {read=FNoChangeDir, write=FNoChangeDir, default=0};
	__property Sconst::TacRoot Root = {read=FRoot, write=FRoot};
	__property bool ShowRootBtns = {read=FShowRootBtns, write=FShowRootBtns, default=0};
public:
	/* TsCustomComboEdit.Destroy */ inline __fastcall virtual ~TsDirectoryEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsDirectoryEdit(HWND ParentWindow) : TsFileDirEdit(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TYearDigits : unsigned char { dyDefault, dyFour, dyTwo };

typedef void __fastcall (__closure *TOnAcceptDate)(System::TObject* Sender, System::TDateTime &aDate, bool &CanAccept);

class DELPHICLASS TsCustomDateEdit;
class PASCALIMPLEMENTATION TsCustomDateEdit : public Scustomcomboedit::TsCustomComboEdit
{
	typedef Scustomcomboedit::TsCustomComboEdit inherited;
	
private:
	System::UnicodeString FTitle;
	TOnAcceptDate FOnAcceptDate;
	bool FDefaultToday;
	bool FHooked;
	bool FCheckOnExit;
	System::WideChar FBlanksChar;
	System::Classes::TStrings* FCalendarHints;
	System::Uitypes::TCalDayOfWeek FStartOfWeek;
	Sconst::TDaysOfWeek FWeekends;
	System::Uitypes::TColor FWeekendColor;
	TYearDigits FYearDigits;
	System::SmallString<10> FDateFormat;
	bool FFormatting;
	System::TDateTime FMinDate;
	System::TDateTime FMaxDate;
	Smonthcalendar::TGetCellParams FOnGetCellParams;
	bool FShowCurrentDate;
	Smonthcalendar::TGetCellParams FOnDrawDay;
	bool FShowWeeks;
	bool FShowTodayBtn;
	System::Classes::TNotifyEvent FCloseUp;
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetDate(System::TDateTime Value);
	void __fastcall SetYearDigits(TYearDigits Value);
	System::UnicodeString __fastcall GetDialogTitle(void);
	void __fastcall SetDialogTitle(const System::UnicodeString Value);
	bool __fastcall IsCustomTitle(void);
	void __fastcall SetCalendarHints(System::Classes::TStrings* Value);
	void __fastcall CalendarHintsChanged(System::TObject* Sender);
	void __fastcall SetWeekendColor(System::Uitypes::TColor Value);
	void __fastcall SetWeekends(Sconst::TDaysOfWeek Value);
	void __fastcall SetStartOfWeek(System::Uitypes::TCalDayOfWeek Value);
	void __fastcall SetBlanksChar(System::WideChar Value);
	bool __fastcall TextStored(void);
	bool __fastcall FourDigitYear(void);
	bool __fastcall FormatSettingsChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Message);
	void __fastcall SetMinDate(const System::TDateTime Value);
	void __fastcall SetMaxDate(const System::TDateTime Value);
	void __fastcall SetShowCurrentDate(const bool Value);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	
protected:
	int __fastcall CaretPos(int X);
	DYNAMIC void __fastcall Change(void);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	DYNAMIC void __fastcall KeyPress(System::WideChar &Key);
	virtual void __fastcall CreateWindowHandle(const Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall DestroyWindowHandle(void);
	System::UnicodeString __fastcall GetDateFormat(void);
	bool __fastcall DateIsStored(void);
	virtual void __fastcall ApplyDate(System::TDateTime Value);
	void __fastcall UpdateFormat(void);
	void __fastcall UpdatePopup(void);
	virtual void __fastcall PopupWindowShow(void);
	__property bool Formatting = {read=FFormatting, nodefault};
	__property EditMask = {stored=false, default=0};
	__property System::UnicodeString DialogTitle = {read=GetDialogTitle, write=SetDialogTitle, stored=IsCustomTitle};
	__property System::WideChar BlanksChar = {read=FBlanksChar, write=SetBlanksChar, default=32};
	__property System::Classes::TStrings* CalendarHints = {read=FCalendarHints, write=SetCalendarHints};
	__property bool CheckOnExit = {read=FCheckOnExit, write=FCheckOnExit, default=0};
	__property bool DefaultToday = {read=FDefaultToday, write=FDefaultToday, default=0};
	__property MaxLength = {stored=false, default=0};
	__property System::Uitypes::TCalDayOfWeek StartOfWeek = {read=FStartOfWeek, write=SetStartOfWeek, default=7};
	__property Sconst::TDaysOfWeek Weekends = {read=FWeekends, write=SetWeekends, default=64};
	__property System::Uitypes::TColor WeekendColor = {read=FWeekendColor, write=SetWeekendColor, default=255};
	__property TYearDigits YearDigits = {read=FYearDigits, write=SetYearDigits, default=1};
	__property TOnAcceptDate OnAcceptDate = {read=FOnAcceptDate, write=FOnAcceptDate};
	
public:
	virtual void __fastcall Loaded(void);
	__fastcall virtual TsCustomDateEdit(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsCustomDateEdit(void);
	bool __fastcall CheckValidDate(void);
	System::UnicodeString __fastcall GetDateMask(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall UpdateMask(void);
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	__property Text = {stored=DateIsStored};
	
__published:
	__property System::TDateTime MinDate = {read=FMinDate, write=SetMinDate};
	__property System::TDateTime MaxDate = {read=FMaxDate, write=SetMaxDate};
	__property bool ShowCurrentDate = {read=FShowCurrentDate, write=SetShowCurrentDate, default=1};
	__property bool ShowWeeks = {read=FShowWeeks, write=FShowWeeks, default=0};
	__property bool ShowTodayBtn = {read=FShowTodayBtn, write=FShowTodayBtn, default=1};
	__property Smonthcalendar::TGetCellParams OnDrawDay = {read=FOnDrawDay, write=FOnDrawDay};
	__property Smonthcalendar::TGetCellParams OnGetCellParams = {read=FOnGetCellParams, write=FOnGetCellParams};
	__property System::Classes::TNotifyEvent OnCloseUp = {read=FCloseUp, write=FCloseUp};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsCustomDateEdit(HWND ParentWindow) : Scustomcomboedit::TsCustomComboEdit(ParentWindow) { }
	
};


class DELPHICLASS TsDateEdit;
class PASCALIMPLEMENTATION TsDateEdit : public TsCustomDateEdit
{
	typedef TsCustomDateEdit inherited;
	
public:
	__fastcall virtual TsDateEdit(System::Classes::TComponent* AOwner);
	__property EditMask = {default=0};
	
__published:
	__property BlanksChar = {default=32};
	__property CalendarHints;
	__property CheckOnExit = {default=0};
	__property ClickKey = {default=32808};
	__property Date = {default=0};
	__property DefaultToday = {default=0};
	__property DialogTitle = {default=0};
	__property MaxDate = {default=0};
	__property MinDate = {default=0};
	__property PopupAlign = {default=0};
	__property PopupHeight = {default=166};
	__property PopupWidth = {default=197};
	__property StartOfWeek = {default=7};
	__property Text;
	__property Weekends = {default=64};
	__property WeekendColor = {default=255};
	__property YearDigits = {default=1};
	__property OnAcceptDate;
	__property OnButtonClick;
	__property OnChange;
	__property OnContextPopup;
public:
	/* TsCustomDateEdit.Destroy */ inline __fastcall virtual ~TsDateEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TsDateEdit(HWND ParentWindow) : TsCustomDateEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall DateFormatChanged(void);
extern DELPHI_PACKAGE System::TDateTime __fastcall StrToDateFmt(const System::UnicodeString DateFormat, const System::UnicodeString S);
}	/* namespace Stooledit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_STOOLEDIT)
using namespace Stooledit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// StooleditHPP
