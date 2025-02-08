// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDGlyphTextLayoutEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdglyphtextlayouteditordlgHPP
#define PlmdglyphtextlayouteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Tabs.hpp>
#include <Vcl.TabNotBk.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>
#include <LMDShSpinEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdglyphtextlayouteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGlyphTextLayoutEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGlyphTextLayoutEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* cancel;
	Vcl::Stdctrls::TButton* reset;
	Lmdspeedbutton::TLMDSpeedButton* test;
	Vcl::Comctrls::TPageControl* nb;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label3;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel1;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel2;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel3;
	Lmdshspinedit::TLMDShSpinEdit* spc;
	Vcl::Stdctrls::TComboBox* cmb2;
	Vcl::Stdctrls::TComboBox* cmb;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel4;
	Lmdshspinedit::TLMDShSpinEdit* capX;
	Vcl::Stdctrls::TLabel* Label5;
	Lmdshspinedit::TLMDShSpinEdit* capY;
	Vcl::Stdctrls::TLabel* Label6;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel5;
	Lmdsimplelabel::TLMDSimpleLabel* LMDSimpleLabel6;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall edchange(System::TObject* Sender);
	void __fastcall resetClick(System::TObject* Sender);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDGlyphTextLayoutEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDGlyphTextLayoutEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDGlyphTextLayoutEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDGlyphTextLayoutEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdglyphtextlayouteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDGLYPHTEXTLAYOUTEDITORDLG)
using namespace Plmdglyphtextlayouteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdglyphtextlayouteditordlgHPP
