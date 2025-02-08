// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDGradientEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdgradienteditordlgHPP
#define PlmdgradienteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDColorListBox.hpp>
#include <LMDClass.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDColorComboBox.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDDrawEdge.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDFill.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDCustomColorListBox.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>
#include <LMDThemedComboBox.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdgradienteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGradientEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGradientEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdspinedit::TLMDSpinEdit* edbiw;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* direct;
	Lmdcolorcombobox::TLMDColorComboBox* cmbb;
	Lmdcolorcombobox::TLMDColorComboBox* cmbL;
	Lmdfill::TLMDFill* test;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt1;
	Lmddockspeedbutton::TLMDDockSpeedButton* bt2;
	Lmdspeedbutton::TLMDSpeedButton* ext_std;
	Lmddrawedge::TLMDDrawEdge* LMDDrawEdge1;
	Lmdcolorlistbox::TLMDColorListBox* clb;
	Lmdspeedbutton::TLMDSpeedButton* addBtn;
	Lmdspeedbutton::TLMDSpeedButton* delBtn;
	Vcl::Dialogs::TColorDialog* cd;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* cancel;
	Vcl::Stdctrls::TButton* reset;
	Vcl::Stdctrls::TCheckBox* chk;
	Lmdspeedbutton::TLMDSpeedButton* sepBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall edchange(System::TObject* Sender);
	void __fastcall cmbc(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall chkClick(System::TObject* Sender);
	void __fastcall directChange(System::TObject* Sender);
	void __fastcall btn(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall ext_stdClick(System::TObject* Sender);
	void __fastcall clbClick(System::TObject* Sender);
	void __fastcall delBtnClick(System::TObject* Sender);
	void __fastcall addBtnClick(System::TObject* Sender);
	void __fastcall sepBtnClick(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
	void __fastcall ActivateExt(void);
	void __fastcall ActivateStd(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDGradientEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDGradientEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDGradientEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDGradientEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdgradienteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDGRADIENTEDITORDLG)
using namespace Plmdgradienteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdgradienteditordlgHPP
