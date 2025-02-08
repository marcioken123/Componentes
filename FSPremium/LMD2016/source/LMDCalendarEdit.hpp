// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalendarEdit.pas' rev: 31.00 (Windows)

#ifndef LmdcalendareditHPP
#define LmdcalendareditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCalendarDlg.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDSBtn.hpp>
#include <LMDButtonBase.hpp>
#include <LMDDateFormat.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDBoundLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalendaredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalendarEdit;
class DELPHICLASS TLMDLabeledCalendarEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCalendarEdit : public Lmdcustommaskedit::TLMDCustomMaskEdit
{
	typedef Lmdcustommaskedit::TLMDCustomMaskEdit inherited;
	
private:
	bool FCloseDlgOnDblClick;
	bool FAddActualDateButton;
	System::Classes::TNotifyEvent FOnDlgChange;
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnClose;
	bool FForceTodayAsDefault;
	Lmdcalendardlg::TLMDCalendarDlg* FCalendarDlg;
	System::Byte FStartDay;
	void __fastcall SetDate(System::TDateTime aValue);
	System::TDateTime __fastcall GetDate(void);
	void __fastcall SetForceTodayAsDefault(bool aValue);
	void __fastcall SetStartDay(const System::Byte Value);
	
protected:
	void __fastcall DoOnBrowseClick(System::TObject* Sender, int index);
	
public:
	__fastcall virtual TLMDCalendarEdit(System::Classes::TComponent* aOwner);
	virtual void __fastcall Loaded(void);
	Lmdcalendardlg::TLMDCalendarDlg* __fastcall CalendarDlg(void);
	
__published:
	__property CustomButtons;
	__property CustomButtonsStyle = {default=9};
	__property CustomButtonWidth = {default=16};
	__property CustomButtonParentCtlXP = {default=1};
	__property bool AddActualDateButton = {read=FAddActualDateButton, write=FAddActualDateButton, default=0};
	__property bool CloseDlgOnDblClick = {read=FCloseDlgOnDblClick, write=FCloseDlgOnDblClick, default=0};
	__property System::TDateTime Date = {read=GetDate, write=SetDate};
	__property DateSettings;
	__property ReadOnly = {index=1, default=0};
	__property System::Byte StartDay = {read=FStartDay, write=SetStartDay, nodefault};
	__property System::Classes::TNotifyEvent OnDlgChange = {read=FOnDlgChange, write=FOnDlgChange};
	__property System::Classes::TNotifyEvent OnDlgClose = {read=FOnClose, write=FOnClose};
	__property System::Classes::TNotifyEvent OnDlgShow = {read=FOnShow, write=FOnShow};
	__property bool ForceTodayAsDefault = {read=FForceTodayAsDefault, write=SetForceTodayAsDefault, default=0};
public:
	/* TLMDCustomMaskEdit.Destroy */ inline __fastcall virtual ~TLMDCalendarEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCalendarEdit(HWND ParentWindow) : Lmdcustommaskedit::TLMDCustomMaskEdit(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDLabeledCalendarEdit : public TLMDCalendarEdit
{
	typedef TLMDCalendarEdit inherited;
	
public:
	__fastcall virtual TLMDLabeledCalendarEdit(System::Classes::TComponent* AOwner);
	
__published:
	__property LabelPosition = {default=0};
	__property LabelSpacing = {default=3};
	__property LabelSync = {default=0};
	__property EditLabel;
public:
	/* TLMDCustomMaskEdit.Destroy */ inline __fastcall virtual ~TLMDLabeledCalendarEdit(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLabeledCalendarEdit(HWND ParentWindow) : TLMDCalendarEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalendaredit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALENDAREDIT)
using namespace Lmdcalendaredit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalendareditHPP
