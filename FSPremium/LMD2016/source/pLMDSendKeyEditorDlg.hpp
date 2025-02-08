// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDSendKeyEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdsendkeyeditordlgHPP
#define PlmdsendkeyeditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDSendKeys.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDListBox.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDClass.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomMemo.hpp>
#include <LMDMemo.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDThemes.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDCustomDockLabel.hpp>
#include <LMDDockLabel.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdsendkeyeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSendKeysEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSendKeysEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Close;
	Vcl::Comctrls::TPageControl* window;
	Vcl::Comctrls::TTabSheet* keys;
	Vcl::Comctrls::TTabSheet* Windows;
	Lmdlistbox::TLMDListBox* lb2;
	Vcl::Stdctrls::TListBox* lb;
	Vcl::Stdctrls::TButton* Update;
	Vcl::Stdctrls::TGroupBox* Macro;
	Lmdmemo::TLMDMemo* m;
	Vcl::Stdctrls::TEdit* wnd;
	Lmddocklabel::TLMDDockLabel* LMDDockLabel1;
	Lmddocklabel::TLMDDockLabel* LMDDockLabel2;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Dialogs::TOpenDialog* dlg;
	Lmdcheckbox::TLMDCheckBox* last;
	Lmdinictrl::TLMDIniCtrl* ini;
	Lmdsendkeys::TLMDSendKeys* sk;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CloseClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall UpdateClick(System::TObject* Sender);
	void __fastcall lbDblClick(System::TObject* Sender);
	void __fastcall lb2DblClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSendKeysEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSendKeysEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSendKeysEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSendKeysEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdsendkeyeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSENDKEYEDITORDLG)
using namespace Plmdsendkeyeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdsendkeyeditordlgHPP
