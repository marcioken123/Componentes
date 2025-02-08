// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDHTMLEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdhtmleditordlgHPP
#define PlmdhtmleditordlgHPP

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
#include <LMDPopupMenu.hpp>
#include <LMDDrawEdge.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCont.hpp>
#include <LMDCustomEdit.hpp>
#include <LMDCustomBrowseEdit.hpp>
#include <LMDFileOpenEdit.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomSimpleLabel.hpp>
#include <LMDCustomDockLabel.hpp>
#include <LMDDockLabel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDTextCustomPanel.hpp>
#include <LMDTextScrollPanel.hpp>
#include <LMDCustomImageListBox.hpp>
#include <LMDTextListBox.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomMemo.hpp>
#include <LMDMemo.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDSpeedButton.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDCustomFileEdit.hpp>
#include <LMDCustomListBox.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDImageList.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDControl.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdhtmleditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmTLMDHTMLEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmTLMDHTMLEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Lmdbutton::TLMDButton* LMDButton1;
	Lmdbutton::TLMDButton* LMDButton2;
	Vcl::Dialogs::TOpenDialog* openDialog;
	Vcl::Comctrls::TPageControl* tabs;
	Vcl::Comctrls::TTabSheet* editor;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Lmdtextscrollpanel::TLMDTextScrollPanel* preview;
	Vcl::Comctrls::TTabSheet* options;
	Lmdfileopenedit::TLMDFileOpenEdit* fedit;
	Lmddocklabel::TLMDDockLabel* LMDDockLabel1;
	Lmdmemo::TLMDMemo* HTMLEDIT;
	Lmdtextlistbox::TLMDTextListBox* taglb;
	Lmdimagelist::TLMDImageList* LMDImageList1;
	Lmdspeedbutton::TLMDSpeedButton* btnOpen;
	Lmdspeedbutton::TLMDSpeedButton* btnSave;
	Lmdspeedbutton::TLMDSpeedButton* btnCut;
	Lmdspeedbutton::TLMDSpeedButton* btnCopy;
	Lmdspeedbutton::TLMDSpeedButton* btnPaste;
	Lmdspeedbutton::TLMDSpeedButton* btnEditor;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Lmdinictrl::TLMDIniCtrl* ini;
	Lmdspeedbutton::TLMDSpeedButton* LMDSpeedButton1;
	Vcl::Dialogs::TColorDialog* colordlg;
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
	void __fastcall LMDSpeedButton1Click(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmTLMDHTMLEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmTLMDHTMLEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmTLMDHTMLEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmTLMDHTMLEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmTLMDHTMLEditor* frmTLMDHTMLEditor;
}	/* namespace Plmdhtmleditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDHTMLEDITORDLG)
using namespace Plmdhtmleditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdhtmleditordlgHPP
