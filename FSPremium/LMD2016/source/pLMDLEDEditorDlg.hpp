// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDLEDEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdlededitordlgHPP
#define PlmdlededitordlgHPP

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
#include <LMDClass.hpp>
#include <LMDLED.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDLEDLabel.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDLEDCustomLabel.hpp>
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
#include <LMDThemes.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdlededitordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLEDEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLEDEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Lmdledlabel::TLMDLEDLabel* test;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdspinedit::TLMDSpinEdit* edhs;
	Vcl::Stdctrls::TLabel* Label1;
	Lmdspinedit::TLMDSpinEdit* edvs;
	Vcl::Stdctrls::TLabel* Label2;
	Lmdspinedit::TLMDSpinEdit* edt;
	Vcl::Stdctrls::TCheckBox* chk;
	Lmdcolorcombobox::TLMDColorComboBox* cmbb;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label5;
	Lmdcolorcombobox::TLMDColorComboBox* cmbL;
	Vcl::Stdctrls::TComboBox* pred;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt1;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt2;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall edchange(System::TObject* Sender);
	void __fastcall cmbc(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall chkClick(System::TObject* Sender);
	void __fastcall predChange(System::TObject* Sender);
	void __fastcall btn(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDLEDEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDLEDEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDLEDEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLEDEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdlededitordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDLEDEDITORDLG)
using namespace Plmdlededitordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdlededitordlgHPP
