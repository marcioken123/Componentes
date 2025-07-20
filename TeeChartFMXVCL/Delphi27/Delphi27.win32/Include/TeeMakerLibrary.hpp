// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeMakerLibrary.pas' rev: 34.00 (Windows)

#ifndef TeemakerlibraryHPP
#define TeemakerlibraryHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <TeeBlocks.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teemakerlibrary
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMakerLibrary;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAddNodeProc)(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString APath, const System::UnicodeString AName);

class PASCALIMPLEMENTATION TMakerLibrary : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupObjects;
	Vcl::Comctrls::TTreeView* TreeObjects;
	Vcl::Extctrls::TSplitter* SplitterLibrary;
	Vcl::Stdctrls::TGroupBox* GroupTextures;
	Vcl::Comctrls::TTreeView* TreeTextures;
	Vcl::Menus::TPopupMenu* PopupTextures;
	Vcl::Menus::TMenuItem* CreateFolder1;
	Vcl::Menus::TMenuItem* Rename2;
	Vcl::Menus::TMenuItem* Delete4;
	Vcl::Menus::TPopupMenu* PopupObjects;
	Vcl::Menus::TMenuItem* Addtoscene1;
	Vcl::Menus::TMenuItem* Open3;
	Vcl::Menus::TMenuItem* Delete3;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* AddFolder1;
	Vcl::Menus::TMenuItem* Rename1;
	Vcl::Menus::TMenuItem* OpeninExplorer1;
	Vcl::Menus::TMenuItem* OpeninExplorer2;
	Vcl::Menus::TMenuItem* Refresh1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Linktofolder1;
	Vcl::Menus::TMenuItem* CreateLinkto1;
	Vcl::Menus::TMenuItem* Preview1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* Refresh2;
	Vcl::Menus::TMenuItem* N4;
	void __fastcall TreeObjectsGetImageIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeObjectsGetSelectedIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeTexturesGetImageIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall TreeTexturesGetSelectedIndex(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall Open3Click(System::TObject* Sender);
	void __fastcall TreeObjectsDblClick(System::TObject* Sender);
	void __fastcall AddFolder1Click(System::TObject* Sender);
	void __fastcall Delete3Click(System::TObject* Sender);
	void __fastcall PopupObjectsPopup(System::TObject* Sender);
	void __fastcall TreeObjectsDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall TreeObjectsDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall Rename1Click(System::TObject* Sender);
	void __fastcall CreateFolder1Click(System::TObject* Sender);
	void __fastcall Rename2Click(System::TObject* Sender);
	void __fastcall Delete4Click(System::TObject* Sender);
	void __fastcall PopupTexturesPopup(System::TObject* Sender);
	void __fastcall TreeTexturesEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall TreeObjectsEdited(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, System::UnicodeString &S);
	void __fastcall TreeTexturesDragOver(System::TObject* Sender, System::TObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	void __fastcall TreeTexturesDragDrop(System::TObject* Sender, System::TObject* Source, int X, int Y);
	void __fastcall OpeninExplorer1Click(System::TObject* Sender);
	void __fastcall OpeninExplorer2Click(System::TObject* Sender);
	void __fastcall Refresh1Click(System::TObject* Sender);
	void __fastcall Linktofolder1Click(System::TObject* Sender);
	void __fastcall CreateLinkto1Click(System::TObject* Sender);
	void __fastcall TreeTexturesDblClick(System::TObject* Sender);
	void __fastcall TreeTexturesExpanding(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, bool &AllowExpansion);
	void __fastcall Preview1Click(System::TObject* Sender);
	void __fastcall TreeTexturesMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall TreeObjectsMouseUp(System::TObject* Sender, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall Refresh2Click(System::TObject* Sender);
	
private:
	System::Classes::TNotifyEvent FOnOpenObject;
	void __fastcall AddGraphicFile(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString APath, const System::UnicodeString AName);
	void __fastcall AddMakerFile(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString APath, const System::UnicodeString AName);
	void __fastcall DoDeleteTree(Vcl::Comctrls::TTreeView* ATree);
	void __fastcall DropTreeNode(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* ANode, const System::UnicodeString AExt);
	void __fastcall FinishCreateFolder(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall FinishNodeEdited(Vcl::Comctrls::TTreeNode* Node, const System::UnicodeString AExt, System::UnicodeString &S);
	void __fastcall TryLinkFolder(Vcl::Comctrls::TTreeView* ATree);
	
public:
	Teeblocks::TCustomBlock* Current;
	System::UnicodeString LibraryPath;
	__classmethod void __fastcall CheckDummyNode(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node, TAddNodeProc AProc, const System::UnicodeString APath, bool &AllowExpansion);
	bool __fastcall DropExternalFile(Vcl::Comctrls::TTreeView* ATree, const System::UnicodeString AFile);
	__classmethod void __fastcall FillFolders(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString APath, TAddNodeProc AddNode);
	__classmethod void __fastcall FillURL(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString APath, TAddNodeProc AddNode);
	bool __fastcall IsBasicFolder(Vcl::Comctrls::TTreeNode* ANode);
	bool __fastcall IsBasicNode(Vcl::Comctrls::TTreeNode* ANode);
	bool __fastcall IsDragOkFrom(System::TObject* Source, Vcl::Comctrls::TTreeView* ATree);
	void __fastcall FillTextures();
	System::UnicodeString __fastcall LinkFile(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* ANode, const System::UnicodeString AExtension)/* overload */;
	System::UnicodeString __fastcall LinkFile(const System::UnicodeString APath, const System::UnicodeString AFile, const System::UnicodeString AExtension)/* overload */;
	static bool __fastcall NodeIsFile(Vcl::Comctrls::TTreeNode* ANode);
	__classmethod bool __fastcall NodeIsLink(Vcl::Comctrls::TTreeNode* ANode);
	__classmethod System::UnicodeString __fastcall NodePath(System::UnicodeString APath, Vcl::Comctrls::TTreeNode* ANode)/* overload */;
	System::UnicodeString __fastcall NodePath(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* ANode)/* overload */;
	void __fastcall ReFillTrees();
	bool __fastcall SelectedIsMaker();
	bool __fastcall SelectedIsObj();
	System::UnicodeString __fastcall SelectedLinkFile();
	System::UnicodeString __fastcall SelectedTexture();
	void __fastcall SelectTextureFile(const System::UnicodeString FileName);
	__classmethod void __fastcall TryAddLinkFile(Vcl::Comctrls::TTreeView* ATree, Vcl::Comctrls::TTreeNode* AParent, const System::UnicodeString APath, const System::UnicodeString AName);
	void __fastcall TryFillTrees(bool AddBasicBlocks = true);
	__property System::Classes::TNotifyEvent OnOpenObject = {read=FOnOpenObject, write=FOnOpenObject};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMakerLibrary(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMakerLibrary(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMakerLibrary() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMakerLibrary(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teemakerlibrary */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEEMAKERLIBRARY)
using namespace Teemakerlibrary;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeemakerlibraryHPP
