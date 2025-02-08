// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintTemplateEditDlg.pas' rev: 31.00 (Windows)

#ifndef LmdprinttemplateeditdlgHPP
#define LmdprinttemplateeditdlgHPP

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
#include <Vcl.StdActns.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.ToolWin.hpp>
#include <LMDPrinter.hpp>
#include <LMDTypes.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprinttemplateeditdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTemplateEditDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTemplateEditDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TRichEdit* RichEdit;
	Vcl::Comctrls::TToolBar* ToolBar1;
	Vcl::Actnlist::TActionList* ActionList1;
	Vcl::Comctrls::TToolButton* ToolButton1;
	Vcl::Comctrls::TToolButton* ToolButton2;
	Vcl::Comctrls::TToolButton* ToolButton3;
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Comctrls::TToolButton* ToolButton4;
	Vcl::Comctrls::TToolButton* btnBold;
	Vcl::Actnlist::TAction* actUndo;
	Vcl::Comctrls::TToolButton* btnItalic;
	Vcl::Comctrls::TToolButton* ToolButton7;
	Vcl::Actnlist::TAction* actFileOpen;
	Vcl::Actnlist::TAction* actFileSaveAs;
	Vcl::Actnlist::TAction* actBold;
	Vcl::Actnlist::TAction* actItalic;
	Vcl::Actnlist::TAction* actUnderline;
	Vcl::Comctrls::TToolButton* btnUndeline;
	Vcl::Comctrls::TToolButton* ToolButton9;
	Vcl::Actnlist::TAction* actAlignLeft;
	Vcl::Actnlist::TAction* actAlignCenter;
	Vcl::Actnlist::TAction* actAlignRight;
	Vcl::Comctrls::TToolButton* btnLeft;
	Vcl::Comctrls::TToolButton* btnCenter;
	Vcl::Comctrls::TToolButton* btnRight;
	Vcl::Comctrls::TToolButton* ToolButton13;
	Vcl::Comctrls::TToolButton* btnFont;
	Vcl::Actnlist::TAction* actFontEdit;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Dialogs::TFontDialog* FontDialog;
	Vcl::Comctrls::TToolButton* ToolButton15;
	Vcl::Menus::TPopupMenu* TemplatesPopup;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* btnOk;
	Vcl::Stdctrls::TButton* btnCancel;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall actRichUpdate(System::TObject* Sender);
	void __fastcall actUndoExecute(System::TObject* Sender);
	void __fastcall actFileOpenExecute(System::TObject* Sender);
	void __fastcall actFileSaveAsExecute(System::TObject* Sender);
	void __fastcall actBoldExecute(System::TObject* Sender);
	void __fastcall actItalicExecute(System::TObject* Sender);
	void __fastcall actUnderlineExecute(System::TObject* Sender);
	void __fastcall actAlignLeftExecute(System::TObject* Sender);
	void __fastcall actAlignCenterExecute(System::TObject* Sender);
	void __fastcall actAlignRightExecute(System::TObject* Sender);
	void __fastcall actFontEditExecute(System::TObject* Sender);
	void __fastcall RichEditSelectionChange(System::TObject* Sender);
	void __fastcall RichEditKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	
private:
	void __fastcall TemplOnClick(System::TObject* Sender);
	void __fastcall UpdateStatus(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDTemplateEditDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDTemplateEditDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDTemplateEditDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTemplateEditDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDTemplateEditDialog* LMDTemplateEditDialog;
extern DELPHI_PACKAGE bool __fastcall LMDPrintExecTemplateDlg(Lmdtypes::TLMDString ACaption, System::Classes::TStrings* ATemplateLines);
}	/* namespace Lmdprinttemplateeditdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTTEMPLATEEDITDLG)
using namespace Lmdprinttemplateeditdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprinttemplateeditdlgHPP
