// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElXRelationsDsgn.pas' rev: 31.00 (Windows)

#ifndef PlmdelxrelationsdsgnHPP
#define PlmdelxrelationsdsgnHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Data.DB.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElPanel.hpp>
#include <LMDElDBConst.hpp>
#include <LMDUtils.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElBtnEdit.hpp>
#include <ElCombos.hpp>
#include <ElEdits.hpp>
#include <ElListBox.hpp>
#include <ElPopBtn.hpp>
#include <ElSpin.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElCheckCtl.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElPgCtl.hpp>
#include <ElDBXTree.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelxrelationsdsgn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRelationsEditor;
class DELPHICLASS TElRelationsProperty;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRelationsEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Ellabel::TElLabel* ElLabel29;
	Ellabel::TElLabel* ElLabel28;
	Ellabel::TElLabel* ElLabel27;
	Ellabel::TElLabel* ElLabel26;
	Ellabel::TElLabel* ElLabel25;
	Ellabel::TElLabel* ElLabel24;
	Ellabel::TElLabel* ElLabel20;
	Elcheckctl::TElCheckBox* ActiveCB;
	Elspin::TElSpinEdit* ActiveLevelEdit;
	Elpopbtn::TElPopupButton* ElPopupButton2;
	Elpopbtn::TElPopupButton* ElPopupButton1;
	Eledits::TElEdit* CaptionEdit;
	Elcombos::TElComboBox* DetailDisplayCB;
	Elcombos::TElComboBox* DetailFieldCB;
	Elcombos::TElComboBox* DetailDataSetCB;
	Elcombos::TElComboBox* MasterFieldCB;
	Elcombos::TElComboBox* MasterDataSetCB;
	Elcheckctl::TElCheckBox* ShowcaptionCB;
	Elcheckctl::TElCheckBox* DenyDisplCB;
	Elpopbtn::TElPopupButton* ElPopupButton3;
	Elpopbtn::TElPopupButton* ElPopupButton4;
	Vcl::Extctrls::TPanel* panel1;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TButton* Button2;
	Elpanel::TElPanel* ElPanel1;
	Vcl::Stdctrls::TListBox* ElListBox1;
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall ElPopupButton1Click(System::TObject* Sender);
	void __fastcall ElPopupButton2Click(System::TObject* Sender);
	void __fastcall ElPopupButton3Click(System::TObject* Sender);
	void __fastcall ElPopupButton4Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall ElListBox1Click(System::TObject* Sender);
	void __fastcall MasterDataSetCBChange(System::TObject* Sender);
	void __fastcall DetailDataSetCBChange(System::TObject* Sender);
	void __fastcall MasterFieldCBChange(System::TObject* Sender);
	void __fastcall DetailFieldCBChange(System::TObject* Sender);
	void __fastcall DetailDisplayCBChange(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall CaptionEditChange(System::TObject* Sender);
	void __fastcall ShowcaptionCBClick(System::TObject* Sender);
	void __fastcall ActiveCBClick(System::TObject* Sender);
	void __fastcall DenyDisplCBClick(System::TObject* Sender);
	void __fastcall ActiveLevelEditChange(System::TObject* Sender);
	
public:
	System::Classes::TComponent* AComp;
	Eldbxtree::TElXRelations* DRelations;
	Eldbxtree::TElXRelationsItem* DRelationsItem;
	Designintf::_di_IDesigner FDesigner;
	void __fastcall GetData(void);
	void __fastcall SetEnabledForControl(bool val);
	void __fastcall Initialize(void);
	void __fastcall SetDBStr(const System::UnicodeString S);
	void __fastcall CheckFieldType(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRelationsEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRelationsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRelationsEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRelationsEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElRelationsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElRelationsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElRelationsProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TRelationsEditor* RelationsEditor;
}	/* namespace Plmdelxrelationsdsgn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELXRELATIONSDSGN)
using namespace Plmdelxrelationsdsgn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelxrelationsdsgnHPP
