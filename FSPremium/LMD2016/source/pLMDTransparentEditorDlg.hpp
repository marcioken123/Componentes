// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDTransparentEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdtransparenteditordlgHPP
#define PlmdtransparenteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Consts.hpp>
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
#include <LMDCont.hpp>
#include <LMDCustomColorComboBox.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDBaseImage.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDDrawEdge.hpp>
#include <LMDFill.hpp>
#include <LMDSimpleLabel.hpp>
#include <LMDCustomNImage.hpp>
#include <LMDDockSpeedButton.hpp>
#include <LMDNImage.hpp>
#include <LMDColorComboBox.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomComboBox.hpp>
#include <LMDStringList.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDThemedComboBox.hpp>
#include <LMDBaseControl.hpp>
#include <LMDThemes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdtransparenteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTransparentEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTransparentEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TLabel* Label5;
	Lmdcolorcombobox::TLMDColorComboBox* cmbc;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TComboBox* cmb;
	Lmddrawedge::TLMDDrawEdge* LMDDrawEdge1;
	Lmdsimplelabel::TLMDSimpleLabel* lbl;
	Lmdfill::TLMDFill* LMDFill1;
	Lmdnimage::TLMDNImage* test;
	Lmddockspeedbutton::TLMDDockSpeedButton* dlgl;
	Lmdstringlist::TLMDStringList* strl;
	Vcl::Stdctrls::TButton* ok;
	Vcl::Stdctrls::TButton* Button1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall cmbcChange(System::TObject* Sender);
	void __fastcall dlglClick(System::TObject* Sender);
	void __fastcall FormClose(System::TObject* Sender, System::Uitypes::TCloseAction &Action);
	void __fastcall FormActivate(System::TObject* Sender);
	void __fastcall cmbChange(System::TObject* Sender);
	
private:
	bool FShow;
	
public:
	void __fastcall SetLabels(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDTransparentEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDTransparentEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDTransparentEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTransparentEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdtransparenteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDTRANSPARENTEDITORDLG)
using namespace Plmdtransparenteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdtransparenteditordlgHPP
