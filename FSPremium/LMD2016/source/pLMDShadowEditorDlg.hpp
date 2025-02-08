// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDShadowEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdshadoweditordlgHPP
#define PlmdshadoweditordlgHPP

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
#include <LMDClass.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseShape.hpp>
#include <LMDThemes.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDShapeControl.hpp>
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
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdshadoweditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShadowEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShadowEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Lmdshapecontrol::TLMDShapeControl* test;
	Vcl::Stdctrls::TComboBox* cmbstyle;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdcolorcombobox::TLMDColorComboBox* cmbS;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdspinedit::TLMDSpinEdit* spind;
	Vcl::Stdctrls::TLabel* Label5;
	Lmddockspeedbutton::TLMDDockSpeedButton* dlgl;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbc(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall cmbSChange(System::TObject* Sender);
	void __fastcall spindChange(System::TObject* Sender);
	void __fastcall dlglClick(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDShadowEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDShadowEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDShadowEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShadowEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdshadoweditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSHADOWEDITORDLG)
using namespace Plmdshadoweditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdshadoweditordlgHPP
