// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElXItemsProp.pas' rev: 31.00 (Windows)

#ifndef PlmdelxitemspropHPP
#define PlmdelxitemspropHPP

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
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <pLMDElXItemCol.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <ElXTree.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelxitemsprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TXItemsPropDlg;
class DELPHICLASS TElXTreeItemsProperty;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TXItemsPropDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* ItemsGB;
	Vcl::Dialogs::TOpenDialog* OpenDlg;
	Vcl::Dialogs::TSaveDialog* SaveDlg;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Elxtree::TElXTree* XTree;
	Elpopbtn::TElPopupButton* NewItemBtn;
	Elpopbtn::TElPopupButton* SubitemBtn;
	Elpopbtn::TElPopupButton* DeleteBtn;
	Elpopbtn::TElPopupButton* SaveBtn;
	Elpopbtn::TElPopupButton* LoadBtn;
	Elpopbtn::TElPopupButton* EditBtn;
	Elpopbtn::TElPopupButton* MoveRightBtn;
	Elpopbtn::TElPopupButton* MoveLeftBtn;
	Elpopbtn::TElPopupButton* MoveDownBtn;
	Elpopbtn::TElPopupButton* MoveUpBtn;
	Elpopbtn::TElPopupButton* DuplicateBtn;
	Elpopbtn::TElPopupButton* OKBtn;
	Elpopbtn::TElPopupButton* CancelBtn;
	Elpopbtn::TElPopupButton* ApplyBtn;
	void __fastcall DeleteBtnClick(System::TObject* Sender);
	void __fastcall SubitemBtnClick(System::TObject* Sender);
	void __fastcall XTreeItemFocused(System::TObject* Sender);
	void __fastcall NewItemBtnClick(System::TObject* Sender);
	void __fastcall EditBtnClick(System::TObject* Sender);
	void __fastcall OKBtnClick(System::TObject* Sender);
	void __fastcall SaveBtnClick(System::TObject* Sender);
	void __fastcall LoadBtnClick(System::TObject* Sender);
	void __fastcall XTreeStartDrag(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	void __fastcall XTreeDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall XTreeDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall XTreeKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall MoveRightBtnClick(System::TObject* Sender);
	void __fastcall MoveLeftBtnClick(System::TObject* Sender);
	void __fastcall MoveUpBtnClick(System::TObject* Sender);
	void __fastcall MoveDownBtnClick(System::TObject* Sender);
	void __fastcall XTreeDblClick(System::TObject* Sender);
	void __fastcall DuplicateBtnClick(System::TObject* Sender);
	
private:
	Elxtree::TElXTreeItem* FDragXItem;
	
public:
	System::Classes::TComponent* AComp;
	Elxtree::TElXTreeItems* DXTreeItems;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TXItemsPropDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TXItemsPropDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TXItemsPropDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TXItemsPropDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElXTreeItemsProperty : public Designeditors::TClassProperty
{
	typedef Designeditors::TClassProperty inherited;
	
public:
	virtual void __fastcall Edit(void);
	virtual Designintf::TPropertyAttributes __fastcall GetAttributes(void);
	virtual System::UnicodeString __fastcall GetValue(void);
public:
	/* TPropertyEditor.Create */ inline __fastcall virtual TElXTreeItemsProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TClassProperty(ADesigner, APropCount) { }
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TElXTreeItemsProperty(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TXItemsPropDlg* XItemsPropDlg;
}	/* namespace Plmdelxitemsprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELXITEMSPROP)
using namespace Plmdelxitemsprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelxitemspropHPP
