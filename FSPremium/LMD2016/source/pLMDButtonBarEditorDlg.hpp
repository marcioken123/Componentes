// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDButtonBarEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdbuttonbareditordlgHPP
#define PlmdbuttonbareditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <LMDButtonBar.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDClass.hpp>
#include <LMDButtonControl.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDComboBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDImageListBox.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDTechnicalLine.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDGroupBox.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDDlgButtonPanel.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDNoteBook.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDEdit.hpp>
#include <LMDCont.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <LMDButtonBarPopupMenu.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>
#include <LMDCustomSheetControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbuttonbareditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDButtonBarEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDButtonBarEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdbuttonbar::TLMDButtonBar* bbar;
	Lmdbuttonbarpopupmenu::TLMDButtonBarPopupMenu* LMDButtonBarPopupMenu1;
	Lmdnotebook::TLMDNoteBook* pages;
	Lmdnotebook::TLMDNoteBookPage* Section;
	Lmdnotebook::TLMDNoteBookPage* General;
	Lmdspeedbutton::TLMDSpeedButton* s1;
	Lmdspeedbutton::TLMDSpeedButton* s2;
	Lmdgroupbox::TLMDGroupBox* LMDGroupBox1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel3;
	Lmdbutton::TLMDButton* btnSectionAdd;
	Lmdbutton::TLMDButton* btnSectionRename;
	Lmdbutton::TLMDButton* btnSectionDelete;
	Lmdbutton::TLMDButton* btnSectionFont;
	Lmdbutton::TLMDButton* btnSectionFont3D;
	Lmdgroupbox::TLMDGroupBox* LMDGroupBox3;
	Lmdbutton::TLMDButton* btnFillObject;
	Lmdbutton::TLMDButton* btnFont;
	Lmdbutton::TLMDButton* btnBevel;
	Lmdbutton::TLMDButton* btnFont3D;
	Lmdcheckbox::TLMDCheckBox* LMDCheckBox1;
	Lmddlgbuttonpanel::TLMDDlgButtonPanel* LMDDlgButtonPanel1;
	Lmdbutton::TLMDButton* btnOK1;
	Lmdbutton::TLMDButton* btnCancel1;
	Lmdgroupbox::TLMDGroupBox* LMDGroupBox4;
	Lmdimagelistbox::TLMDImageListBox* largelbx;
	Lmdedit::TLMDEdit* large;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel2;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdedit::TLMDEdit* small;
	Lmdimagelistbox::TLMDImageListBox* smalllbx;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel7;
	Vcl::Extdlgs::TOpenPictureDialog* opd;
	Lmdspinedit::TLMDSpinEdit* edImg;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel4;
	Lmdspinedit::TLMDSpinEdit* lih;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel5;
	Lmdspinedit::TLMDSpinEdit* sih;
	Lmdgroupbox::TLMDGroupBox* LMDGroupBox2;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel6;
	Lmdbutton::TLMDButton* btnAddItem;
	Lmdgroupbox::TLMDGroupBox* eigb;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel8;
	Lmdbutton::TLMDButton* lgbtn;
	Lmdbutton::TLMDButton* sgbtn;
	Lmdcheckbox::TLMDCheckBox* chkParentFont;
	void __fastcall s1Click(System::TObject* Sender);
	void __fastcall smallBtnClick(System::TObject* Sender, System::TObject* Btn, int index);
	void __fastcall lgbtnClick(System::TObject* Sender);
	void __fastcall bbarItemClick(System::TObject* Sender, int Section, int Item);
	void __fastcall largelbxDblClick(System::TObject* Sender);
	void __fastcall edImgChange(System::TObject* Sender);
	void __fastcall btnClick(System::TObject* Sender);
	void __fastcall ihChange(System::TObject* Sender);
	void __fastcall bbarSectionChanged(System::TObject* Sender, int CurrentSection, int OldSection);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	int FEditItem;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall InitBoxes(void);
	void __fastcall UpdateItem(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDButtonBarEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDButtonBarEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDButtonBarEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDButtonBarEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define sedigbCaption L"Image settings for item "
}	/* namespace Plmdbuttonbareditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBUTTONBAREDITORDLG)
using namespace Plmdbuttonbareditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbuttonbareditordlgHPP
