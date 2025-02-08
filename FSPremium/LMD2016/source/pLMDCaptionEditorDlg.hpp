// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCaptionEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdcaptioneditordlgHPP
#define PlmdcaptioneditordlgHPP

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
#include <LMDShapeControl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcaptioneditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCaptionEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCaptionEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* cmb;
	Lmdshapecontrol::TLMDShapeControl* test;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* cap;
	Lmdbutton::TLMDButton* ok;
	Lmdbutton::TLMDButton* Button1;
	Lmdbutton::TLMDButton* reset;
	Lmdcheckbox::TLMDCheckBox* chk;
	Lmdbutton::TLMDButton* btnf;
	Lmdbutton::TLMDButton* btnffx;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall btncClick(System::TObject* Sender);
	void __fastcall chkClick(System::TObject* Sender);
	void __fastcall capChange(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDCaptionEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDCaptionEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDCaptionEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCaptionEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdcaptioneditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCAPTIONEDITORDLG)
using namespace Plmdcaptioneditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcaptioneditordlgHPP
