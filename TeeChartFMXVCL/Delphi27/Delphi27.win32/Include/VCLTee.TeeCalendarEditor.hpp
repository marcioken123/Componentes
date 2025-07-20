// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCalendarEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecalendareditorHPP
#define Vcltee_TeecalendareditorHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeCustomShapeEditor.hpp>
#include <VCLTee.TeeCalendar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecalendareditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCalendarSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCalendarSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TCheckBox* CBWeekDays;
	Vcl::Stdctrls::TCheckBox* CBWeekUpper;
	Vcl::Stdctrls::TCheckBox* CBTrailing;
	Vcl::Stdctrls::TCheckBox* CBToday;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Comctrls::TPageControl* PageControl4;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Comctrls::TPageControl* PageControl5;
	Vcl::Comctrls::TTabSheet* TabSheet6;
	Vcl::Comctrls::TPageControl* PageControl6;
	Vcl::Stdctrls::TCheckBox* CBMonths;
	Vcl::Comctrls::TTabSheet* TabSheet7;
	Vcl::Comctrls::TPageControl* PageControl7;
	Vcl::Stdctrls::TCheckBox* CBMonthUpper;
	Vcl::Stdctrls::TCheckBox* CBPrevious;
	Vcl::Stdctrls::TCheckBox* CBNext;
	Vcl::Comctrls::TTabSheet* TabLines;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBWeekDaysClick(System::TObject* Sender);
	void __fastcall CBWeekUpperClick(System::TObject* Sender);
	void __fastcall CBTrailingClick(System::TObject* Sender);
	void __fastcall CBTodayClick(System::TObject* Sender);
	void __fastcall CBMonthsClick(System::TObject* Sender);
	void __fastcall CBMonthUpperClick(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall CheckBox2Click(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall PageControl7Change(System::TObject* Sender);
	void __fastcall PageControl6Change(System::TObject* Sender);
	void __fastcall PageControl5Change(System::TObject* Sender);
	void __fastcall PageControl4Change(System::TObject* Sender);
	void __fastcall PageControl3Change(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Teecustomshapeeditor::TFormTeeShape* IDays;
	Vcltee::Teecustomshapeeditor::TFormTeeShape* ISunday;
	Vcltee::Teecustomshapeeditor::TFormTeeShape* IToday;
	Vcltee::Teecustomshapeeditor::TFormTeeShape* ITrailing;
	Vcltee::Teecustomshapeeditor::TFormTeeShape* IMonths;
	Vcltee::Teecustomshapeeditor::TFormTeeShape* IWeekDays;
	Vcltee::Teecalendar::TCalendarSeries* Calendar;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCalendarSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCalendarSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCalendarSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCalendarSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecalendareditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECALENDAREDITOR)
using namespace Vcltee::Teecalendareditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecalendareditorHPP
