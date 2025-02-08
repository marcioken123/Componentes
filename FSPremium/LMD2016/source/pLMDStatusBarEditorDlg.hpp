// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDStatusBarEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdstatusbareditordlgHPP
#define PlmdstatusbareditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdstatusbareditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStatusBarEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStatusBarEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TListBox* ListBox;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	void __fastcall ListBoxDblClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDStatusBarEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDStatusBarEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDStatusBarEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDStatusBarEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdstatusbareditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSTATUSBAREDITORDLG)
using namespace Plmdstatusbareditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdstatusbareditordlgHPP
