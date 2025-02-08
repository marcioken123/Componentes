// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDSimpleBevelEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdsimplebeveleditordlgHPP
#define PlmdsimplebeveleditordlgHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Tabs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDFormStyler.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseShape.hpp>
#include <LMDShapeControl.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDFormA.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDThemedComboBox.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdsimplebeveleditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleBevelEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSimpleBevelEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TComboBox* cmbstyle;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdspinedit::TLMDSpinEdit* spind;
	Lmdshapecontrol::TLMDShapeControl* test;
	Lmdcolorcombobox::TLMDColorComboBox* cmbL;
	Vcl::Stdctrls::TButton* dlgl;
	Vcl::Stdctrls::TLabel* Label2;
	Lmdcolorcombobox::TLMDColorComboBox* cmbs;
	Vcl::Stdctrls::TButton* dlgs;
	Vcl::Stdctrls::TLabel* Label5;
	Lmdcolorcombobox::TLMDColorComboBox* cmbn;
	Vcl::Stdctrls::TButton* dlgn;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall cmbSChange(System::TObject* Sender);
	void __fastcall spindChange(System::TObject* Sender);
	void __fastcall dlglClick(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSimpleBevelEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSimpleBevelEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSimpleBevelEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSimpleBevelEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdsimplebeveleditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSIMPLEBEVELEDITORDLG)
using namespace Plmdsimplebeveleditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdsimplebeveleditordlgHPP
