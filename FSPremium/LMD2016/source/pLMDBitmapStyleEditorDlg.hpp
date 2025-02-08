// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDBitmapStyleEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdbitmapstyleeditordlgHPP
#define PlmdbitmapstyleeditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseImage.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDNImage.hpp>
#include <LMDCustomNImage.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDBaseControl.hpp>
#include <LMDComboBox.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDCustomComboBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbitmapstyleeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBitmapStyleEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBitmapStyleEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* Label4;
	Lmdcombobox::TLMDComboBox* pred;
	Lmdnimage::TLMDNImage* test;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* cancel;
	void __fastcall predChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDBitmapStyleEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDBitmapStyleEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDBitmapStyleEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBitmapStyleEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdbitmapstyleeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBITMAPSTYLEEDITORDLG)
using namespace Plmdbitmapstyleeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbitmapstyleeditordlgHPP
