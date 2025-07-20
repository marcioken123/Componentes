// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeException.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeexceptionHPP
#define Vcltee_TeeexceptionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeexception
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeExceptionForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeExceptionForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* LabelServer;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* Email;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TMemo* MemoComments;
	Vcl::Extctrls::TPanel* PanelMain;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* LabelError;
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Label4Click(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
public:
	System::UnicodeString TheCode;
	System::Sysutils::Exception* TheException;
	__classmethod System::UnicodeString __fastcall IDE();
	__classmethod System::UnicodeString __fastcall License();
	__classmethod System::UnicodeString __fastcall Product();
	__classmethod System::UnicodeString __fastcall SubProduct();
	__classmethod void __fastcall Send(const System::UnicodeString Code, System::Sysutils::Exception* E);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeExceptionForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeExceptionForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeExceptionForm() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeExceptionForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeexception */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEXCEPTION)
using namespace Vcltee::Teeexception;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeexceptionHPP
