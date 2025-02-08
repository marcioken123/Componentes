// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDLightEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdlighteditordlgHPP
#define PlmdlighteditordlgHPP

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
#include <LMDCustomComponent.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDCustomLight.hpp>
#include <LMDLight.hpp>
#include <LMDGraph.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdlighteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLightEditorDlg;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 7> Plmdlighteditordlg__1;

class PASCALIMPLEMENTATION TLMDLightEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Lmdlight::TLMDLight* test;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TComboBox* pred;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall predChange(System::TObject* Sender);
	void __fastcall testClick(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDLightEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDLightEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDLightEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDLightEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Plmdlighteditordlg__1 LMDLightColorStr;
}	/* namespace Plmdlighteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDLIGHTEDITORDLG)
using namespace Plmdlighteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdlighteditordlgHPP
