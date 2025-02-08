// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDDateListEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmddatelisteditordlgHPP
#define PlmddatelisteditordlgHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDDateL.hpp>
#include <LMDEdit.hpp>
#include <LMDButton.hpp>
#include <LMDListBox.hpp>
#include <LMDThemes.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomButton.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomControl.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmddatelisteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDateListEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDateListEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdlistbox::TLMDListBox* DList;
	Vcl::Stdctrls::TButton* OkBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	Vcl::Stdctrls::TButton* AddBtn;
	Vcl::Stdctrls::TButton* DelBtn;
	Vcl::Stdctrls::TButton* UpBtn;
	Vcl::Stdctrls::TButton* DnButn;
	Vcl::Comctrls::TDateTimePicker* DateEdit;
	Vcl::Comctrls::TDateTimePicker* TimeEdit;
	Lmdedit::TLMDEdit* Des;
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall OkBtnClick(System::TObject* Sender);
	void __fastcall CancelBtnClick(System::TObject* Sender);
	void __fastcall DelBtnClick(System::TObject* Sender);
	void __fastcall DnButnClick(System::TObject* Sender);
	void __fastcall UpBtnClick(System::TObject* Sender);
	void __fastcall DListClick(System::TObject* Sender);
	void __fastcall DesTextChangedAt(System::TObject* sender, int At);
	void __fastcall DateEditChange(System::TObject* Sender);
	void __fastcall TimeEditChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDDateListEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDDateListEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDDateListEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDateListEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmddatelisteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDDATELISTEDITORDLG)
using namespace Plmddatelisteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmddatelisteditordlgHPP
