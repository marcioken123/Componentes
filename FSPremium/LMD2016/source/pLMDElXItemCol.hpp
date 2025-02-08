// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElXItemCol.pas' rev: 31.00 (Windows)

#ifndef PlmdelxitemcolHPP
#define PlmdelxitemcolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Math.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElXTree.hpp>
#include <System.TypInfo.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <Vcl.ComCtrls.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElPanel.hpp>
#include <ElGroupBox.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElCheckCtl.hpp>
#include <ElComponent.hpp>
#include <ElTreeAdvEdit.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <ElCombos.hpp>
#include <ElClrCmb.hpp>
#include <ElHeader.hpp>
#include <ElCheckItemGrp.hpp>
#include <LMDGraph.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElPopBtn.hpp>
#include <ElPgCtl.hpp>
#include <ElCGControl.hpp>
#include <Vcl.Dialogs.hpp>
#include <ElTreeStdEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelxitemcol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TXItemColDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TXItemColDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Eltreeadvedit::TElTreeInplaceAdvancedEdit* ElTreeInplaceAdvancedEdit1;
	Elpopbtn::TElPopupButton* OKBtn;
	Elpopbtn::TElPopupButton* CancelBtn;
	Elpgctl::TElPageControl* ElPageControl1;
	Elpgctl::TElTabSheet* ElTabSheet1;
	Elpgctl::TElTabSheet* ElTabSheet2;
	Elpgctl::TElTabSheet* ElTabSheet3;
	Elpgctl::TElTabSheet* ElTabSheet4;
	Eledits::TElMemo* HintEdit;
	Eledits::TElMemo* TextEdit;
	Elgroupbox::TElGroupBox* CheckBoxGB;
	Elcheckctl::TElCheckBox* CBEnabledCB;
	Elcombos::TElComboBox* CBTypeCombo;
	Elcombos::TElComboBox* CBStateCombo;
	Elgroupbox::TElGroupBox* OwnStyleGB;
	Elgroupbox::TElGroupBox* ColorsGB;
	Elclrcmb::TElColorCombo* ColorCombo;
	Elclrcmb::TElColorCombo* BkColorCombo;
	Elclrcmb::TElColorCombo* RowBkColorCombo;
	Elgroupbox::TElGroupBox* StylesGB;
	Elcheckctl::TElCheckBox* ItCB;
	Elcheckctl::TElCheckBox* ULCB;
	Elcheckctl::TElCheckBox* BoldCB;
	Elcheckctl::TElCheckBox* StrikeCB;
	Elclrcmb::TElColorCombo* StrikeLineColorCB;
	Elgroupbox::TElGroupBox* ElGroupBox2;
	Elcombos::TElComboBox* BorderStyleCombo;
	Elclrcmb::TElColorCombo* BorderSpaceColorCB;
	Elcheckitemgrp::TElCheckGroup* BorderSidesCG;
	Elcheckctl::TElCheckBox* StrikeOutCB;
	Elcheckctl::TElCheckBox* UseBkColorsCB;
	Elgroupbox::TElGroupBox* CellStyleGB;
	Elgroupbox::TElGroupBox* ElGroupBox5;
	Elcheckctl::TElCheckBox* CellItCB;
	Elcheckctl::TElCheckBox* CellULCB;
	Elcheckctl::TElCheckBox* CellBoldCB;
	Elcheckctl::TElCheckBox* CellStrikeCB;
	Elgroupbox::TElGroupBox* CellColorsGB;
	Elclrcmb::TElColorCombo* CellColorCombo;
	Elclrcmb::TElColorCombo* CellBkColorCombo;
	Elclrcmb::TElColorCombo* CellRowBkColorCombo;
	Elclrcmb::TElColorCombo* CellStrikeLineColorCB;
	Elgroupbox::TElGroupBox* ElGroupBox3;
	Elcombos::TElComboBox* CellBorderStyleCombo;
	Elclrcmb::TElColorCombo* CellBorderSpaceColorCB;
	Elcheckitemgrp::TElCheckGroup* CellBorderSidesCG;
	Elcheckctl::TElCheckBox* CellUseBkColorsCB;
	Elcheckctl::TElCheckBox* CellStrikeOutCB;
	Elxtree::TElXTree* CellTree;
	Eledits::TElEdit* IndentEdit;
	Eledits::TElEdit* HeightEdit;
	Eledits::TElEdit* TagEdit;
	Elcheckctl::TElCheckBox* OwnHeightCB;
	Elcheckctl::TElCheckBox* IndentAdjustCB;
	Elcheckctl::TElCheckBox* WholeLineCB;
	Elcheckctl::TElCheckBox* SuppressLinesCB;
	Elcheckctl::TElCheckBox* SuppressButtonsCB;
	Elcheckctl::TElCheckBox* ForcedBtnsCB;
	Elcheckctl::TElCheckBox* AllowEditCB;
	Elcheckctl::TElCheckBox* HorZlineCB;
	Elcheckctl::TElCheckBox* WordWrapCB;
	Elcheckctl::TElCheckBox* MultilineCB;
	Elcheckctl::TElCheckBox* HintHTMLCB;
	Elcheckctl::TElCheckBox* HtmlCB;
	Elcheckctl::TElCheckBox* HiddenCB;
	Elcheckctl::TElCheckBox* EnabledCB;
	Elgroupbox::TElGroupBox* ElGroupBox1;
	Ellabel::TElLabel* Label6;
	Ellabel::TElLabel* Label7;
	Ellabel::TElLabel* Label16;
	Eledits::TElEdit* IndexEdit;
	Eledits::TElEdit* StIndexEdit;
	Eledits::TElEdit* OvIndexEdit;
	Eledits::TElEdit* Index2Edit;
	Eledits::TElEdit* StIndex2Edit;
	Eledits::TElEdit* OvIndex2Edit;
	Ellabel::TElLabel* Label14;
	Ellabel::TElLabel* Label13;
	Ellabel::TElLabel* Label2;
	Ellabel::TElLabel* Label8;
	Ellabel::TElLabel* Label9;
	Ellabel::TElLabel* Label4;
	Ellabel::TElLabel* Label5;
	Ellabel::TElLabel* Label12;
	Ellabel::TElLabel* Label15;
	Ellabel::TElLabel* Label19;
	Ellabel::TElLabel* Label1;
	Ellabel::TElLabel* Label17;
	Ellabel::TElLabel* Label18;
	Ellabel::TElLabel* Label3;
	Ellabel::TElLabel* Label20;
	Ellabel::TElLabel* Label10;
	Ellabel::TElLabel* Label11;
	Elpopbtn::TElGraphicButton* FontBtn;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall OKBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBtnClick(System::TObject* Sender);
	void __fastcall CBTypeComboChange(System::TObject* Sender);
	void __fastcall StrikeOutCBClick(System::TObject* Sender);
	void __fastcall OwnHeightCBClick(System::TObject* Sender);
	void __fastcall IndentAdjustCBClick(System::TObject* Sender);
	void __fastcall ColorsGBClick(System::TObject* Sender);
	void __fastcall OwnStyleGBClick(System::TObject* Sender);
	void __fastcall CheckBoxGBClick(System::TObject* Sender);
	void __fastcall CellColorsGBClick(System::TObject* Sender);
	void __fastcall CellTreeItemSelectedChange(System::TObject* Sender, Elxtree::TElXTreeItem* Item);
	void __fastcall ElTreeInplaceAdvancedEdit1BeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall TextEditChange(System::TObject* Sender);
	void __fastcall CellStrikeOutCBClick(System::TObject* Sender);
	void __fastcall CellTreeInplaceEditorNeeded(System::TObject* Sender, Elxtree::TElXTreeItem* Item, int SectionIndex, Elheader::TElFieldType SupposedFieldType, Eltreeinplaceeditors::TElTreeInplaceEditor* &Editor);
	void __fastcall FontBtnClick(System::TObject* Sender);
	
public:
	Elxtree::TElXTreeItem* Item;
	bool ByCancel;
	int MainTreeColumn;
	void __fastcall SetData(void);
	void __fastcall GetData(void);
	void __fastcall SetCellStyleData(int AIndex);
	void __fastcall GetCellStyleData(int AIndex);
	void __fastcall CellStyleClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TXItemColDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TXItemColDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TXItemColDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TXItemColDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TXItemColDlg* XItemColDlg;
}	/* namespace Plmdelxitemcol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELXITEMCOL)
using namespace Plmdelxitemcol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelxitemcolHPP
