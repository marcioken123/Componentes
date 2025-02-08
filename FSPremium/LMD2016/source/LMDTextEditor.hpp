// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextEditor.pas' rev: 31.00 (Windows)

#ifndef LmdtexteditorHPP
#define LmdtexteditorHPP

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
#include <Vcl.ImgList.hpp>
#include <Vcl.Menus.hpp>
#include <LMDClass.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDTxtPrinter.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDFormStyler.hpp>
#include <LMDCustomImageList.hpp>
#include <LMDImageList.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomButton.hpp>
#include <LMDButton.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDInformationLabel.hpp>
#include <LMDCustomStatusBar.hpp>
#include <LMDStatusBar.hpp>
#include <LMDBaseEdit.hpp>
#include <LMDCustomMemo.hpp>
#include <LMDMemo.hpp>
#include <LMDControl.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDPanelFill.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtexteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFrmTextEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFrmTextEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdpanelfill::TLMDPanelFill* b;
	Lmdmemo::TLMDMemo* Memo;
	Lmdstatusbar::TLMDStatusBar* StatusBar;
	Lmdimagelist::TLMDImageList* LMDImageList1;
	Vcl::Dialogs::TFontDialog* FontDialog;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Lmdformstyler::TLMDFormStyler* fs;
	Vcl::Dialogs::TFindDialog* FindDialog;
	Vcl::Dialogs::TReplaceDialog* ReplaceDialog;
	Lmdinformationlabel::TLMDInformationLabel* LMDInformationLabel1;
	Lmdinformationlabel::TLMDInformationLabel* LMDInformationLabel2;
	Vcl::Dialogs::TPrintDialog* PrintDialog;
	Vcl::Menus::TMainMenu* mainmenu;
	Lmdtxtprinter::TLMDTxtPrinter* LMDTxtPrinter;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* Open1;
	Vcl::Menus::TMenuItem* Save1;
	Vcl::Menus::TMenuItem* Clear1;
	Vcl::Menus::TMenuItem* Print1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Close1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Selectall1;
	Vcl::Menus::TMenuItem* Undo1;
	Vcl::Menus::TMenuItem* Redo1;
	Vcl::Menus::TMenuItem* Search2;
	Vcl::Menus::TMenuItem* Replace1;
	Vcl::Menus::TMenuItem* Options1;
	Vcl::Menus::TMenuItem* Font1;
	Vcl::Menus::TMenuItem* Lined1;
	Vcl::Menus::TMenuItem* Wordwrap1;
	Vcl::Menus::TMenuItem* Statistics1;
	Lmdpanelfill::TLMDPanelFill* toolBar;
	Lmdspeedbutton::TLMDSpeedButton* open;
	Lmdspeedbutton::TLMDSpeedButton* save;
	Lmdspeedbutton::TLMDSpeedButton* clear;
	Lmdspeedbutton::TLMDSpeedButton* print;
	Lmdspeedbutton::TLMDSpeedButton* fontbtn;
	Lmdspeedbutton::TLMDSpeedButton* lines;
	Lmdspeedbutton::TLMDSpeedButton* WordWrap;
	Lmdspeedbutton::TLMDSpeedButton* alignLeft;
	Lmdspeedbutton::TLMDSpeedButton* alignCenter;
	Lmdspeedbutton::TLMDSpeedButton* alignRight;
	Lmdspeedbutton::TLMDSpeedButton* statistics;
	Lmdspeedbutton::TLMDSpeedButton* cut;
	Lmdspeedbutton::TLMDSpeedButton* paste;
	Lmdspeedbutton::TLMDSpeedButton* copy;
	Lmdspeedbutton::TLMDSpeedButton* selectall;
	Lmdspeedbutton::TLMDSpeedButton* redo;
	Lmdspeedbutton::TLMDSpeedButton* undo;
	Lmdspeedbutton::TLMDSpeedButton* search;
	Lmdspeedbutton::TLMDSpeedButton* replace;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* N4;
	Lmdsimplepanel::TLMDSimplePanel* pnlBottom;
	Lmdbutton::TLMDButton* btnOk;
	Lmdbutton::TLMDButton* btnCancel;
	Lmdbutton::TLMDButton* btnCustom;
	Vcl::Menus::TMenuItem* N5;
	Vcl::Menus::TMenuItem* N6;
	void __fastcall linesClick(System::TObject* Sender);
	void __fastcall redoClick(System::TObject* Sender);
	void __fastcall undoClick(System::TObject* Sender);
	void __fastcall copyClick(System::TObject* Sender);
	void __fastcall pasteClick(System::TObject* Sender);
	void __fastcall cutClick(System::TObject* Sender);
	void __fastcall alignLeftClick(System::TObject* Sender);
	void __fastcall WordWrapClick(System::TObject* Sender);
	void __fastcall selectallClick(System::TObject* Sender);
	void __fastcall fontbtnClick(System::TObject* Sender);
	void __fastcall clearClick(System::TObject* Sender);
	void __fastcall openClick(System::TObject* Sender);
	void __fastcall saveClick(System::TObject* Sender);
	void __fastcall MemoCursorPosChanged(System::TObject* Sender);
	void __fastcall MemoCurrentRowChanged(System::TObject* Sender);
	void __fastcall searchClick(System::TObject* Sender);
	void __fastcall FindDialogFind(System::TObject* Sender);
	void __fastcall statisticsClick(System::TObject* Sender);
	void __fastcall replaceClick(System::TObject* Sender);
	void __fastcall ReplaceDialogFind(System::TObject* Sender);
	void __fastcall MemoKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall printClick(System::TObject* Sender);
	void __fastcall Close1Click(System::TObject* Sender);
	
public:
	System::UnicodeString Filename;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFrmTextEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFrmTextEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFrmTextEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFrmTextEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtexteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTEDITOR)
using namespace Lmdtexteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtexteditorHPP
