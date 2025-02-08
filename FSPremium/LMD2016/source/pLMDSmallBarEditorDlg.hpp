// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDSmallBarEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdsmallbareditordlgHPP
#define PlmdsmallbareditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Tabs.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDProgress.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseMeter.hpp>
#include <LMDCustomProgress.hpp>
#include <LMDClass.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDControl.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdsmallbareditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSmallBarEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSmallBarEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Lmdcolorcombobox::TLMDColorComboBox* cmbb;
	Vcl::Stdctrls::TLabel* Label1;
	Lmdspinedit::TLMDSpinEdit* spinc;
	Lmdspinedit::TLMDSpinEdit* spinh;
	Lmdspinedit::TLMDSpinEdit* spinv;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TCheckBox* chk;
	Lmdprogress::TLMDProgress* test;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	Lmddockspeedbutton::TLMDDockSpeedButton* dlgb;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall dlgbClick(System::TObject* Sender);
	void __fastcall chkClick(System::TObject* Sender);
	void __fastcall spincChange(System::TObject* Sender);
	void __fastcall cmbbChange(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSmallBarEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSmallBarEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSmallBarEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSmallBarEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdsmallbareditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSMALLBAREDITORDLG)
using namespace Plmdsmallbareditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdsmallbareditordlgHPP
