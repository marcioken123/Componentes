// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDFillObjectEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdfillobjecteditordlgHPP
#define PlmdfillobjecteditordlgHPP

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
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseImage.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDFill.hpp>
#include <LMDClass.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomNImage.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDNImage.hpp>
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

namespace Plmdfillobjecteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFillEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFillEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Lmdfill::TLMDFill* test;
	Vcl::Comctrls::TPageControl* nb;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TComboBox* cmbStyle;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdnimage::TLMDNImage* iTest;
	Vcl::Stdctrls::TComboBox* cmbTile;
	Lmdfill::TLMDFill* btest;
	Lmdsimplelabel::TLMDSimpleLabel* info;
	Lmdfill::TLMDFill* gTest;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	Vcl::Stdctrls::TCheckBox* ck1;
	Vcl::Stdctrls::TCheckBox* ck2;
	Vcl::Stdctrls::TCheckBox* ck3;
	Vcl::Stdctrls::TButton* btnBitmap;
	Vcl::Stdctrls::TButton* btnbrush;
	Vcl::Stdctrls::TButton* btnGradient;
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall tabChange(System::TObject* Sender, int NewTab, bool &AllowChange);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall ck1Click(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFillEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFillEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFillEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFillEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdfillobjecteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDFILLOBJECTEDITORDLG)
using namespace Plmdfillobjecteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdfillobjecteditordlgHPP
