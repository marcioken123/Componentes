// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDsgStructDlg.pas' rev: 31.00 (Windows)

#ifndef LmddsgstructdlgHPP
#define LmddsgstructdlgHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDDsgClass.hpp>
#include <LMDDsgModule.hpp>
#include <LMDDsgDesigner.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddsgstructdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStructDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStructDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TListBox* MessagesList;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Comctrls::TTreeView* TreeView;
	Vcl::Controls::TImageList* ImageList;
	Vcl::Stdctrls::TListBox* CurMessages;
	Vcl::Extctrls::TSplitter* Splitter2;
	Vcl::Comctrls::TStatusBar* StatusBar;
	void __fastcall MessagesListDblClick(System::TObject* Sender);
	void __fastcall TreeViewChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	Lmddsgmodule::TLMDModule* FModule;
	Vcl::Controls::TWinControl* FRoot;
	Vcl::Comctrls::TTreeNode* __fastcall DoAddCompNode(System::Classes::TComponent* AComponent, const System::UnicodeString S, Vcl::Comctrls::TTreeNode* AParent);
	void __fastcall AddHint(const System::UnicodeString AMessage, Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall AddError(const System::UnicodeString AMessage, Vcl::Comctrls::TTreeNode* ANode);
	System::UnicodeString __fastcall MakeCompFlags(System::Classes::TComponentState AState);
	void __fastcall AddCompToTree(System::Classes::TComponent* AComponent, Vcl::Comctrls::TTreeNode* AParent);
	void __fastcall UpdateImageIndexes(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall UpdateCurMessages(void);
	void __fastcall UpdateView(void);
	System::Classes::TList* FTmpChildren;
	System::Classes::TComponent* FCurRoot;
	void __fastcall AddChildProc(System::Classes::TComponent* Child);
	System::UnicodeString __fastcall DispName(System::Classes::TComponent* AComponent);
	bool __fastcall IsOwnedBy(System::Classes::TComponent* AOwner, System::Classes::TComponent* AComp);
	bool __fastcall IsDirectChildOf(System::Classes::TComponent* AParent, System::Classes::TComponent* ARoot, System::Classes::TComponent* AComp);
	void __fastcall AnalyzeChildControls(Vcl::Controls::TWinControl* AParent, Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall AnalyzeRoot(Vcl::Comctrls::TTreeNode* ANode);
	void __fastcall AnalyzeComp(System::Classes::TComponent* AComponent, Vcl::Comctrls::TTreeNode* ANode);
	
public:
	__fastcall TLMDStructDlg(System::Classes::TComponent* AOwner, Lmddsgmodule::TLMDModule* AModule);
	__fastcall virtual ~TLMDStructDlg(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDStructDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStructDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddsgstructdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDSGSTRUCTDLG)
using namespace Lmddsgstructdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddsgstructdlgHPP
