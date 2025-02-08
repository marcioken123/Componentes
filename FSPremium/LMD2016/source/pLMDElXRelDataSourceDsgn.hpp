// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElXRelDataSourceDsgn.pas' rev: 31.00 (Windows)

#ifndef PlmdelxreldatasourcedsgnHPP
#define PlmdelxreldatasourcedsgnHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElPgCtl.hpp>
#include <ElXPThemedControl.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElEdits.hpp>
#include <ElBtnEdit.hpp>
#include <ElCombos.hpp>
#include <ElBtnCtl.hpp>
#include <ElCheckCtl.hpp>
#include <ElPanel.hpp>
#include <ElGroupBox.hpp>
#include <ElCheckItemGrp.hpp>
#include <ElListBox.hpp>
#include <ElSpin.hpp>
#include <ElPopBtn.hpp>
#include <ElDBTree.hpp>
#include <Vcl.ImgList.hpp>
#include <ElImgLst.hpp>
#include <pLMDElXRelationsDsgn.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <ElDBXTree.hpp>
#include <LMDUtils.hpp>
#include <Data.DB.hpp>
#include <LMDElDBConst.hpp>
#include <System.TypInfo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelxreldatasourcedsgn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TELRelDataSourceEditor;
class DELPHICLASS TElRelDataSourceDsgn;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TELRelDataSourceEditor : public Designeditors::TComponentEditor
{
	typedef Designeditors::TComponentEditor inherited;
	
public:
	virtual void __fastcall ExecuteVerb(int Index);
	virtual System::UnicodeString __fastcall GetVerb(int Index);
	virtual int __fastcall GetVerbCount(void);
public:
	/* TComponentEditor.Create */ inline __fastcall virtual TELRelDataSourceEditor(System::Classes::TComponent* AComponent, Designintf::_di_IDesigner ADesigner) : Designeditors::TComponentEditor(AComponent, ADesigner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TELRelDataSourceEditor(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TElRelDataSourceDsgn : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Elpgctl::TElPageControl* ElPageControl1;
	Elpgctl::TElTabSheet* ElTabSheet1;
	Elpgctl::TElTabSheet* ElTabSheet2;
	Vcl::Extctrls::TBevel* Bevel2;
	Elpopbtn::TElPopupButton* Button1;
	Elpopbtn::TElPopupButton* Button2;
	Elpopbtn::TElPopupButton* Button3;
	Vcl::Extctrls::TImage* Image1;
	Elpgctl::TElTabSheet* ElTabSheet3;
	Vcl::Extctrls::TImage* Image2;
	Elcombos::TElComboBox* SimpleRootCB;
	Elcombos::TElComboBox* SimpleRootFieldCB;
	Elcombos::TElComboBox* SimpleDetailDataSetCB;
	Elcombos::TElComboBox* SimpleDetailDisplayCB;
	Elcombos::TElComboBox* SimpleMasterFieldCB;
	Elcombos::TElComboBox* SimpleDetailFieldCB;
	Elcheckctl::TElCheckBox* ElCheckBox1;
	Eledits::TElEdit* ElEdit1;
	Elcheckctl::TElCheckBox* ElCheckBox2;
	Eledits::TElEdit* ElEdit2;
	Elcheckctl::TElCheckBox* ElCheckBox3;
	Elcombos::TElComboBox* SimpleDetailRelDisplayCB;
	Elcombos::TElComboBox* SimpleDetailRelFieldCB;
	Elcombos::TElComboBox* SimpleDetailRelCB;
	Eledits::TElEdit* ElEdit3;
	Elcombos::TElComboBox* SimpleMasterRelFieldCB;
	Elcombos::TElComboBox* SimpleMasterRelCB;
	Elcombos::TElComboBox* SimpleMasterDataSetCB;
	Elpgctl::TElTabSheet* ElTabSheet4;
	Elpgctl::TElTabSheet* ElTabSheet5;
	Elpgctl::TElTabSheet* ElTabSheet6;
	Ellabel::TElLabel* ElLabel16;
	Ellabel::TElLabel* ElLabel17;
	Elcheckitemgrp::TElRadioGroup* ElRadioGroup1;
	Elcheckitemgrp::TElRadioGroup* ElRadioGroup2;
	Elcheckctl::TElCheckBox* ElCheckBox4;
	Ellabel::TElLabel* ElLabel18;
	Eledits::TElEdit* ElEdit4;
	Ellabel::TElLabel* ElLabel19;
	Elcombos::TElComboBox* RootCB;
	Elcombos::TElComboBox* RootFieldCB;
	Elcheckctl::TElCheckBox* ElCheckBox5;
	Eledits::TElEdit* ElEdit5;
	Ellabel::TElLabel* ElLabel22;
	Elcheckctl::TElCheckBox* ElCheckBox6;
	Ellabel::TElLabel* ElLabel23;
	Eledits::TElEdit* ElEdit6;
	Elcheckctl::TElCheckBox* ElCheckBox9;
	Elpgctl::TElTabSheet* ElTabSheet7;
	Elpopbtn::TElPopupButton* ElPopupButton1;
	Elpopbtn::TElPopupButton* ElPopupButton2;
	Elpopbtn::TElPopupButton* ElPopupButton3;
	Elpopbtn::TElPopupButton* ElPopupButton4;
	Vcl::Extctrls::TShape* Shape4;
	Vcl::Extctrls::TShape* Shape5;
	Vcl::Extctrls::TShape* Shape6;
	Ellabel::TElLabel* ElLabel7;
	Ellabel::TElLabel* ElLabel30;
	Ellabel::TElLabel* ElLabel3;
	Ellabel::TElLabel* ElLabel21;
	Ellabel::TElLabel* ElLabel2;
	Vcl::Extctrls::TShape* Shape1;
	Vcl::Extctrls::TShape* Shape2;
	Vcl::Extctrls::TShape* Shape3;
	Ellabel::TElLabel* ElLabel8;
	Ellabel::TElLabel* ElLabel6;
	Ellabel::TElLabel* ElLabel5;
	Ellabel::TElLabel* ElLabel4;
	Ellabel::TElLabel* ElLabel15;
	Ellabel::TElLabel* ElLabel1;
	Ellabel::TElLabel* ElLabel31;
	Vcl::Extctrls::TImage* Image4;
	Vcl::Extctrls::TShape* Shape7;
	Vcl::Extctrls::TShape* Shape8;
	Vcl::Extctrls::TShape* Shape9;
	Ellabel::TElLabel* ElLabel32;
	Vcl::Extctrls::TImage* Image5;
	Ellabel::TElLabel* ElLabel14;
	Ellabel::TElLabel* ElLabel13;
	Ellabel::TElLabel* ElLabel12;
	Ellabel::TElLabel* ElLabel11;
	Ellabel::TElLabel* ElLabel10;
	Ellabel::TElLabel* ElLabel9;
	Vcl::Extctrls::TImage* Image3;
	Vcl::Extctrls::TImage* Image6;
	Elimglst::TElImageList* ElImageList1;
	Elcheckctl::TElCheckBox* ActiveCB;
	Ellabel::TElLabel* ElLabel25;
	Eledits::TElEdit* CaptionEdit;
	Elcheckctl::TElCheckBox* ShowcaptionCB;
	Elcombos::TElComboBox* MasterDataSetCB;
	Ellabel::TElLabel* ElLabel20;
	Ellabel::TElLabel* ElLabel24;
	Elcombos::TElComboBox* MasterFieldCB;
	Elcombos::TElComboBox* DetailDataSetCB;
	Ellabel::TElLabel* ElLabel26;
	Ellabel::TElLabel* ElLabel27;
	Ellabel::TElLabel* ElLabel28;
	Elcombos::TElComboBox* DetailFieldCB;
	Elcombos::TElComboBox* DetailDisplayCB;
	Elcheckctl::TElCheckBox* DenyDisplCB;
	Ellabel::TElLabel* ElLabel29;
	Elspin::TElSpinEdit* ActiveLevelEdit;
	Vcl::Stdctrls::TListBox* ElListBox1;
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ElRadioGroup1Click(System::TObject* Sender);
	void __fastcall ElCheckBox5Click(System::TObject* Sender);
	void __fastcall ElCheckBox6Click(System::TObject* Sender);
	void __fastcall ElPopupButton2Click(System::TObject* Sender);
	void __fastcall ElPopupButton1Click(System::TObject* Sender);
	void __fastcall ElPageControl1Change(System::TObject* Sender);
	void __fastcall ElPopupButton3Click(System::TObject* Sender);
	void __fastcall ElPopupButton4Click(System::TObject* Sender);
	void __fastcall ActiveCBClick(System::TObject* Sender);
	void __fastcall CaptionEditChange(System::TObject* Sender);
	void __fastcall ShowcaptionCBClick(System::TObject* Sender);
	void __fastcall MasterDataSetCBChange(System::TObject* Sender);
	void __fastcall MasterFieldCBChange(System::TObject* Sender);
	void __fastcall DetailDataSetCBChange(System::TObject* Sender);
	void __fastcall DetailFieldCBChange(System::TObject* Sender);
	void __fastcall DetailDisplayCBChange(System::TObject* Sender);
	void __fastcall DenyDisplCBClick(System::TObject* Sender);
	void __fastcall ActiveLevelEditChange(System::TObject* Sender);
	void __fastcall ElListBox1Click(System::TObject* Sender);
	void __fastcall ElRadioGroup2Click(System::TObject* Sender);
	void __fastcall ElEdit4Change(System::TObject* Sender);
	void __fastcall ElCheckBox4Click(System::TObject* Sender);
	void __fastcall RootCBChange(System::TObject* Sender);
	void __fastcall RootFieldCBChange(System::TObject* Sender);
	void __fastcall ElEdit6Change(System::TObject* Sender);
	void __fastcall ElCheckBox9Click(System::TObject* Sender);
	void __fastcall ElCheckBox1Click(System::TObject* Sender);
	void __fastcall ElEdit1Change(System::TObject* Sender);
	void __fastcall SimpleRootCBChange(System::TObject* Sender);
	void __fastcall SimpleRootFieldCBChange(System::TObject* Sender);
	void __fastcall ElEdit5Change(System::TObject* Sender);
	void __fastcall SimpleMasterDataSetCBChange(System::TObject* Sender);
	void __fastcall SimpleDetailDataSetCBChange(System::TObject* Sender);
	void __fastcall SimpleMasterFieldCBChange(System::TObject* Sender);
	void __fastcall SimpleDetailFieldCBChange(System::TObject* Sender);
	void __fastcall SimpleDetailDisplayCBChange(System::TObject* Sender);
	void __fastcall ElEdit2Change(System::TObject* Sender);
	void __fastcall ElCheckBox2Click(System::TObject* Sender);
	void __fastcall SimpleMasterRelCBChange(System::TObject* Sender);
	void __fastcall SimpleDetailRelCBChange(System::TObject* Sender);
	void __fastcall SimpleMasterRelFieldCBChange(System::TObject* Sender);
	void __fastcall SimpleDetailRelFieldCBChange(System::TObject* Sender);
	void __fastcall SimpleDetailRelDisplayCBChange(System::TObject* Sender);
	void __fastcall ElEdit3Change(System::TObject* Sender);
	void __fastcall ElCheckBox3Click(System::TObject* Sender);
	
public:
	System::Classes::TComponent* AComp;
	Eldbxtree::TElXRelDataSource* DElRelDataSource;
	Eldbxtree::TElXRelationsItem* DRelationsItem;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall ColorTabs(void);
	void __fastcall GetData(void);
	void __fastcall SetEnabledForControl(bool val);
	void __fastcall Initialize(void);
	void __fastcall InitializeStep(void);
	void __fastcall SetDBStr(const System::UnicodeString S);
	void __fastcall CheckFieldType(void);
	void __fastcall FinalizeStep(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElRelDataSourceDsgn(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElRelDataSourceDsgn(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElRelDataSourceDsgn(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElRelDataSourceDsgn(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


typedef System::StaticArray<System::UnicodeString, 7> Plmdelxreldatasourcedsgn__3;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TElRelDataSourceDsgn* ElRelDataSourceDsgn;
extern DELPHI_PACKAGE int Step;
extern DELPHI_PACKAGE int StepCount;
extern DELPHI_PACKAGE int SelfRef;
extern DELPHI_PACKAGE Plmdelxreldatasourcedsgn__3 Descr;
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TColor, 4> Color1;
extern DELPHI_PACKAGE System::StaticArray<System::Uitypes::TColor, 4> Color2;
#define SNoSelfRefrence L"Change to master\\detail tree type because different sets "\
	L"are used."
}	/* namespace Plmdelxreldatasourcedsgn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELXRELDATASOURCEDSGN)
using namespace Plmdelxreldatasourcedsgn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelxreldatasourcedsgnHPP
