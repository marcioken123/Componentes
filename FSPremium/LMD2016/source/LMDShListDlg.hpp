// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShListDlg.pas' rev: 31.00 (Windows)

#ifndef LmdshlistdlgHPP
#define LmdshlistdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.CheckLst.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.ShlObj.hpp>
#include <LMDShBase.hpp>
#include <LMDShList.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshlistdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellListDialog;
class DELPHICLASS TLMDShellfrmListDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShellListDialog : public Lmdshbase::TLMDShellBaseDialog
{
	typedef Lmdshbase::TLMDShellBaseDialog inherited;
	
private:
	Lmdshlist::TLMDShellList* FShellList;
	TLMDShellfrmListDialog* FDialog;
	System::UnicodeString FCaption;
	void __fastcall SetShellList(Lmdshlist::TLMDShellList* aValue);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDShellListDialog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellListDialog(void);
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0));
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Lmdshlist::TLMDShellList* ShellList = {read=FShellList, write=SetShellList};
};


class PASCALIMPLEMENTATION TLMDShellfrmListDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* lblInstruction;
	Vcl::Stdctrls::TLabel* lblwidth;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Checklst::TCheckListBox* lb;
	Vcl::Stdctrls::TCheckBox* chk;
	Vcl::Stdctrls::TButton* btnUp;
	Vcl::Stdctrls::TButton* btnDown;
	Vcl::Stdctrls::TButton* btnDisplay;
	Vcl::Stdctrls::TButton* btnHide;
	Vcl::Stdctrls::TEdit* edWidth;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall edWidthKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall btnClick(System::TObject* Sender);
	void __fastcall lbClick(System::TObject* Sender);
	void __fastcall edWidthExit(System::TObject* Sender);
	void __fastcall lbClickCheck(System::TObject* Sender);
	
private:
	TLMDShellListDialog* FComponent;
	System::Classes::TStrings* fItems;
	void __fastcall UpdateListbox(void);
	void __fastcall UpdateStates(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDShellfrmListDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDShellfrmListDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDShellfrmListDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShellfrmListDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshlistdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHLISTDLG)
using namespace Lmdshlistdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshlistdlgHPP
