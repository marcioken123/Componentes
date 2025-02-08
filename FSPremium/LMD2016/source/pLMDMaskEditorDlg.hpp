// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDMaskEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdmaskeditordlgHPP
#define PlmdmaskeditordlgHPP

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
#include <LMDClass.hpp>
#include <LMDEdit.hpp>
#include <LMDCustomButton.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDListBox.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDBackPanel.hpp>
#include <LMDButton.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomControl.hpp>
#include <LMDThemes.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdmaskeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDfrmMaskEditDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDfrmMaskEditDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdbackpanel::TLMDBackPanel* LMDBackPanel1;
	Lmdlistbox::TLMDListBox* MaskListBox;
	Lmdbutton::TLMDButton* LMDButton1;
	Lmdbutton::TLMDButton* LMDButton2;
	Lmdedit::TLMDEdit* MaskEdit;
	void __fastcall MaskListBoxClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDfrmMaskEditDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDfrmMaskEditDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDfrmMaskEditDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDfrmMaskEditDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdmaskeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDMASKEDITORDLG)
using namespace Plmdmaskeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdmaskeditordlgHPP
