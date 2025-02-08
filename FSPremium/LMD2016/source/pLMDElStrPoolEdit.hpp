// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElStrPoolEdit.pas' rev: 31.00 (Windows)

#ifndef PlmdelstrpooleditHPP
#define PlmdelstrpooleditHPP

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
#include <LMDTypes.hpp>
#include <pLMDCst.hpp>
#include <ElTree.hpp>
#include <Vcl.StdCtrls.hpp>
#include <ElACtrls.hpp>
#include <ElSplit.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElPanel.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.Menus.hpp>
#include <ElStrArray.hpp>
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <ElStrPool.hpp>
#include <ElVCLUtils.hpp>
#include <System.TypInfo.hpp>
#include <ElFrmPers.hpp>
#include <ElIni.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <ElComponent.hpp>
#include <ElTreeInplaceEditors.hpp>
#include <LMDUnicodeStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelstrpooledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TStrPoolEditForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TStrPoolEditForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* ElPanel1;
	Elpanel::TElPanel* ElPanel2;
	Elpanel::TElPanel* ElPanel3;
	Elsplit::TElSplitter* ElSplitter1;
	Elpanel::TElPanel* ElPanel4;
	Eltree::TElTree* List;
	Elpopbtn::TElPopupButton* OkBtn;
	Elpopbtn::TElPopupButton* CancelBtn;
	Elpopbtn::TElPopupButton* AddBtn;
	Elpopbtn::TElPopupButton* InsertBtn;
	Elpopbtn::TElPopupButton* DeleteBtn;
	Vcl::Menus::TPopupMenu* PopupMenu;
	Vcl::Menus::TMenuItem* AddItem;
	Vcl::Menus::TMenuItem* InsertItem;
	Vcl::Menus::TMenuItem* DeleteItem;
	Vcl::Menus::TMainMenu* MainMenu;
	Vcl::Menus::TMenuItem* Pool1;
	Vcl::Menus::TMenuItem* Clear1;
	Vcl::Menus::TMenuItem* Open1;
	Vcl::Menus::TMenuItem* Save1;
	Vcl::Menus::TMenuItem* Text1;
	Vcl::Menus::TMenuItem* Open2;
	Vcl::Menus::TMenuItem* Save2;
	Elfrmpers::TElFormPersist* ElFormPersist1;
	Elini::TElIniFile* ElIniFile1;
	Elpopbtn::TElPopupButton* UpBtn;
	Elpopbtn::TElPopupButton* DownBtn;
	Elpopbtn::TElPopupButton* CopyBtn;
	Eledits::TElEdit* Memo;
	void __fastcall ListItemFocused(System::TObject* Sender);
	void __fastcall AddBtnClick(System::TObject* Sender);
	void __fastcall InsertBtnClick(System::TObject* Sender);
	void __fastcall DeleteBtnClick(System::TObject* Sender);
	void __fastcall ListItemDeletion(System::TObject* Sender, Eltree::TElTreeItem* Item);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall ListVirtualTextNeeded(System::TObject* Sender, Eltree::TElTreeItem* Item, int SectionIndex, Lmdtypes::TLMDString &Text);
	void __fastcall ListVirtualHintNeeded(System::TObject* Sender, Eltree::TElTreeItem* Item, Lmdtypes::TLMDString &Hint);
	void __fastcall UpBtnClick(System::TObject* Sender);
	void __fastcall DownBtnClick(System::TObject* Sender);
	void __fastcall CopyBtnClick(System::TObject* Sender);
	void __fastcall OkBtnClick(System::TObject* Sender);
	
private:
	int CurIndex;
	Lmdunicodestrings::TLMDWideStringArray* StrArray;
	
public:
	void __fastcall GetData(Lmdunicodestrings::TLMDWideStringArray* anArray);
	void __fastcall SetData(Lmdunicodestrings::TLMDWideStringArray* anArray);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TStrPoolEditForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TStrPoolEditForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TStrPoolEditForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TStrPoolEditForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdelstrpooledit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELSTRPOOLEDIT)
using namespace Plmdelstrpooledit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelstrpooleditHPP
