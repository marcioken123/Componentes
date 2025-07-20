// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeJavascriptEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeejavascripteditorHPP
#define Vcltee_TeejavascripteditorHPP

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
#include <VCLTee.TeeJavaScript.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teejavascripteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeJScriptOptions;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTeeJScriptOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBFullPage;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* ECanvas;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TComboBox* CBPath;
	Vcl::Stdctrls::TCheckBox* CBMinify;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
private:
	Vcltee::Teejavascript::TJavascriptExportFormat* IFormat;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTeeJScriptOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTeeJScriptOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTeeJScriptOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTeeJScriptOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teejavascripteditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEJAVASCRIPTEDITOR)
using namespace Vcltee::Teejavascripteditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeejavascripteditorHPP
