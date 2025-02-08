// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDPointListEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdpointlisteditordlgHPP
#define PlmdpointlisteditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDPointList.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomMaskEdit.hpp>
#include <LMDCustomExtSpinEdit.hpp>
#include <LMDSpinEdit.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDListBox.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdpointlisteditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmTLMDPointListEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmTLMDPointListEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdlistbox::TLMDListBox* plb;
	Lmdspinedit::TLMDSpinEdit* XVal;
	Lmdspinedit::TLMDSpinEdit* YVal;
	Lmdbutton::TLMDButton* LMDButton1;
	Lmdbutton::TLMDButton* LMDButton2;
	Lmdbutton::TLMDButton* LMDButton3;
	Lmdbutton::TLMDButton* LMDButton4;
	Lmdbutton::TLMDButton* LMDButton5;
	Lmdbutton::TLMDButton* LMDButton6;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall LMDButton1Click(System::TObject* Sender);
	void __fastcall LMDButton2Click(System::TObject* Sender);
	void __fastcall LMDButton5Click(System::TObject* Sender);
	void __fastcall LMDButton6Click(System::TObject* Sender);
	void __fastcall plbClick(System::TObject* Sender);
	void __fastcall XValExit(System::TObject* Sender);
	void __fastcall YValExit(System::TObject* Sender);
	
private:
	Lmdpointlist::TLMDPointList* FPointList;
	
public:
	void __fastcall SetPointList(Lmdpointlist::TLMDPointList* aValue);
	void __fastcall GetPointList(Lmdpointlist::TLMDPointList* aValue);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmTLMDPointListEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmTLMDPointListEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmTLMDPointListEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmTLMDPointListEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdpointlisteditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDPOINTLISTEDITORDLG)
using namespace Plmdpointlisteditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdpointlisteditordlgHPP
