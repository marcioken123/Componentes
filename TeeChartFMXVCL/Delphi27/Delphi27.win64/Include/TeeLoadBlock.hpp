// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeLoadBlock.pas' rev: 34.00 (Windows)

#ifndef TeeloadblockHPP
#define TeeloadblockHPP

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
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Teeloadblock
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLoadBlockDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLoadBlockDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TRadioButton* RBURL;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBURL;
	Vcl::Stdctrls::TRadioButton* RBFile;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBFile;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Extctrls::TPanel* PanelButtons;
	Vcl::Stdctrls::TButton* BOK;
	Vcl::Stdctrls::TButton* Button2;
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall RBFileClick(System::TObject* Sender);
	void __fastcall CBFileEnter(System::TObject* Sender);
	void __fastcall CBURLEnter(System::TObject* Sender);
	void __fastcall CBURLChange(System::TObject* Sender);
	void __fastcall RBURLClick(System::TObject* Sender);
	void __fastcall CBFileChange(System::TObject* Sender);
	
private:
	void __fastcall AddFile(const System::UnicodeString AFile);
	
public:
	System::UnicodeString __fastcall GetSelectedText();
	__classmethod bool __fastcall ModalShow(System::Classes::TComponent* AOwner, const System::UnicodeString DefaultFilter, const System::UnicodeString DefaultExtension, System::UnicodeString &AFileName);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLoadBlockDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLoadBlockDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLoadBlockDialog() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLoadBlockDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeloadblock */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEELOADBLOCK)
using namespace Teeloadblock;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeloadblockHPP
