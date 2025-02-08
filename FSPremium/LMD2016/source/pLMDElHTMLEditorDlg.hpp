// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElHTMLEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdelhtmleditordlgHPP
#define PlmdelhtmleditordlgHPP

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
#include <Vcl.Menus.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElListBox.hpp>
#include <HTMLLbx.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.ImgList.hpp>
#include <ElEdits.hpp>
#include <ElIni.hpp>
#include <ElHTMLView.hpp>
#include <Vcl.ComCtrls.hpp>
#include <ElBtnEdit.hpp>
#include <ElNameEdits.hpp>
#include <ElShellUtils.hpp>
#include <ElComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelhtmleditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDElHTMLEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDElHTMLEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Dialogs::TOpenDialog* openDialog;
	Vcl::Comctrls::TPageControl* tabs;
	Vcl::Comctrls::TTabSheet* editor;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* options;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Dialogs::TColorDialog* colordlg;
	Vcl::Controls::TImageList* ImageList1;
	Elpopbtn::TElPopupButton* btnOk;
	Elpopbtn::TElPopupButton* ElPopupButton1;
	Elpopbtn::TElPopupButton* btnOpen;
	Elpopbtn::TElPopupButton* btnSave;
	Elpopbtn::TElPopupButton* btnCut;
	Elpopbtn::TElPopupButton* btnCopy;
	Elpopbtn::TElPopupButton* btnPaste;
	Elpopbtn::TElPopupButton* btnFontColor;
	Elpopbtn::TElPopupButton* btnEditor;
	Htmllbx::TElHTMLListBox* taglb;
	Eledits::TElMemo* HTMLEdit;
	Elini::TElIniFile* ini;
	Elhtmlview::TElHTMLView* preview;
	Elnameedits::TElFileNameEdit* fedit;
	Vcl::Stdctrls::TLabel* Label1;
	void __fastcall TabSheet2Show(System::TObject* Sender);
	void __fastcall taglbDblClick(System::TObject* Sender);
	void __fastcall btnOpenClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall btnCutClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	void __fastcall btnPasteClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall btnEditorClick(System::TObject* Sender);
	void __fastcall btnFontColorClick(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDElHTMLEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDElHTMLEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDElHTMLEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDElHTMLEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmLMDElHTMLEditor* frmTLMDElHTMLEditor;
extern DELPHI_PACKAGE System::UnicodeString IDS_ROOT;
}	/* namespace Plmdelhtmleditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELHTMLEDITORDLG)
using namespace Plmdelhtmleditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelhtmleditordlgHPP
