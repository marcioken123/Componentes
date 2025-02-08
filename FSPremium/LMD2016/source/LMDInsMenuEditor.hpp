// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInsMenuEditor.pas' rev: 31.00 (Windows)

#ifndef LmdinsmenueditorHPP
#define LmdinsmenueditorHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDUnicode.hpp>
#include <LMDTypes.hpp>
#include <LMDInsPropInsp.hpp>
#include <LMDInsEditorWnds.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinsmenueditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMenuEditorDialog;
class DELPHICLASS TLMDDragObject;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMenuEditorDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TButton* NewSubItemBtn;
	Vcl::Stdctrls::TButton* NewItemBtn;
	Vcl::Stdctrls::TButton* DeleteItemBtn;
	Vcl::Dialogs::TOpenDialog* OpenMenuDlg;
	Vcl::Dialogs::TSaveDialog* SaveMenuDlg;
	Vcl::Extctrls::TBevel* Bevel2;
	Vcl::Stdctrls::TButton* MoveUp;
	Vcl::Stdctrls::TButton* MoveDown;
	Vcl::Stdctrls::TButton* LevelUp;
	Vcl::Stdctrls::TButton* LevelDown;
	Vcl::Comctrls::TTreeView* MenuEdit;
	Vcl::Extctrls::TTimer* Timer1;
	void __fastcall NewItemBtnClick(System::TObject* Sender);
	void __fastcall NewSubItemBtnClick(System::TObject* Sender);
	void __fastcall DeleteItemBtnClick(System::TObject* Sender);
	void __fastcall MoveUpClick(System::TObject* Sender);
	void __fastcall MoveDownClick(System::TObject* Sender);
	void __fastcall LevelUpClick(System::TObject* Sender);
	void __fastcall LevelDownClick(System::TObject* Sender);
	void __fastcall MenuEditStartDrag(System::TObject* Sender, Vcl::Controls::TDragObject* &DragObject);
	void __fastcall MenuEditDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall MenuEditDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall MenuEditEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall MenuEditChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcl::Menus::TMenu* FMenu;
	Vcl::Menus::TMenuItem* FRootMenuItem;
	Vcl::Comctrls::TTreeNode* FDragItem;
	Vcl::Menus::TMenuItem* FMenuItem;
	Lmdinseditorwnds::TLMDEditorWindowCallbacks* FCallbacks;
	void __fastcall CallbacksCommand(System::TObject* Sender, Lmdinseditorwnds::TLMDEditorWndCommand ACommand);
	HIDESBASE void __fastcall SetMenu(Vcl::Menus::TMenu* const Value);
	void __fastcall MenuChanged(System::TObject* Sender, Vcl::Menus::TMenuItem* Source, bool Rebuild);
	void __fastcall UpdateSelection(void);
	void __fastcall UpdateStayOnTop(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__property Vcl::Menus::TMenu* Menu = {read=FMenu, write=SetMenu};
	__classmethod void __fastcall OpenEditor(Lmdinseditorwnds::TLMDEditorWindowCallbacks* ACallbacks, Vcl::Menus::TMenuItem* AValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDMenuEditorDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDMenuEditorDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDMenuEditorDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDMenuEditorDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDDragObject : public Vcl::Controls::TDragControlObject
{
	typedef Vcl::Controls::TDragControlObject inherited;
	
protected:
	virtual System::Uitypes::TCursor __fastcall GetDragCursor(bool Accepted, int X, int Y);
public:
	/* TBaseDragControlObject.Create */ inline __fastcall virtual TLMDDragObject(Vcl::Controls::TControl* AControl) : Vcl::Controls::TDragControlObject(AControl) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDragObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Vcl::Forms::TForm* __fastcall GetOwnerForm(System::Classes::TComponent* Component);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall StripHotKey(const Lmdtypes::TLMDString Text);
extern DELPHI_PACKAGE void __fastcall InsertItems(Vcl::Menus::TMenu* &AMenu, Vcl::Menus::TMenuItem* MainItem, int Index, Vcl::Menus::TMenuItem* *Items, const int Items_High);
extern DELPHI_PACKAGE void __fastcall InsertMenuItems(Vcl::Menus::TMenu* &AMenu, int Index, Vcl::Menus::TMenuItem* *Items, const int Items_High);
extern DELPHI_PACKAGE Vcl::Comctrls::TTreeNode* __fastcall FindTreeNodeByMenuItem(Vcl::Comctrls::TTreeNode* StartNode, Vcl::Menus::TMenuItem* item)/* overload */;
extern DELPHI_PACKAGE Vcl::Comctrls::TTreeNode* __fastcall FindTreeNodeByMenuItem(Vcl::Comctrls::TTreeView* TreeView, Vcl::Menus::TMenuItem* item)/* overload */;
extern DELPHI_PACKAGE void __fastcall MoveTreeNodeTo(Vcl::Comctrls::TTreeNode* Node, Vcl::Comctrls::TTreeNode* DestinationNode, int index);
extern DELPHI_PACKAGE bool __fastcall TreeNodeIsUnder(Vcl::Comctrls::TTreeNode* UnderNode, Vcl::Comctrls::TTreeNode* AboveNode);
extern DELPHI_PACKAGE void __fastcall UpdateTreeNodesFromMenu(Vcl::Menus::TMenu* Menu, Vcl::Comctrls::TTreeView* TreeView)/* overload */;
extern DELPHI_PACKAGE void __fastcall UpdateTreeNodesFromMenu(Vcl::Menus::TMenuItem* MenuItem, Vcl::Comctrls::TTreeView* TreeView, Vcl::Comctrls::TTreeNode* ParentNode)/* overload */;
}	/* namespace Lmdinsmenueditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINSMENUEDITOR)
using namespace Lmdinsmenueditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinsmenueditorHPP
