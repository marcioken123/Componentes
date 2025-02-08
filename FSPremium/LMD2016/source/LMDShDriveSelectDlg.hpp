// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShDriveSelectDlg.pas' rev: 31.00 (Windows)

#ifndef LmdshdriveselectdlgHPP
#define LmdshdriveselectdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDShDriveListBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshdriveselectdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShfrmSelectDriveDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDShfrmSelectDriveDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdshdrivelistbox::TLMDShellDriveListBox* lbdisk;
	Vcl::Stdctrls::TLabel* Instruction;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	void __fastcall lbdiskClick(System::TObject* Sender);
	void __fastcall lbdiskDblClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDShfrmSelectDriveDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDShfrmSelectDriveDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDShfrmSelectDriveDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDShfrmSelectDriveDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshdriveselectdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHDRIVESELECTDLG)
using namespace Lmdshdriveselectdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshdriveselectdlgHPP
