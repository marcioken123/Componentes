// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTaskDialogDsgn.pas' rev: 31.00 (Windows)

#ifndef LmdtaskdialogdsgnHPP
#define LmdtaskdialogdsgnHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDTaskDlg.hpp>
#include <LMDTaskDialogButtonDsgn.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtaskdialogdsgn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTaskDialogDesigner;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTaskDialogDesigner : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* pgTaskDialogSetup;
	Vcl::Comctrls::TTabSheet* tabGeneral;
	Vcl::Comctrls::TTabSheet* tabIcons;
	Vcl::Stdctrls::TButton* btnShowDialog;
	Vcl::Comctrls::TTabSheet* tabExpanded;
	Vcl::Comctrls::TTabSheet* tabButtons;
	Vcl::Comctrls::TTabSheet* tabRadio;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* chbOk;
	Vcl::Stdctrls::TCheckBox* chbCancel;
	Vcl::Stdctrls::TCheckBox* chbYes;
	Vcl::Stdctrls::TCheckBox* chbNo;
	Vcl::Stdctrls::TCheckBox* chbRetry;
	Vcl::Stdctrls::TCheckBox* chbClose;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TCheckBox* chbUseCommandLinks;
	Vcl::Stdctrls::TCheckBox* chbUseCommandLinksNoIcon;
	Vcl::Comctrls::TListView* lstvButtons;
	Vcl::Stdctrls::TButton* btnAddButton;
	Vcl::Stdctrls::TButton* btnEditButton;
	Vcl::Stdctrls::TButton* btnDelButton;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Stdctrls::TGroupBox* GroupBox4;
	Vcl::Comctrls::TListView* lstvMainIcon;
	Vcl::Comctrls::TListView* lstvFooterIcon;
	Vcl::Stdctrls::TButton* btnMainIcon;
	Vcl::Stdctrls::TButton* btnFooterIcon;
	Vcl::Stdctrls::TCheckBox* chbCustomFooterIcon;
	Vcl::Stdctrls::TCheckBox* chbCustomMainIcon;
	Vcl::Dialogs::TOpenDialog* dlgOpenIcon;
	Vcl::Controls::TImageList* imgMainIcons;
	Vcl::Controls::TImageList* imgFooterIcons;
	Vcl::Controls::TImageList* imgState;
	Vcl::Stdctrls::TButton* btnEnableButton;
	Vcl::Stdctrls::TButton* btnDisableButton;
	Vcl::Stdctrls::TGroupBox* grbDefault;
	Vcl::Stdctrls::TComboBox* cmbDefaultButton;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TGroupBox* GroupBox5;
	Vcl::Stdctrls::TGroupBox* GroupBox6;
	Vcl::Stdctrls::TMemo* edtExpandedInfo;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* edtCollapsedText;
	Vcl::Stdctrls::TEdit* edtExpandedText;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TCheckBox* chbExpandFooterArea;
	Vcl::Stdctrls::TCheckBox* chbExpandedByDefault;
	Vcl::Comctrls::TTabSheet* tabProgressBar;
	Vcl::Stdctrls::TGroupBox* GroupBox7;
	Vcl::Stdctrls::TCheckBox* chbShowProgressbar;
	Vcl::Stdctrls::TCheckBox* chbMarqueBar;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TEdit* edtMarqueeSpeed;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TEdit* edtMin;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TEdit* edtMax;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TEdit* edtPosition;
	Vcl::Stdctrls::TComboBox* cmbState;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Comctrls::TUpDown* udMin;
	Vcl::Comctrls::TUpDown* udMax;
	Vcl::Comctrls::TUpDown* udPosition;
	Vcl::Comctrls::TUpDown* udMarqueSpeed;
	Vcl::Stdctrls::TButton* btnClear;
	Vcl::Stdctrls::TGroupBox* GroupBox8;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TComboBox* cmbDefaultRadioBtn;
	Vcl::Stdctrls::TButton* btnClearBtn;
	Vcl::Stdctrls::TGroupBox* GroupBox9;
	Vcl::Comctrls::TListView* lstvRadionButton;
	Vcl::Stdctrls::TButton* btnAddRadioBtn;
	Vcl::Stdctrls::TButton* btnEditRadioBtn;
	Vcl::Stdctrls::TButton* btnDeleteBtn;
	Vcl::Stdctrls::TButton* btnEnableRadioBtn;
	Vcl::Stdctrls::TButton* btnDisableRadioBtn;
	Vcl::Stdctrls::TGroupBox* GroupBox10;
	Vcl::Stdctrls::TGroupBox* GroupBox11;
	Vcl::Extctrls::TImage* imgFooterIconPreview;
	Vcl::Extctrls::TImage* imgMainIconPreview;
	Vcl::Stdctrls::TGroupBox* GroupBox12;
	Vcl::Stdctrls::TEdit* edtFooterText;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TEdit* edtVerification;
	Vcl::Stdctrls::TCheckBox* chbVerificationChecked;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* edtContent;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* edtMainInstruction;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* edtCaption;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TGroupBox* GroupBox13;
	Vcl::Stdctrls::TCheckBox* chbCanMinimized;
	Vcl::Stdctrls::TCheckBox* chbAllowCancel;
	Vcl::Stdctrls::TCheckBox* chbCallbackTimer;
	Vcl::Stdctrls::TCheckBox* chbRTLLayout;
	Vcl::Stdctrls::TCheckBox* chbEnableHyperLinks;
	Vcl::Stdctrls::TCheckBox* chbPositionRelative;
	Vcl::Stdctrls::TButton* btnContentEdit;
	Vcl::Stdctrls::TButton* btnMainTextEdit;
	Vcl::Stdctrls::TButton* btnFooterEdit;
	void __fastcall chbCustomFooterIconClick(System::TObject* Sender);
	void __fastcall chbCustomMainIconClick(System::TObject* Sender);
	void __fastcall btnEnableButtonClick(System::TObject* Sender);
	void __fastcall btnDisableButtonClick(System::TObject* Sender);
	void __fastcall btnShowDialogClick(System::TObject* Sender);
	void __fastcall edtCaptionChange(System::TObject* Sender);
	void __fastcall edtMainInstructionChange(System::TObject* Sender);
	void __fastcall edtContentChange(System::TObject* Sender);
	void __fastcall edtVerificationChange(System::TObject* Sender);
	void __fastcall edtExpandedInfoChange(System::TObject* Sender);
	void __fastcall edtCollapsedTextChange(System::TObject* Sender);
	void __fastcall edtExpandedTextChange(System::TObject* Sender);
	void __fastcall chbOkClick(System::TObject* Sender);
	void __fastcall chbYesClick(System::TObject* Sender);
	void __fastcall addCommonButtonToCheckbox(Lmdtaskdlg::TLMDTaskDialogCommonButton AButton);
	void __fastcall removeCommonButtonToCheckbox(Lmdtaskdlg::TLMDTaskDialogCommonButton AButton);
	void __fastcall chbNoClick(System::TObject* Sender);
	void __fastcall chbCancelClick(System::TObject* Sender);
	void __fastcall chbRetryClick(System::TObject* Sender);
	void __fastcall chbCloseClick(System::TObject* Sender);
	void __fastcall chbUseCommandLinksClick(System::TObject* Sender);
	void __fastcall chbUseCommandLinksNoIconClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall chbExpandFooterAreaClick(System::TObject* Sender);
	void __fastcall chbExpandedByDefaultClick(System::TObject* Sender);
	void __fastcall chbShowProgressbarClick(System::TObject* Sender);
	void __fastcall chbMarqueBarClick(System::TObject* Sender);
	void __fastcall cmbStateChange(System::TObject* Sender);
	void __fastcall udMinChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall udMaxChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall udPositionChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall udMarqueSpeedChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall cmbDefaultButtonChange(System::TObject* Sender);
	void __fastcall lstvMainIconSelectItem(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall lstvFooterIconSelectItem(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall btnAddButtonClick(System::TObject* Sender);
	void __fastcall lstvButtonsSelectItem(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall btnClearBtnClick(System::TObject* Sender);
	void __fastcall btnEditButtonClick(System::TObject* Sender);
	void __fastcall btnDelButtonClick(System::TObject* Sender);
	void __fastcall edtFooterTextChange(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnAddRadioBtnClick(System::TObject* Sender);
	void __fastcall btnEditRadioBtnClick(System::TObject* Sender);
	void __fastcall btnDeleteBtnClick(System::TObject* Sender);
	void __fastcall btnEnableRadioBtnClick(System::TObject* Sender);
	void __fastcall btnDisableRadioBtnClick(System::TObject* Sender);
	void __fastcall btnMainIconClick(System::TObject* Sender);
	void __fastcall btnFooterIconClick(System::TObject* Sender);
	void __fastcall chbVerificationCheckedClick(System::TObject* Sender);
	void __fastcall chbAllowCancelClick(System::TObject* Sender);
	void __fastcall chbCanMinimizedClick(System::TObject* Sender);
	void __fastcall chbCallbackTimerClick(System::TObject* Sender);
	void __fastcall chbRTLLayoutClick(System::TObject* Sender);
	void __fastcall lstvRadionButtonSelectItem(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, bool Selected);
	void __fastcall chbEnableHyperLinksClick(System::TObject* Sender);
	void __fastcall chbPositionRelativeClick(System::TObject* Sender);
	void __fastcall cmbDefaultRadioBtnChange(System::TObject* Sender);
	void __fastcall lstvRadionButtonChange(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemChange Change);
	void __fastcall lstvButtonsChange(System::TObject* Sender, Vcl::Comctrls::TListItem* Item, Vcl::Comctrls::TItemChange Change);
	void __fastcall btnMainTextEditClick(System::TObject* Sender);
	void __fastcall btnFooterEditClick(System::TObject* Sender);
	void __fastcall btnContentEditClick(System::TObject* Sender);
	
private:
	Lmdtaskdlg::TLMDTaskDialog* FTaskDialog;
	void __fastcall SetTaskDialog(Lmdtaskdlg::TLMDTaskDialog* const Value);
	void __fastcall AddIconToMainIcons(System::UnicodeString ACaption, System::WideChar * AIcon);
	void __fastcall AddIconToFooterIcons(System::UnicodeString ACaption, System::WideChar * AIcon);
	
public:
	__fastcall virtual TLMDTaskDialogDesigner(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTaskDialogDesigner(void);
	__property Lmdtaskdlg::TLMDTaskDialog* TaskDialog = {read=FTaskDialog, write=SetTaskDialog};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDTaskDialogDesigner(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTaskDialogDesigner(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDTaskDialogDesigner* LMDTaskDialogDesigner;
}	/* namespace Lmdtaskdialogdsgn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTASKDIALOGDSGN)
using namespace Lmdtaskdialogdsgn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtaskdialogdsgnHPP
