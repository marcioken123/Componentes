// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsCollectionEditor.pas' rev: 31.00 (Windows)

#ifndef LmdinscollectioneditorHPP
#define LmdinscollectioneditorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <System.Variants.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>
#include <LMDInsClass.hpp>
#include <LMDInsPropInsp.hpp>
#include <LMDInsEditorWnds.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinscollectioneditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDItemReference;
class DELPHICLASS TLMDCollectionEditorDialog;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDItemReference : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int Id;
public:
	/* TObject.Create */ inline __fastcall TLMDItemReference(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDItemReference(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDCollectionEditorDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Comctrls::TToolButton* tbAdd;
	Vcl::Comctrls::TToolButton* tbDelete;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* tbMoveUp;
	Vcl::Comctrls::TToolButton* tbMoveDown;
	Vcl::Stdctrls::TListBox* lbItems;
	Vcl::Menus::TPopupMenu* PopupMenu1;
	Vcl::Menus::TMenuItem* A1;
	Vcl::Menus::TMenuItem* Delete1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Moveup1;
	Vcl::Menus::TMenuItem* Movedown1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* miToolbar;
	Vcl::Actnlist::TActionList* ActionList1;
	Vcl::Actnlist::TAction* acAdd;
	Vcl::Actnlist::TAction* acDelete;
	Vcl::Actnlist::TAction* acMoveUp;
	Vcl::Actnlist::TAction* acMoveDown;
	Vcl::Extctrls::TTimer* Timer1;
	Vcl::Controls::TImageList* Images;
	void __fastcall acAddExecute(System::TObject* Sender);
	void __fastcall acDeleteExecute(System::TObject* Sender);
	void __fastcall acMoveUpExecute(System::TObject* Sender);
	void __fastcall miToolbarClick(System::TObject* Sender);
	void __fastcall lbItemsClick(System::TObject* Sender);
	void __fastcall acMoveDownExecute(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall acDeleteUpdate(System::TObject* Sender);
	void __fastcall acMoveUpUpdate(System::TObject* Sender);
	void __fastcall acMoveDownUpdate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	
private:
	Lmdinseditorwnds::TLMDEditorWindowCallbacks* FCallbacks;
	System::Classes::TCollection* FColl;
	System::Classes::TComponent* FColOwner;
	void __fastcall CallbacksCommand(System::TObject* Sender, Lmdinseditorwnds::TLMDEditorWndCommand ACommand);
	System::Classes::TCollectionItem* __fastcall GetColItem(int AIndex);
	TLMDItemReference* __fastcall InfoById(int Id);
	Lmdtypes::TLMDString __fastcall GetItemName(int ItemIndex);
	void __fastcall SelectItemById(int Id);
	void __fastcall SetFreeNotification(void);
	void __fastcall DeleteSelected(void);
	void __fastcall UpdateListBox(void);
	void __fastcall UpdateDesignerSelection(void);
	void __fastcall UpdateStayOnTop(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__classmethod void __fastcall OpenEditor(Lmdinseditorwnds::TLMDEditorWindowCallbacks* ACallbacks, System::Classes::TCollection* AValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDCollectionEditorDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDCollectionEditorDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDCollectionEditorDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCollectionEditorDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::Classes::TList* EditorList;
}	/* namespace Lmdinscollectioneditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSCOLLECTIONEDITOR)
using namespace Lmdinscollectioneditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinscollectioneditorHPP
