// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDFontFXEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdfontfxeditordlgHPP
#define PlmdfontfxeditordlgHPP

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
#include <Vcl.ComCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDButton.hpp>
#include <LMDCustomButton.hpp>
#include <LMDDockButton.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDColorComboBox.hpp>
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
#include <LMDCustomLabel.hpp>
#include <LMDLabel.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>
#include <LMDThemedComboBox.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdfontfxeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* nb;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* cmb;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Extctrls::TBevel* Bevel1;
	Lmdlabel::TLMDLabel* test;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdspinedit::TLMDSpinEdit* lidepth;
	Vcl::Stdctrls::TLabel* rt;
	Lmdspinedit::TLMDSpinEdit* anglev;
	Vcl::Stdctrls::TLabel* Label2;
	Lmdcolorcombobox::TLMDColorComboBox* cmbL;
	Lmdcolorcombobox::TLMDColorComboBox* cmbs;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdspinedit::TLMDSpinEdit* shDepth;
	Lmdspinedit::TLMDSpinEdit* trac;
	Vcl::Stdctrls::TLabel* Label7;
	Lmddockbutton::TLMDDockButton* dlgl;
	Lmddockbutton::TLMDDockButton* dlgs;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall edchange(System::TObject* Sender);
	void __fastcall cmbc(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall dlgsClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFxEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFxEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFxEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFxEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdfontfxeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDFONTFXEDITORDLG)
using namespace Plmdfontfxeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdfontfxeditordlgHPP
