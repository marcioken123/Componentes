// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedGotoLineDialog.pas' rev: 31.00 (Windows)

#ifndef LmdsedgotolinedialogHPP
#define LmdsedgotolinedialogHPP

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
#include <Vcl.Mask.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDSedUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedgotolinedialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSedGotoLineDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSedGotoLineDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Extctrls::TPanel* Panel7;
	Vcl::Stdctrls::TLabel* lblCaption;
	Vcl::Mask::TMaskEdit* edtLine;
	Vcl::Extctrls::TPanel* Panel8;
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSedGotoLineDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSedGotoLineDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSedGotoLineDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSedGotoLineDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDEditAskGoToLine(int AMaxLine, /* out */ int &ResultLine);
}	/* namespace Lmdsedgotolinedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDGOTOLINEDIALOG)
using namespace Lmdsedgotolinedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedgotolinedialogHPP
