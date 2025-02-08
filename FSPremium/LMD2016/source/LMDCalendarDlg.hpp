// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCalendarDlg.pas' rev: 31.00 (Windows)

#ifndef LmdcalendardlgHPP
#define LmdcalendardlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <System.Classes.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCalendar.hpp>
#include <LMDBaseDialog.hpp>
#include <LMDContainerComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcalendardlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCalendarDlg;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDCalExecuteEvent)(System::TObject* Sender, Lmdcalendar::TLMDCalendar* cal);

class PASCALIMPLEMENTATION TLMDCalendarDlg : public Lmdbasedialog::TLMDBaseDialog
{
	typedef Lmdbasedialog::TLMDBaseDialog inherited;
	
private:
	System::TDateTime FDate;
	bool FCloseOnDblClick;
	bool FActualDateButton;
	bool FStartWithActualDate;
	int FHeaderRepeatingInterval;
	Lmdcalendar::TLMDCalendar* FCal;
	TLMDCalExecuteEvent FOnCalDlgExecute;
	System::Byte FStartDay;
	void __fastcall SetDate(System::UnicodeString aValue);
	System::UnicodeString __fastcall GetDate(void);
	void __fastcall DoOnActualDateClick(System::TObject* Sender);
	void __fastcall DoOnDblClick(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDCalendarDlg(System::Classes::TComponent* aOwner);
	virtual bool __fastcall Execute(void);
	bool __fastcall ExecuteEnh(Vcl::Forms::TForm* Main);
	__property CtlXP = {default=1};
	__property System::TDateTime DateValue = {read=FDate, write=FDate};
	
__published:
	__property About = {default=0};
	__property CaptionFill = {default=0};
	__property CaptionTitle = {default=0};
	__property Colors = {default=32};
	__property CustomButton = {default=0};
	__property System::UnicodeString Date = {read=GetDate, write=SetDate};
	__property Effect = {default=0};
	__property Hints;
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property Position = {default=5};
	__property RelatePos = {default=0};
	__property ShowHints = {default=1};
	__property bool StartWithActualDate = {read=FStartWithActualDate, write=FStartWithActualDate, default=0};
	__property System::Byte StartDay = {read=FStartDay, write=FStartDay, default=1};
	__property bool ActualDateButton = {read=FActualDateButton, write=FActualDateButton, default=0};
	__property bool CloseOnDblClick = {read=FCloseOnDblClick, write=FCloseOnDblClick, default=0};
	__property int HeaderRepeatingInterval = {read=FHeaderRepeatingInterval, write=FHeaderRepeatingInterval, default=100};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnCustomize;
	__property OnCustomClick;
	__property TLMDCalExecuteEvent OnExecute = {read=FOnCalDlgExecute, write=FOnCalDlgExecute};
public:
	/* TLMDBaseDialog.Destroy */ inline __fastcall virtual ~TLMDCalendarDlg(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcalendardlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCALENDARDLG)
using namespace Lmdcalendardlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcalendardlgHPP
