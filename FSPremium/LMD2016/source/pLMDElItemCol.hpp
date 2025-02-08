// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElItemCol.pas' rev: 31.00 (Windows)

#ifndef PlmdelitemcolHPP
#define PlmdelitemcolHPP

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
#include <ElTree.hpp>
#include <System.TypInfo.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <Vcl.ComCtrls.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <ElBtnCtl.hpp>
#include <ElCheckCtl.hpp>
#include <ElBtnEdit.hpp>
#include <ElCombos.hpp>
#include <ElPopBtn.hpp>
#include <ElClrCmb.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElPgCtl.hpp>
#include <ElPanel.hpp>
#include <ElGroupBox.hpp>
#include <ElCGControl.hpp>
#include <Vcl.Dialogs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelitemcol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TItemColDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TItemColDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpopbtn::TElPopupButton* OKBtn;
	Elpopbtn::TElPopupButton* CancelBtn;
	Elpgctl::TElPageControl* ElPageControl1;
	Elpgctl::TElTabSheet* ElTabSheet1;
	Elpgctl::TElTabSheet* ElTabSheet2;
	Elpgctl::TElTabSheet* ElTabSheet3;
	Eledits::TElMemo* ColTextMemo;
	Eledits::TElMemo* HintEdit;
	Eledits::TElMemo* TextEdit;
	Eledits::TElEdit* OvIndex2Edit;
	Eledits::TElEdit* OvIndexEdit;
	Eledits::TElEdit* StIndex2Edit;
	Eledits::TElEdit* Index2Edit;
	Eledits::TElEdit* IndexEdit;
	Eledits::TElEdit* StIndexEdit;
	Elcheckctl::TElCheckBox* ShowChecksCB;
	Elcheckctl::TElCheckBox* ColorsCB;
	Elcheckctl::TElCheckBox* StylesCB;
	Elclrcmb::TElColorCombo* StrikeLineColorCB;
	Elcombos::TElComboBox* BorderStyleCombo;
	Eledits::TElEdit* IndentEdit;
	Eledits::TElEdit* HeightEdit;
	Eledits::TElEdit* TagEdit;
	Elcheckctl::TElCheckBox* WholeLineCB;
	Elcheckctl::TElCheckBox* WordWrapCB;
	Elcheckctl::TElCheckBox* CheckBox1;
	Elcheckctl::TElCheckBox* SuppressLinesCB;
	Elcheckctl::TElCheckBox* IndentAdjustCB;
	Elcheckctl::TElCheckBox* OwnHeightCB;
	Elcheckctl::TElCheckBox* MultilineCB;
	Elcheckctl::TElCheckBox* SuppressButtonsCB;
	Elcheckctl::TElCheckBox* AllowEditCB;
	Elcheckctl::TElCheckBox* HorZlineCB;
	Elcheckctl::TElCheckBox* StrikeOutCB;
	Elcheckctl::TElCheckBox* HtmlCB;
	Elcheckctl::TElCheckBox* HiddenCB;
	Elcheckctl::TElCheckBox* EnabledCB;
	Elcheckctl::TElCheckBox* ForcedBtnsCB;
	Ellabel::TElLabel* Label2;
	Ellabel::TElLabel* Label1;
	Ellabel::TElLabel* Label13;
	Ellabel::TElLabel* Label16;
	Ellabel::TElLabel* Label11;
	Ellabel::TElLabel* Label10;
	Ellabel::TElLabel* Label7;
	Ellabel::TElLabel* Label6;
	Ellabel::TElLabel* Label3;
	Ellabel::TElLabel* Label15;
	Ellabel::TElLabel* Label14;
	Elgroupbox::TElGroupBox* ColorsGB;
	Ellabel::TElLabel* Label4;
	Ellabel::TElLabel* Label5;
	Ellabel::TElLabel* Label12;
	Elcheckctl::TElCheckBox* UseBkColorCB;
	Elclrcmb::TElColorCombo* ColorCombo;
	Elclrcmb::TElColorCombo* BkColorCombo;
	Elclrcmb::TElColorCombo* RowBkColorCombo;
	Elgroupbox::TElGroupBox* CBGroup;
	Ellabel::TElLabel* Label8;
	Ellabel::TElLabel* Label9;
	Elcheckctl::TElCheckBox* CBEnabledCB;
	Elcombos::TElComboBox* CBTypeCombo;
	Elcombos::TElComboBox* CBStateCombo;
	Elgroupbox::TElGroupBox* StylesGB;
	Elcheckctl::TElCheckBox* BoldCB;
	Elcheckctl::TElCheckBox* ItCB;
	Elcheckctl::TElCheckBox* ULCB;
	Elcheckctl::TElCheckBox* StrikeCB;
	Vcl::Dialogs::TFontDialog* FontDialog1;
	Elpopbtn::TElGraphicButton* FontBtn;
	void __fastcall ColorsCBClick(System::TObject* Sender);
	void __fastcall StylesCBClick(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall OKBtnClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBtnClick(System::TObject* Sender);
	void __fastcall ShowChecksCBClick(System::TObject* Sender);
	void __fastcall CBTypeComboChange(System::TObject* Sender);
	void __fastcall StrikeOutCBClick(System::TObject* Sender);
	void __fastcall OwnHeightCBClick(System::TObject* Sender);
	void __fastcall IndentAdjustCBClick(System::TObject* Sender);
	void __fastcall FontBtnClick(System::TObject* Sender);
	
public:
	Eltree::TElTreeItem* Item;
	bool ByCancel;
	void __fastcall SetData(void);
	void __fastcall GetData(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TItemColDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TItemColDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TItemColDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TItemColDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TItemColDlg* ItemColDlg;
}	/* namespace Plmdelitemcol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELITEMCOL)
using namespace Plmdelitemcol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelitemcolHPP
