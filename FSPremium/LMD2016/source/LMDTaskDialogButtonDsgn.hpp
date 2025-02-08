// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTaskDialogButtonDsgn.pas' rev: 31.00 (Windows)

#ifndef LmdtaskdialogbuttondsgnHPP
#define LmdtaskdialogbuttondsgnHPP

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

//-- user supplied -----------------------------------------------------------

namespace Lmdtaskdialogbuttondsgn
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmButtonDesigner;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmButtonDesigner : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TUpDown* updId;
	Vcl::Stdctrls::TEdit* edtButtonID;
	Vcl::Stdctrls::TMemo* edtNote;
	Vcl::Stdctrls::TEdit* edtButtonCaption;
	Vcl::Stdctrls::TLabel* lblNote;
	void __fastcall edtButtonIDKeyPress(System::TObject* Sender, System::WideChar &Key);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmButtonDesigner(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmButtonDesigner(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmButtonDesigner(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmButtonDesigner(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtaskdialogbuttondsgn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTASKDIALOGBUTTONDSGN)
using namespace Lmdtaskdialogbuttondsgn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtaskdialogbuttondsgnHPP
