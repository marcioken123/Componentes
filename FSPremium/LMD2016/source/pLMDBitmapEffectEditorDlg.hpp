// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDBitmapEffectEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdbitmapeffecteditordlgHPP
#define PlmdbitmapeffecteditordlgHPP

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
#include <Vcl.ImgList.hpp>
#include <System.Classes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <LMDExtSpinEdit.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomCheckListBox.hpp>
#include <LMDCheckListBox.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDClass.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDPanelFill.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDBitmapList.hpp>
#include <LMDBaseController.hpp>
#include <LMDControl.hpp>
#include <LMDThemes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbitmapeffecteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBitmapEffectEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBitmapEffectEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdpanelfill::TLMDPanelFill* test;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Comctrls::TPageControl* nb;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* reset;
	Lmdchecklistbox::TLMDCheckListBox* clb;
	Vcl::Stdctrls::TLabel* Label1;
	Lmdspinedit::TLMDSpinEdit* edBright;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TButton* btnFillObject;
	Vcl::Stdctrls::TLabel* Label2;
	Lmdextspinedit::TLMDExtSpinEdit* edStrength;
	Lmdbitmaplist::TLMDBitmapList* LMDBitmapList1;
	Vcl::Stdctrls::TLabel* lbldesc;
	void __fastcall edbiwChange(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall btnFillObjectClick(System::TObject* Sender);
	void __fastcall clbClickCheck(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDBitmapEffectEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDBitmapEffectEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDBitmapEffectEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBitmapEffectEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdbitmapeffecteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBITMAPEFFECTEDITORDLG)
using namespace Plmdbitmapeffecteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbitmapeffecteditordlgHPP
