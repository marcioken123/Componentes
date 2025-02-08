// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedKeyBindingsDialog.pas' rev: 31.00 (Windows)

#ifndef LmdsedkeybindingsdialogHPP
#define LmdsedkeybindingsdialogHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDTypes.hpp>
#include <LMDSedUtils.hpp>
#include <LMDSedView.hpp>
#include <LMDArrayUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedkeybindingsdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSedKeyBindingsDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSedKeyBindingsDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
	
private:
	typedef System::DynamicArray<Lmdsedview::TLMDEditCommandItem*> _TLMDSedKeyBindingsDlg__1;
	
	
__published:
	Vcl::Comctrls::TTreeView* trCommands;
	Vcl::Extctrls::TSplitter* Splitter1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* lbCurrentBinding;
	Vcl::Stdctrls::TLabel* lbNewBinding;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TListBox* lsBindings;
	Vcl::Stdctrls::TButton* btnDeleteBinding;
	Vcl::Stdctrls::TButton* btnAddBinding;
	Vcl::Stdctrls::TEdit* edCurrentBinding;
	Vcl::Stdctrls::TButton* btnClearBinding;
	Vcl::Stdctrls::TButton* btnResetDefault;
	Vcl::Stdctrls::TButton* btnResetAll;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall trCommandsChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall edCurrentBindingKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall edCurrentBindingKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall btnClearBindingClick(System::TObject* Sender);
	void __fastcall lsBindingsClick(System::TObject* Sender);
	void __fastcall btnAddBindingClick(System::TObject* Sender);
	void __fastcall btnDeleteBindingClick(System::TObject* Sender);
	void __fastcall btnOkClick(System::TObject* Sender);
	void __fastcall btnResetDefaultClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall lsBindingsKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall btnResetAllClick(System::TObject* Sender);
	
private:
	System::Classes::TShortCut FCurrentSc;
	System::Classes::TShortCut FCurrentSc2;
	_TLMDSedKeyBindingsDlg__1 FSrt;
	System::TObject* FCurrentSortData;
	Lmdsedview::TLMDCustomEditView* FView;
	int __fastcall CommandSortOps(int AIdx1, int AIdx2, Lmdarrayutils::TLMDArrayOperation AOp);
	int __fastcall BindingsSortOps(int AIdx1, int AIdx2, Lmdarrayutils::TLMDArrayOperation AOp);
	void __fastcall EnableButtons(void);
	void __fastcall StrToShortcuts(const Lmdtypes::TLMDString AStr, /* out */ System::Classes::TShortCut &ASc, /* out */ System::Classes::TShortCut &ASc2);
	Lmdtypes::TLMDString __fastcall ShortcutsToStr(System::Classes::TShortCut ASc, System::Classes::TShortCut ASc2);
	void __fastcall DeleteCurrentBinding(void);
	void __fastcall ClearCurrentBinding(void);
	void __fastcall UpdateNodeStatus(void);
	void __fastcall FillTree(void);
	void __fastcall SaveKeyBindings(void);
	System::Uitypes::TModalResult __fastcall ShowView(Lmdsedview::TLMDCustomEditView* AView);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSedKeyBindingsDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSedKeyBindingsDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSedKeyBindingsDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSedKeyBindingsDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDSedKeyBindingsDlg* LMDSedMappingsDlg;
extern DELPHI_PACKAGE bool __fastcall LMDEditExecKeyBindingsDialog(Lmdsedview::TLMDCustomEditView* AView);
}	/* namespace Lmdsedkeybindingsdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDKEYBINDINGSDIALOG)
using namespace Lmdsedkeybindingsdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedkeybindingsdialogHPP
