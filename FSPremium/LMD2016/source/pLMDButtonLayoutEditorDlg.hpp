// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDButtonLayoutEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdbuttonlayouteditordlgHPP
#define PlmdbuttonlayouteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDButtonBase.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDClass.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDThemes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbuttonlayouteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonLayoutEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDButtonLayoutEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Lmdspeedbutton::TLMDSpeedButton* test;
	Vcl::Comctrls::TPageControl* nb;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel2;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel3;
	Lmdspinedit::TLMDSpinEdit* spc;
	Vcl::Stdctrls::TComboBox* cmb2;
	Vcl::Stdctrls::TComboBox* cmb;
	Lmddockspeedbutton::TLMDDockSpeedButton* LMDDockSpeedButton1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label9;
	Lmddockspeedbutton::TLMDDockSpeedButton* LMDDockSpeedButton2;
	Lmdcolorcombobox::TLMDColorComboBox* acmb;
	Lmdspinedit::TLMDSpinEdit* ari;
	Lmdspinedit::TLMDSpinEdit* ars;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel4;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TComboBox* ap;
	Lmdspinedit::TLMDSpinEdit* capX;
	Vcl::Stdctrls::TLabel* Label5;
	Lmdspinedit::TLMDSpinEdit* capY;
	Vcl::Stdctrls::TLabel* Label6;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel5;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel6;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Lmdbutton::TLMDButton* ok;
	Lmdbutton::TLMDButton* cancel;
	Lmdbutton::TLMDButton* reset;
	Lmdcheckbox::TLMDCheckBox* chk;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall edchange(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall chkClick(System::TObject* Sender);
	void __fastcall btn(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall acmbChange(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDButtonLayoutEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDButtonLayoutEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDButtonLayoutEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDButtonLayoutEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdbuttonlayouteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBUTTONLAYOUTEDITORDLG)
using namespace Plmdbuttonlayouteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbuttonlayouteditordlgHPP
