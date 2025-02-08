// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDTeethEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdteetheditordlgHPP
#define PlmdteetheditordlgHPP

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
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseShape.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDShapeControl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDThemes.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdteetheditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTeethEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTeethEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Lmdshapecontrol::TLMDShapeControl* test;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* cmb;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdspinedit::TLMDSpinEdit* spinc;
	Vcl::Stdctrls::TLabel* Label2;
	Lmdspinedit::TLMDSpinEdit* spinW;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdspinedit::TLMDSpinEdit* spinh;
	Vcl::Stdctrls::TCheckBox* chkc;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TCheckBox* chko;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall spincChange(System::TObject* Sender);
	void __fastcall chkcClick(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDTeethEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDTeethEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDTeethEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTeethEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdteetheditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDTEETHEDITORDLG)
using namespace Plmdteetheditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdteetheditordlgHPP
