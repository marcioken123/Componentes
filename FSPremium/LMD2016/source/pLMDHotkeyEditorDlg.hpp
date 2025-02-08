// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDHotkeyEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdhotkeyeditordlgHPP
#define PlmdhotkeyeditordlgHPP

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
#include <Vcl.ComCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdhotkeyeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDfrmHotkeyEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDfrmHotkeyEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* LMDGroupBox1;
	Vcl::Stdctrls::TLabel* LMDSimpleLabel1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Comctrls::THotKey* edHotkey;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDfrmHotkeyEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDfrmHotkeyEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDfrmHotkeyEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDfrmHotkeyEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdhotkeyeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDHOTKEYEDITORDLG)
using namespace Plmdhotkeyeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdhotkeyeditordlgHPP
