// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedSchemeEditDialog.pas' rev: 31.00 (Windows)

#ifndef LmdsedschemeeditdialogHPP
#define LmdsedschemeeditdialogHPP

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
#include <LMDTypes.hpp>
#include <LMDSedUtils.hpp>
#include <LMDSedView.hpp>
#include <LMDSedDocument.hpp>
#include <LMDStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedschemeeditdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSedSchemeEditDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSedSchemeEditDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdseddocument::TLMDEditDocument* Doc;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Lmdsedview::TLMDEditView* LMDEditView1;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	Vcl::Dialogs::TSaveDialog* SaveDialog1;
	void __fastcall LMDSedView1KeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSedSchemeEditDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSedSchemeEditDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSedSchemeEditDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSedSchemeEditDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TLMDEditSchemeEditKind : unsigned char { skSyntax, skColor };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDEditExecSchemeXMLDialog(System::Classes::TStrings* AScheme, TLMDEditSchemeEditKind AKind);
}	/* namespace Lmdsedschemeeditdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDSCHEMEEDITDIALOG)
using namespace Lmdsedschemeeditdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedschemeeditdialogHPP
