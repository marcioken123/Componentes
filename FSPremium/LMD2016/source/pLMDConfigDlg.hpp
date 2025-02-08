// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDConfigDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdconfigdlgHPP
#define PlmdconfigdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.CheckLst.hpp>
#include <pLMDURLLabel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdconfigdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDConfigDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDConfigDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* pnlBottom;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TPanel* pnlLeft;
	Vcl::Comctrls::TTreeView* tvCategories;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TNotebook* nb;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Checklst::TCheckListBox* globalbox;
	Vcl::Stdctrls::TLabel* lblLMDSettings;
	Vcl::Checklst::TCheckListBox* LMDBox;
	Vcl::Stdctrls::TLabel* lblquestion;
	Plmdurllabel::TLMDURLLabel* lblsupport;
	Vcl::Stdctrls::TLabel* lblsite;
	Plmdurllabel::TLMDURLLabel* lmdurl1;
	Vcl::Stdctrls::TLabel* lblnews;
	Plmdurllabel::TLMDURLLabel* lmdurl2;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* lblPageTitle;
	Vcl::Stdctrls::TLabel* lblversion;
	Vcl::Stdctrls::TLabel* lblversionExt;
	Vcl::Stdctrls::TLabel* lbldesc;
	Vcl::Stdctrls::TLabel* lblcopyright;
	Vcl::Extctrls::TBevel* bv;
	Plmdurllabel::TLMDURLLabel* LMDSysURLLabel1;
	Vcl::Stdctrls::TLabel* lblComponent;
	Vcl::Stdctrls::TButton* btnReg;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* lblvnumber;
	Vcl::Stdctrls::TLabel* Label3;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnRegClick(System::TObject* Sender);
	void __fastcall nbPageChanged(System::TObject* Sender);
	void __fastcall tvCategoriesChange(System::TObject* Sender, Vcl::Comctrls::TTreeNode* Node);
	void __fastcall okClick(System::TObject* Sender);
	
private:
	System::UnicodeString FApp;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDConfigDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDConfigDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDConfigDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDConfigDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdconfigdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCONFIGDLG)
using namespace Plmdconfigdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdconfigdlgHPP
