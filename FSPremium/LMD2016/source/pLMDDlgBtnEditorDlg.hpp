// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDDlgBtnEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmddlgbtneditordlgHPP
#define PlmddlgbtneditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Consts.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Win.Registry.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomGroupBox.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDPanelFill.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDGroupBox.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDCustomButtonGroup.hpp>
#include <LMDCustomCheckGroup.hpp>
#include <LMDCheckGroup.hpp>
#include <LMDNoteBook.hpp>
#include <LMDCustomRadioGroup.hpp>
#include <LMDRadioGroup.hpp>
#include <LMDButtonControl.hpp>
#include <LMDRadioButton.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDClass.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDCustomDockLabel.hpp>
#include <LMDDockLabel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDDlgButtonPanel.hpp>
#include <LMDButton.hpp>
#include <LMDCustomCheckBox.hpp>
#include <LMDCheckBox.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDListBox.hpp>
#include <LMDCont.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDThemes.hpp>
#include <LMDBaseControl.hpp>
#include <LMDCustomSheetControl.hpp>
#include <LMDControl.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmddlgbtneditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDlgButtonEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDlgButtonEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	Lmdnotebook::TLMDNoteBook* nb;
	Lmdnotebook::TLMDNoteBookPage* LMDNoteBookPage1;
	Lmdcheckgroup::TLMDCheckGroup* chk;
	Lmdradiobutton::TLMDRadioButton* rb1;
	Lmdradiobutton::TLMDRadioButton* rb2;
	Lmdradiogroup::TLMDRadioGroup* list2;
	Lmdspinedit::TLMDSpinEdit* ext1;
	Lmdspinedit::TLMDSpinEdit* ext2;
	Lmddocklabel::TLMDDockLabel* LMDDockLabel1;
	Lmddocklabel::TLMDDockLabel* LMDDockLabel2;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdnotebook::TLMDNoteBookPage* LMDNoteBookPage2;
	Lmdcheckbox::TLMDCheckBox* chkr;
	Lmdspeedbutton::TLMDSpeedButton* up;
	Lmdspeedbutton::TLMDSpeedButton* Down;
	Lmdimagelist::TLMDImageList* LMDImageList1;
	Vcl::Stdctrls::TLabel* lbl;
	Lmdlistbox::TLMDListBox* lb;
	Lmdcheckbox::TLMDCheckBox* chkr2;
	Lmdradiogroup::TLMDRadioGroup* rbal;
	void __fastcall chkClick(System::TObject* Sender);
	void __fastcall list2Click(System::TObject* Sender);
	void __fastcall okClick(System::TObject* Sender);
	void __fastcall chkChange(System::TObject* Sender, int ButtonIndex);
	void __fastcall lbClick(System::TObject* Sender);
	void __fastcall btnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	System::Uitypes::TMsgDlgButtons FChecked;
	void __fastcall InsertButtons(System::Uitypes::TMsgDlgButtons aValue, bool Extra);
	
public:
	Lmddlgbuttonpanel::TLMDDlgButtonPanel* BtnPanel;
	Vcl::Forms::TCustomForm* FForm;
	void __fastcall GetIniSettings(void);
	void __fastcall SetIniSettings(void);
	void __fastcall LBFill(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDDlgButtonEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDDlgButtonEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDDlgButtonEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDlgButtonEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString regentry;
}	/* namespace Plmddlgbtneditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDDLGBTNEDITORDLG)
using namespace Plmddlgbtneditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmddlgbtneditordlgHPP
