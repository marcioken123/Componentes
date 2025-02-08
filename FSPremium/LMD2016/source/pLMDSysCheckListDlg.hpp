// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDSysCheckListDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdsyschecklistdlgHPP
#define PlmdsyschecklistdlgHPP

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
#include <Vcl.StdCtrls.hpp>
#include <Vcl.CheckLst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdsyschecklistdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDSysOptionsEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDSysOptionsEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Checklst::TCheckListBox* lb;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* btnSelectAll;
	Vcl::Stdctrls::TButton* btnSelectNone;
	void __fastcall btnSelectAllClick(System::TObject* Sender);
	
public:
	void __fastcall SetValues(System::Classes::TCollection* aValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDSysOptionsEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDSysOptionsEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDSysOptionsEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDSysOptionsEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdsyschecklistdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSYSCHECKLISTDLG)
using namespace Plmdsyschecklistdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdsyschecklistdlgHPP
