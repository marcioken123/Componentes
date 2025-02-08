// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCapPropDlg.pas' rev: 31.00 (Windows)

#ifndef ElcappropdlgHPP
#define ElcappropdlgHPP

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
#include <System.TypInfo.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDTypes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <ElIni.hpp>
#include <ElFrmPers.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <Vcl.Buttons.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcappropdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCapPropDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElCapPropDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* OkButton;
	Vcl::Stdctrls::TButton* CancelButton;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* LineCounter;
	Eledits::TElEdit* Memo;
	Vcl::Buttons::TSpeedButton* Load;
	Vcl::Buttons::TSpeedButton* Save;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	void __fastcall MemoChange(System::TObject* Sender);
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
	
private:
	Lmdtypes::TLMDString __fastcall GetValue(void);
	void __fastcall SetValue(const Lmdtypes::TLMDString Value);
	
public:
	__property Lmdtypes::TLMDString Value = {read=GetValue, write=SetValue};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TElCapPropDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElCapPropDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElCapPropDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElCapPropDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TElCapPropDialog* ElCapPropDialog;
}	/* namespace Elcappropdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCAPPROPDLG)
using namespace Elcappropdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcappropdlgHPP
