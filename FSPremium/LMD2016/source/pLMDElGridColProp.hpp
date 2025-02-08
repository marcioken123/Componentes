// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElGridColProp.pas' rev: 31.00 (Windows)

#ifndef PlmdelgridcolpropHPP
#define PlmdelgridcolpropHPP

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
#include <ElSpin.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Math.hpp>
#include <Data.DB.hpp>
#include <ElDBTree.hpp>
#include <ElDBTreeGrids.hpp>
#include <LMDElDBConst.hpp>
#include <ElTree.hpp>
#include <ElHeader.hpp>
#include <ElVCLUtils.hpp>
#include <LMDGraphUtils.hpp>
#include <ElTreeComboBox.hpp>
#include <ElXPThemedControl.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <ElTreeGrids.hpp>
#include <ElACtrls.hpp>
#include <ElEdits.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <ElCLabel.hpp>
#include <ElLabel.hpp>
#include <ElPanel.hpp>
#include <HTMLLbx.hpp>
#include <ElComponent.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelgridcolprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElColumnsDefsProperty;
class DELPHICLASS TColumnDefs;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TElColumnsDefsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElColumnsDefsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElColumnsDefsProperty(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TColumnDefs : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* Panel1;
	Elpanel::TElPanel* Panel2;
	Ellabel::TElLabel* NLabel1;
	Ellabel::TElLabel* NLabel2;
	Elspin::TElSpinEdit* Edit1;
	Elpanel::TElPanel* Panel4;
	Elpopbtn::TElPopupButton* Button1;
	Elpopbtn::TElPopupButton* Button2;
	Elpopbtn::TElPopupButton* Button3;
	Elpopbtn::TElPopupButton* Button4;
	Eltreegrids::TElTreeStringGrid* Tree;
	Eltreecombobox::TElTreeInplaceComboBox* InplaceCombo;
	Elactrls::TElAdvancedComboBox* DataSetCB;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall DataSetCBChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall TreeItemDeletion(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall TreeItemDraw(System::TObject* Sender, Eltree::TElTreeItem* Item, Vcl::Graphics::TCanvas* Surface, const System::Types::TRect &R, int SectionIndex);
	void __fastcall TreeClick(System::TObject* Sender);
	void __fastcall InplaceComboBeforeOperation(System::TObject* Sender, bool &DefaultConversion);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	void __fastcall InplaceComboAfterOperation(System::TObject* Sender, bool &Accepted, bool &DefaultConversion);
	
private:
	int oldvalue;
	
public:
	System::Classes::TComponent* AComp;
	Eldbtree::TElStylesDefs* DStylesDefs;
	Eldbtree::TElStylesDefsItem* DStylesDefsItem;
	void __fastcall SetValue(void);
	void __fastcall GetValue(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TColumnDefs(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColumnDefs(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColumnDefs(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TColumnDefs(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TColumnDefs* ColumnDefs;
}	/* namespace Plmdelgridcolprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELGRIDCOLPROP)
using namespace Plmdelgridcolprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelgridcolpropHPP
