// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDControlFaceEditorDlgAddState.pas' rev: 31.00 (Windows)

#ifndef PlmdcontrolfaceeditordlgaddstateHPP
#define PlmdcontrolfaceeditordlgaddstateHPP

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
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDScrollBox.hpp>
#include <LMDSplt.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDCustomCheckListBox.hpp>
#include <LMDCheckListBox.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcontrolfaceeditordlgaddstate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmStateAddingDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmStateAddingDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdsplt::TLMDSplitterPanel* LMDSplitterPanel1;
	Lmdsplt::TLMDSplitterPane* LMDSplitterPane1;
	Lmdsplt::TLMDSplitterPane* LMDSplitterPane2;
	Vcl::Stdctrls::TButton* LMDButton1;
	Vcl::Stdctrls::TButton* LMDButton2;
	Vcl::Stdctrls::TButton* LMDButton3;
	Vcl::Stdctrls::TButton* LMDButton4;
	Lmdchecklistbox::TLMDCheckListBox* notUsedStates;
	void __fastcall LMDButton1Click(System::TObject* Sender);
	void __fastcall LMDButton2Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
public:
	void __fastcall init(System::Classes::TStringList* alreadyUsedStates);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmStateAddingDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmStateAddingDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmStateAddingDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmStateAddingDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmStateAddingDlg* frmStateAddingDlg;
}	/* namespace Plmdcontrolfaceeditordlgaddstate */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCONTROLFACEEDITORDLGADDSTATE)
using namespace Plmdcontrolfaceeditordlgaddstate;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcontrolfaceeditordlgaddstateHPP
