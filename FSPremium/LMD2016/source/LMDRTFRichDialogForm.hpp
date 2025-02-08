// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFRichDialogForm.pas' rev: 31.00 (Windows)

#ifndef LmdrtfrichdialogformHPP
#define LmdrtfrichdialogformHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <LMDRTFActions.hpp>
#include <LMDRTFRichEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfrichdialogform
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichDialogForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichDialogForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Menus::TMainMenu* MainMenu;
	Vcl::Menus::TMenuItem* File1;
	Vcl::Menus::TMenuItem* New1;
	Vcl::Controls::TImageList* ImageList;
	Vcl::Actnlist::TActionList* alToolbar;
	Vcl::Comctrls::TToolBar* Toolbar;
	Vcl::Comctrls::TToolButton* btnNew1;
	Lmdrtfactions::TLMDRichEditNew* actNew;
	Vcl::Comctrls::TToolButton* btnLoad1;
	Lmdrtfactions::TLMDRichEditLoad* actLoad;
	Vcl::Comctrls::TToolButton* btnSave1;
	Lmdrtfactions::TLMDRichEditSave* actSave;
	Vcl::Comctrls::TToolButton* Separator1;
	Vcl::Comctrls::TToolButton* btnPrint1;
	Lmdrtfactions::TLMDRichEditPrint* actPrint;
	Vcl::Comctrls::TToolButton* btnPreview1;
	Lmdrtfactions::TLMDRichEditPreview* actPreview;
	Vcl::Comctrls::TToolButton* Separator2;
	Vcl::Comctrls::TToolButton* btnFind1;
	Lmdrtfactions::TLMDRichEditFind* actFind;
	Vcl::Comctrls::TToolButton* Separator3;
	Vcl::Comctrls::TToolButton* btnCut1;
	Lmdrtfactions::TLMDRichEditCut* actCut;
	Vcl::Comctrls::TToolButton* btnCopy1;
	Lmdrtfactions::TLMDRichEditCopy* actCopy;
	Vcl::Comctrls::TToolButton* btnPaste1;
	Lmdrtfactions::TLMDRichEditPaste* actPaste;
	Vcl::Comctrls::TToolButton* Separator4;
	Vcl::Comctrls::TToolButton* btnUndo1;
	Lmdrtfactions::TLMDRichEditUndo* actUndo;
	Vcl::Comctrls::TToolButton* btnRedo1;
	Lmdrtfactions::TLMDRichEditRedo* actRedo;
	Vcl::Comctrls::TToolButton* Separator5;
	Vcl::Comctrls::TToolButton* btnTextAttributes1;
	Lmdrtfactions::TLMDRichEditTextAttributes* actTextAttributes;
	Vcl::Comctrls::TToolButton* Separator6;
	Vcl::Comctrls::TToolButton* btnTextBold1;
	Lmdrtfactions::TLMDRichEditTextBold* actTextBold;
	Vcl::Comctrls::TToolButton* btnTextItalic1;
	Lmdrtfactions::TLMDRichEditTextItalic* actTextItalic;
	Vcl::Comctrls::TToolButton* btnTextUnderline1;
	Lmdrtfactions::TLMDRichEditTextUnderline* actTextUnderline;
	Vcl::Comctrls::TToolButton* Separator7;
	Vcl::Comctrls::TToolButton* btnTextSubscript1;
	Lmdrtfactions::TLMDRichEditTextSubscript* actTextSubscript;
	Vcl::Comctrls::TToolButton* btnTextSuperscript1;
	Lmdrtfactions::TLMDRichEditTextSuperscript* actTextSuperscript;
	Vcl::Comctrls::TToolButton* Separator8;
	Vcl::Comctrls::TToolButton* btnParaAlign1;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign1;
	Vcl::Comctrls::TToolButton* btnParaAlign2;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign2;
	Vcl::Comctrls::TToolButton* btnParaAlign3;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign3;
	Vcl::Comctrls::TToolButton* Separator9;
	Vcl::Comctrls::TToolButton* btnNumbering1;
	Lmdrtfactions::TLMDRichEditNumbering* actNumbering1;
	Vcl::Comctrls::TToolButton* btnNumbering2;
	Lmdrtfactions::TLMDRichEditNumbering* actNumbering2;
	Vcl::Comctrls::TToolButton* btnIndent1;
	Lmdrtfactions::TLMDRichEditIndent* actIndent;
	Vcl::Comctrls::TToolButton* btnUnindent1;
	Lmdrtfactions::TLMDRichEditUnindent* actUnindent;
	Vcl::Menus::TMenuItem* Openafile1;
	Vcl::Menus::TMenuItem* Save1;
	Vcl::Menus::TMenuItem* N1;
	Vcl::Menus::TMenuItem* Print1;
	Vcl::Menus::TMenuItem* Preview1;
	Vcl::Menus::TMenuItem* Edit1;
	Vcl::Menus::TMenuItem* Find1;
	Vcl::Menus::TMenuItem* Cut1;
	Vcl::Menus::TMenuItem* Copy1;
	Vcl::Menus::TMenuItem* Paste1;
	Vcl::Menus::TMenuItem* N2;
	Vcl::Menus::TMenuItem* Undo1;
	Vcl::Menus::TMenuItem* Redo1;
	Vcl::Menus::TMenuItem* N3;
	Vcl::Menus::TMenuItem* Format1;
	Vcl::Menus::TMenuItem* Font1;
	Vcl::Menus::TMenuItem* Numbering1;
	Vcl::Comctrls::TStatusBar* StatusBar;
	Lmdrtfrichedit::TLMDRichEdit* LMDRichEdit;
	Vcl::Menus::TMenuItem* Paragraph1;
	Lmdrtfactions::TLMDRichEditParagraph* actParagraph;
	void __fastcall LMDRichEditSelectionChange(System::TObject* Sender);
	
private:
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRichDialogForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRichDialogForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRichDialogForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichDialogForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDRichDialogForm* LMDRichDialogForm;
}	/* namespace Lmdrtfrichdialogform */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFRICHDIALOGFORM)
using namespace Lmdrtfrichdialogform;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfrichdialogformHPP
