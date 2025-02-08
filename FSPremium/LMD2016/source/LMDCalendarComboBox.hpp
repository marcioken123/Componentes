// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalendarComboBox.pas' rev: 31.00 (Windows)

#ifndef LmdcalendarcomboboxHPP
#define LmdcalendarcomboboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCal.hpp>
#include <LMDClass.hpp>
#include <LMDCalendar.hpp>
#include <LMDCustomExtCombo.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <LMDDateFormat.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalendarcombobox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalendarComboBox;
class DELPHICLASS TLMDLabeledCalendarComboBox;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDCalendarOpenEvent)(System::TObject* Sender, Lmdcalendar::TLMDCalendar* Calendar);

class PASCALIMPLEMENTATION TLMDCalendarComboBox : public Lmdcustomextcombo::TLMDCustomExtCombo
{
	typedef Lmdcustomextcombo::TLMDCustomExtCombo inherited;
	
private:
	System::UnicodeString FOld;
	TLMDCalendarOpenEvent FCalOpen;
	bool FToday;
	System::Byte FStartDay;
	Lmdcal::TLMDCalendarStyle FCalendarStyle;
	Lmdclass::TLMDColorScheme FCalendarColorScheme;
	Lmdcalendar::TLMDCalendar* __fastcall GetCalendar(void);
	System::TDateTime __fastcall GetValue(void);
	void __fastcall SetDValue(const System::TDateTime Value);
	
protected:
	virtual void __fastcall CreateControl(void);
	virtual void __fastcall ModifyControl(void);
	virtual void __fastcall DisplayControl(void);
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall BeforeDropDown(void);
	virtual void __fastcall Cancel(void);
	virtual void __fastcall Accept(void);
	DYNAMIC void __fastcall GetCommandKey(System::Word &KeyCode, System::Classes::TShiftState Shift);
	void __fastcall DoTodayClick(System::TObject* Sender);
	virtual void __fastcall DoDateSel(System::TObject* Sender, System::TDateTime Date);
	void __fastcall DoMouseClick(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Loaded(void);
	HIDESBASE MESSAGE void __fastcall CMCancelMode(Vcl::Controls::TCMCancelMode &Message);
	
public:
	__fastcall virtual TLMDCalendarComboBox(System::Classes::TComponent* AOwner);
	virtual void __fastcall Init(void);
	__property Lmdcalendar::TLMDCalendar* Calendar = {read=GetCalendar};
	__property System::TDateTime Value = {read=GetValue, write=SetDValue};
	
__published:
	__property Lmdcal::TLMDCalendarStyle CalendarStyle = {read=FCalendarStyle, write=FCalendarStyle, nodefault};
	__property Lmdclass::TLMDColorScheme CalendarColorScheme = {read=FCalendarColorScheme, write=FCalendarColorScheme, nodefault};
	__property DateSettings;
	__property DropDownWidth = {default=0};
	__property DropDownHeight = {default=0};
	__property bool ShowTodayButton = {read=FToday, write=FToday, default=0};
	__property TLMDCalendarOpenEvent OnCalendarOpen = {read=FCalOpen, write=FCalOpen};
	__property System::Byte StartDay = {read=FStartDay, write=FStartDay, default=1};
public:
	/* TLMDCustomExtCombo.Destroy */ inline __fastcall virtual ~TLMDCalendarComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCalendarComboBox(HWND ParentWindow) : Lmdcustomextcombo::TLMDCustomExtCombo(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledCalendarComboBox : public TLMDCalendarComboBox
{
	typedef TLMDCalendarComboBox inherited;
	
public:
	__fastcall virtual TLMDLabeledCalendarComboBox(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomExtCombo.Destroy */ inline __fastcall virtual ~TLMDLabeledCalendarComboBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledCalendarComboBox(HWND ParentWindow) : TLMDCalendarComboBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalendarcombobox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALENDARCOMBOBOX)
using namespace Lmdcalendarcombobox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalendarcomboboxHPP
