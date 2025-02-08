// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDBevelEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdbeveleditordlgHPP
#define PlmdbeveleditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <System.Classes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDGroupBox.hpp>
#include <LMDButtonControl.hpp>
#include <LMDRadioButton.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDPanelFill.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDThemes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbeveleditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBevelEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBevelEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Comctrls::TPageControl* nb;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TComboBox* cmbStandard;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt3;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt2;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt1;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TComboBox* cmb;
	Vcl::Stdctrls::TComboBox* cmb1;
	Lmdcolorcombobox::TLMDColorComboBox* cmbs;
	Lmdcolorcombobox::TLMDColorComboBox* cmbb;
	Lmdcolorcombobox::TLMDColorComboBox* cmbL;
	Lmdspinedit::TLMDSpinEdit* edbiw;
	Lmdspinedit::TLMDSpinEdit* edbw;
	Lmdspinedit::TLMDSpinEdit* edwi;
	Lmdspinedit::TLMDSpinEdit* edwo;
	Vcl::Stdctrls::TGroupBox* LMDGroupBox1;
	Vcl::Stdctrls::TLabel* Label11;
	Lmdcolorcombobox::TLMDColorComboBox* cmbb2;
	Vcl::Stdctrls::TLabel* Label12;
	Lmdspinedit::TLMDSpinEdit* edbiw2;
	Vcl::Stdctrls::TLabel* Label13;
	Lmdcolorcombobox::TLMDColorComboBox* cmbb3;
	Vcl::Stdctrls::TLabel* Label14;
	Lmdspinedit::TLMDSpinEdit* edbiw3;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt1_2;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt1_3;
	Vcl::Stdctrls::TComboBox* cmbEdge;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* tb4;
	Vcl::Stdctrls::TRadioButton* rbStandard;
	Vcl::Stdctrls::TRadioButton* rbCustom;
	Vcl::Stdctrls::TRadioButton* rbEdge;
	Vcl::Stdctrls::TRadioButton* rbWindow;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	Vcl::Stdctrls::TCheckBox* cbLeft;
	Vcl::Stdctrls::TCheckBox* cbTop;
	Vcl::Stdctrls::TCheckBox* cbRight;
	Vcl::Stdctrls::TCheckBox* cbBottom;
	Vcl::Stdctrls::TStaticText* st;
	Lmdsimplepanel::TLMDSimplePanel* test;
	void __fastcall rbclick(System::TObject* Sender);
	void __fastcall cbLeftClick(System::TObject* Sender);
	void __fastcall cbTopClick(System::TObject* Sender);
	void __fastcall cbRightClick(System::TObject* Sender);
	void __fastcall cbBottomClick(System::TObject* Sender);
	void __fastcall cmbbChange(System::TObject* Sender);
	void __fastcall edbiwChange(System::TObject* Sender);
	void __fastcall cmbStandardChange(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall cmb1Change(System::TObject* Sender);
	void __fastcall bt1Click(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall cmbEdgeChange(System::TObject* Sender);
	void __fastcall tb4Enter(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDBevelEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDBevelEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDBevelEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBevelEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdbeveleditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBEVELEDITORDLG)
using namespace Plmdbeveleditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbeveleditordlgHPP
