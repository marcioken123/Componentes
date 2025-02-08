// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDRTFHyperTextEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdrtfhypertexteditorHPP
#define PlmdrtfhypertexteditorHPP

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
#include <Vcl.ActnList.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDRTFActions.hpp>
#include <LMDRTFHyperText.hpp>
#include <LMDRTFRichEdit.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdrtfhypertexteditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDRTFHyperTextEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDRTFHyperTextEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdrtfrichedit::TLMDRichEdit* LMDRichEdit;
	Vcl::Comctrls::TStatusBar* StatusBar1;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Actnlist::TActionList* alToolbar1;
	Vcl::Comctrls::TToolBar* Toolbar1;
	Vcl::Comctrls::TToolButton* btnNew1;
	Lmdrtfactions::TLMDRichEditNew* actNew1;
	Vcl::Comctrls::TToolButton* btnLoad1;
	Lmdrtfactions::TLMDRichEditLoad* actLoad1;
	Vcl::Comctrls::TToolButton* btnSave1;
	Lmdrtfactions::TLMDRichEditSave* actSave1;
	Vcl::Comctrls::TToolButton* Separator1;
	Vcl::Comctrls::TToolButton* btnPrint1;
	Lmdrtfactions::TLMDRichEditPrint* actPrint1;
	Vcl::Comctrls::TToolButton* btnPreview1;
	Lmdrtfactions::TLMDRichEditPreview* actPreview1;
	Vcl::Comctrls::TToolButton* Separator2;
	Vcl::Comctrls::TToolButton* btnFind1;
	Lmdrtfactions::TLMDRichEditFind* actFind1;
	Vcl::Comctrls::TToolButton* Separator3;
	Vcl::Comctrls::TToolButton* btnCut1;
	Lmdrtfactions::TLMDRichEditCut* actCut1;
	Vcl::Comctrls::TToolButton* btnCopy1;
	Lmdrtfactions::TLMDRichEditCopy* actCopy1;
	Vcl::Comctrls::TToolButton* btnPaste1;
	Lmdrtfactions::TLMDRichEditPaste* actPaste1;
	Vcl::Comctrls::TToolButton* Separator4;
	Vcl::Comctrls::TToolButton* btnUndo1;
	Lmdrtfactions::TLMDRichEditUndo* actUndo1;
	Vcl::Comctrls::TToolButton* btnRedo1;
	Lmdrtfactions::TLMDRichEditRedo* actRedo1;
	Vcl::Comctrls::TToolButton* Separator5;
	Vcl::Comctrls::TToolButton* btnTextAttributes1;
	Lmdrtfactions::TLMDRichEditTextAttributes* actTextAttributes1;
	Vcl::Comctrls::TToolButton* Separator6;
	Vcl::Comctrls::TToolButton* btnTextBold1;
	Lmdrtfactions::TLMDRichEditTextBold* actTextBold1;
	Vcl::Comctrls::TToolButton* btnTextItalic1;
	Lmdrtfactions::TLMDRichEditTextItalic* actTextItalic1;
	Vcl::Comctrls::TToolButton* btnTextUnderline1;
	Lmdrtfactions::TLMDRichEditTextUnderline* actTextUnderline1;
	Vcl::Comctrls::TToolButton* Separator7;
	Vcl::Comctrls::TToolButton* btnTextSubscript1;
	Lmdrtfactions::TLMDRichEditTextSubscript* actTextSubscript1;
	Vcl::Comctrls::TToolButton* btnTextSuperscript1;
	Lmdrtfactions::TLMDRichEditTextSuperscript* actTextSuperscript1;
	Vcl::Comctrls::TToolButton* Separator8;
	Vcl::Comctrls::TToolButton* btnParaAlign1;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign1;
	Vcl::Comctrls::TToolButton* btnParaAlign2;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign2;
	Vcl::Comctrls::TToolButton* btnParaAlign3;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign3;
	Lmdrtfactions::TLMDRichEditParaAlign* actParaAlign4;
	Vcl::Comctrls::TToolButton* Separator9;
	Vcl::Comctrls::TToolButton* btnNumbering1;
	Lmdrtfactions::TLMDRichEditNumbering* actNumbering1;
	Vcl::Comctrls::TToolButton* btnNumbering2;
	Lmdrtfactions::TLMDRichEditNumbering* actNumbering2;
	Vcl::Comctrls::TToolButton* btnIndent1;
	Lmdrtfactions::TLMDRichEditIndent* actIndent1;
	Vcl::Comctrls::TToolButton* btnUnindent1;
	Lmdrtfactions::TLMDRichEditUnindent* actUnindent1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCodeEditor;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Actnlist::TAction* actBookMarks;
	Vcl::Actnlist::TAction* actHyperText;
	void __fastcall LMDRichEditSelectionChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall actBookMarksExecute(System::TObject* Sender);
	void __fastcall actHyperTextExecute(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall LMDRichEditURLClick(System::TObject* Sender, const System::UnicodeString URLText, System::Uitypes::TMouseButton Button);
	
private:
	Lmdrtfhypertext::TLMDRichHyperText* FHyperText;
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Msg);
	void __fastcall CheckButtons(void);
	void __fastcall LinkMouseMove(System::TObject* Sender, const System::UnicodeString URLText, bool IsLink);
	
public:
	__fastcall virtual TfrmLMDRTFHyperTextEditor(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TfrmLMDRTFHyperTextEditor(void);
	void __fastcall MarkLinks(void);
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDRTFHyperTextEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDRTFHyperTextEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdrtfhypertexteditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDRTFHYPERTEXTEDITOR)
using namespace Plmdrtfhypertexteditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdrtfhypertexteditorHPP
