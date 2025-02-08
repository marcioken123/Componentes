// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDDateTimeEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmddatetimeeditordlgHPP
#define PlmddatetimeeditordlgHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDShSpinEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmddatetimeeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFrmDateTimeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFrmDateTimeEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* LMDButton1;
	Vcl::Stdctrls::TGroupBox* LMDGroupBox1;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel1;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel2;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel3;
	Lmdshspinedit::TLMDShSpinEdit* DayEdit;
	Lmdshspinedit::TLMDShSpinEdit* MonthEdit;
	Lmdshspinedit::TLMDShSpinEdit* YearEdit;
	Vcl::Stdctrls::TGroupBox* LMDGroupBox2;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel4;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel5;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel6;
	Lmdshspinedit::TLMDShSpinEdit* HourEdit;
	Lmdshspinedit::TLMDShSpinEdit* MinuteEdit;
	Lmdshspinedit::TLMDShSpinEdit* SecondEdit;
	Vcl::Stdctrls::TButton* LMDButton2;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	void __fastcall LMDButton1Click(System::TObject* Sender);
	void __fastcall LMDButton2Click(System::TObject* Sender);
	void __fastcall LMDAssist1CancelClick(System::TObject* Sender);
	void __fastcall LMDAssist1Completed(System::TObject* Sender, bool &Cancel);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFrmDateTimeEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFrmDateTimeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFrmDateTimeEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFrmDateTimeEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmddatetimeeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDDATETIMEEDITORDLG)
using namespace Plmddatetimeeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmddatetimeeditordlgHPP
