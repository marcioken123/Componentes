// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElXStylesProp.pas' rev: 31.00 (Windows)

#ifndef PlmdelxstylespropHPP
#define PlmdelxstylespropHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Math.hpp>
#include <Data.DB.hpp>
#include <ElDBXTree.hpp>
#include <LMDElDBConst.hpp>
#include <ElXTree.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElEdits.hpp>
#include <ElPgCtl.hpp>
#include <ElGroupBox.hpp>
#include <ElCheckCtl.hpp>
#include <ElACtrls.hpp>
#include <ElPanel.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <ElXPThemedControl.hpp>
#include <ElPopBtn.hpp>
#include <ElCheckItemGrp.hpp>
#include <ElBtnCtl.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElCGControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelxstylesprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElXStylesDefsProperty;
class DELPHICLASS TNewStylesPropDlg;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXStylesDefsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElXStylesDefsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElXStylesDefsProperty(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TNewStylesPropDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpgctl::TElPageControl* PageControl1;
	Elpgctl::TElTabSheet* TabSheet1;
	Elpgctl::TElTabSheet* TabSheet2;
	Elpanel::TElPanel* Panel1;
	Elpopbtn::TElPopupButton* OKBtn;
	Vcl::Comctrls::TTabControl* ListStyle;
	Elpopbtn::TElPopupButton* Button1;
	Elgroupbox::TElGroupBox* Styles;
	Elcheckctl::TElCheckBox* StylesCB;
	Elcheckctl::TElCheckBox* ColorsCB;
	Elgroupbox::TElGroupBox* StylesGB;
	Elcheckctl::TElCheckBox* BoldCB;
	Elcheckctl::TElCheckBox* ItCB;
	Elcheckctl::TElCheckBox* ULCB;
	Elcheckctl::TElCheckBox* StrikeCB;
	Elgroupbox::TElGroupBox* ColorsGB;
	Elcheckctl::TElCheckBox* UseBkColorCB;
	Elactrls::TElAdvancedComboBox* ColorCombo;
	Elactrls::TElAdvancedComboBox* RowBkColorCombo;
	Elcheckctl::TElCheckBox* ShowChecksCB;
	Elgroupbox::TElGroupBox* CBGroup;
	Elcheckctl::TElCheckBox* CBEnabledCB;
	Elactrls::TElAdvancedComboBox* CheckBoxCB;
	Elgroupbox::TElGroupBox* Image1GB;
	Elactrls::TElAdvancedComboBox* ImageCB;
	Elactrls::TElAdvancedComboBox* StImageCB;
	Elactrls::TElAdvancedComboBox* Image2CB;
	Elactrls::TElAdvancedComboBox* StImage2CB;
	Elgroupbox::TElGroupBox* Image0GB;
	Eledits::TElEdit* IndexEdit;
	Eledits::TElEdit* Index2Edit;
	Eledits::TElEdit* StIndexEdit;
	Eledits::TElEdit* StIndex2Edit;
	Elcheckitemgrp::TElRadioGroup* ImagesGB;
	Elgroupbox::TElGroupBox* PatternGB;
	Elpopbtn::TElGraphicButton* SpeedButton1;
	Eledits::TElEdit* PatternE;
	Elactrls::TElAdvancedComboBox* PatternCB;
	Elcheckctl::TElCheckBox* UsePatternCB;
	Elgroupbox::TElGroupBox* Misc;
	Elcheckctl::TElCheckBox* EnabledCB;
	Elcheckctl::TElCheckBox* HiddenCB;
	Elcheckctl::TElCheckBox* HtmlCB;
	Elcheckctl::TElCheckBox* MultilineCB;
	Elcheckctl::TElCheckBox* HorZlineCB;
	Elcheckctl::TElCheckBox* AllowEditCB;
	Elcheckctl::TElCheckBox* ForcedBtnsCB;
	Elcheckctl::TElCheckBox* SuppressButtonsCB;
	Elcheckctl::TElCheckBox* SuppressLinesCB;
	Elcheckctl::TElCheckBox* IndentAdjustCB;
	Elcheckctl::TElCheckBox* OwnHeightCB;
	Elcheckctl::TElCheckBox* StrikeOutCB;
	Elgroupbox::TElGroupBox* Hints;
	Elcheckitemgrp::TElRadioGroup* HintRG;
	Eledits::TElEdit* HintED;
	Elcheckctl::TElCheckBox* HTMLCBL;
	Elactrls::TElAdvancedComboBox* HintCB;
	Elactrls::TElAdvancedComboBox* BorderStyleCombo;
	Elactrls::TElAdvancedComboBox* StrikeLineColorCB;
	Elgroupbox::TElGroupBox* Styles1;
	Elcheckctl::TElCheckBox* StylesCB1;
	Elcheckctl::TElCheckBox* ColorsCB1;
	Elgroupbox::TElGroupBox* StylesGB1;
	Elcheckctl::TElCheckBox* BoldCB1;
	Elcheckctl::TElCheckBox* ItCB1;
	Elcheckctl::TElCheckBox* ULCB1;
	Elcheckctl::TElCheckBox* StrikeCB1;
	Elgroupbox::TElGroupBox* ColorsGB1;
	Elcheckctl::TElCheckBox* UseBkColorCB1;
	Elactrls::TElAdvancedComboBox* ColorCombo1;
	Elactrls::TElAdvancedComboBox* RowBkColorCombo1;
	Elcheckctl::TElCheckBox* ShowChecksCB1;
	Elgroupbox::TElGroupBox* CBGroup1;
	Elcheckctl::TElCheckBox* CBEnabledCB1;
	Elactrls::TElAdvancedComboBox* CheckBoxCB1;
	Elcheckitemgrp::TElRadioGroup* ImagesGB1;
	Elgroupbox::TElGroupBox* Image0GB1;
	Eledits::TElEdit* IndexEdit1;
	Eledits::TElEdit* Index2Edit1;
	Eledits::TElEdit* StIndexEdit1;
	Eledits::TElEdit* StIndex2Edit1;
	Elgroupbox::TElGroupBox* Image1GB1;
	Elactrls::TElAdvancedComboBox* ImageCB1;
	Elactrls::TElAdvancedComboBox* StImageCB1;
	Elactrls::TElAdvancedComboBox* Image2CB1;
	Elactrls::TElAdvancedComboBox* StImage2CB1;
	Elcheckctl::TElCheckBox* UsePatternCB1;
	Elgroupbox::TElGroupBox* PatternGB1;
	Elpopbtn::TElGraphicButton* SpeedButton2;
	Eledits::TElEdit* PatternE1;
	Elactrls::TElAdvancedComboBox* PatternCB1;
	Elgroupbox::TElGroupBox* Misc1;
	Elcheckctl::TElCheckBox* EnabledCB1;
	Elcheckctl::TElCheckBox* HiddenCB1;
	Elcheckctl::TElCheckBox* HtmlCB1;
	Elcheckctl::TElCheckBox* MultilineCB1;
	Elcheckctl::TElCheckBox* HorZlineCB1;
	Elcheckctl::TElCheckBox* AllowEditCB1;
	Elcheckctl::TElCheckBox* ForcedBtnsCB1;
	Elcheckctl::TElCheckBox* SuppressButtonsCB1;
	Elcheckctl::TElCheckBox* SuppressLinesCB1;
	Elcheckctl::TElCheckBox* IndentAdjustCB1;
	Elcheckctl::TElCheckBox* OwnHeightCB1;
	Elcheckctl::TElCheckBox* StrikeOutCB1;
	Elgroupbox::TElGroupBox* GroupBox1;
	Elcheckitemgrp::TElRadioGroup* HintRG1;
	Eledits::TElEdit* HintED1;
	Elcheckctl::TElCheckBox* HTMLCBL1;
	Elactrls::TElAdvancedComboBox* HintCB1;
	Elactrls::TElAdvancedComboBox* BorderStyleCombo1;
	Elactrls::TElAdvancedComboBox* StrikeLineColorCB1;
	Eledits::TElEdit* HeightEdit;
	Eledits::TElEdit* IndentEdit;
	Eledits::TElEdit* IndentEdit1;
	Eledits::TElEdit* HeightEdit1;
	Elactrls::TElAdvancedComboBox* BkColorCombo;
	Elactrls::TElAdvancedComboBox* BkColorCombo1;
	Ellabel::TElLabel* Label4;
	Ellabel::TElLabel* Label12;
	Ellabel::TElLabel* Label5;
	Ellabel::TElLabel* Label7;
	Ellabel::TElLabel* Label10;
	Ellabel::TElLabel* Label11;
	Ellabel::TElLabel* Label24;
	Ellabel::TElLabel* Label25;
	Ellabel::TElLabel* Label8;
	Ellabel::TElLabel* Label9;
	Ellabel::TElLabel* Label14;
	Ellabel::TElLabel* Label16;
	Ellabel::TElLabel* Label30;
	Ellabel::TElLabel* Label15;
	Ellabel::TElLabel* Label26;
	Ellabel::TElLabel* Label27;
	Ellabel::TElLabel* Label20;
	Ellabel::TElLabel* Label22;
	Ellabel::TElLabel* Label21;
	Ellabel::TElLabel* Label1;
	Ellabel::TElLabel* Label2;
	Ellabel::TElLabel* Label3;
	Ellabel::TElLabel* Label6;
	Ellabel::TElLabel* Label13;
	Ellabel::TElLabel* Label17;
	Ellabel::TElLabel* Label18;
	Ellabel::TElLabel* Label19;
	Ellabel::TElLabel* Label23;
	Ellabel::TElLabel* Label31;
	Ellabel::TElLabel* Label34;
	Ellabel::TElLabel* Label28;
	Ellabel::TElLabel* Label29;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OKBtnClick(System::TObject* Sender);
	void __fastcall StylesCB1Click(System::TObject* Sender);
	void __fastcall StylesCBClick(System::TObject* Sender);
	void __fastcall ColorsCBClick(System::TObject* Sender);
	void __fastcall ColorsCB1Click(System::TObject* Sender);
	void __fastcall ShowChecksCBClick(System::TObject* Sender);
	void __fastcall ShowChecksCB1Click(System::TObject* Sender);
	void __fastcall StrikeOutCBClick(System::TObject* Sender);
	void __fastcall StrikeOutCB1Click(System::TObject* Sender);
	void __fastcall OwnHeightCBClick(System::TObject* Sender);
	void __fastcall OwnHeightCB1Click(System::TObject* Sender);
	void __fastcall IndentAdjustCB1Click(System::TObject* Sender);
	void __fastcall IndentAdjustCBClick(System::TObject* Sender);
	void __fastcall ListStyleChange(System::TObject* Sender);
	void __fastcall ListStyleChanging(System::TObject* Sender, bool &AllowChange);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall ImagesGBClick(System::TObject* Sender);
	void __fastcall ImagesGB1Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall HintRGClick(System::TObject* Sender);
	void __fastcall HintRG1Click(System::TObject* Sender);
	void __fastcall UsePatternCBClick(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall UsePatternCB1Click(System::TObject* Sender);
	void __fastcall PageControl1ClosePageQuery(System::TObject* Sender, Elpgctl::TElTabSheet* Page, bool &CanClose);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PageControl1Changing(System::TObject* Sender, Elpgctl::TElTabSheet* NewPage, bool &AllowChange);
	
public:
	System::Classes::TComponent* AComp;
	Eldbxtree::TElXStylesDefs* DStylesDefs;
	Eldbxtree::TElXStylesDefsItem* DStylesDefsItem;
	void __fastcall SetData(int param);
	void __fastcall GetData(int param);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TNewStylesPropDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TNewStylesPropDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TNewStylesPropDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TNewStylesPropDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TNewStylesPropDlg* StylesPropDlg;
}	/* namespace Plmdelxstylesprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELXSTYLESPROP)
using namespace Plmdelxstylesprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelxstylespropHPP
