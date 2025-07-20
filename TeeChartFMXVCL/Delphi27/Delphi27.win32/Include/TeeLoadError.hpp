// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'TeeLoadError.pas' rev: 34.00 (Windows)

#ifndef TeeloaderrorHPP
#define TeeloaderrorHPP

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

//-- user supplied -----------------------------------------------------------

namespace Teeloaderror
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAskLoadError;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAskLoadError : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TMemo* Memo1;
	
public:
	__classmethod bool __fastcall AskContinueLoad(System::Classes::TComponent* AOwner, const System::UnicodeString Error);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAskLoadError(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAskLoadError(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAskLoadError() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAskLoadError(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool GlobalContinueLoad;
}	/* namespace Teeloaderror */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_TEELOADERROR)
using namespace Teeloaderror;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// TeeloaderrorHPP
