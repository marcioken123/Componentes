// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDRTFSyntaxDefEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdrtfsyntaxdefeditorHPP
#define PlmdrtfsyntaxdefeditorHPP

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
#include <Vcl.ActnList.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ToolWin.hpp>
#include <LMDRTFActions.hpp>
#include <LMDRTFRichEdit.hpp>
#include <LMDRTFSyntaxEdit.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdrtfsyntaxdefeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmSyntaxDefEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmSyntaxDefEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Controls::TImageList* ImageList1;
	Vcl::Actnlist::TActionList* alToolbar1;
	Vcl::Comctrls::TToolBar* Toolbar1;
	Vcl::Comctrls::TToolButton* btnLoad1;
	Lmdrtfactions::TLMDRichEditLoad* actLoad1;
	Vcl::Comctrls::TToolButton* btnSave1;
	Vcl::Comctrls::TToolButton* Separator1;
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
	Vcl::Comctrls::TToolButton* btnIndent1;
	Lmdrtfactions::TLMDRichEditIndent* actIndent1;
	Vcl::Comctrls::TToolButton* btnUnindent1;
	Lmdrtfactions::TLMDRichEditUnindent* actUnindent1;
	Lmdrtfactions::TLMDRichEditSaveAs* LMDRichEditSaveAs1;
	Lmdrtfsyntaxedit::TLMDRichSyntaxEdit* LMDSyntaxEdit1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	
private:
	HIDESBASE MESSAGE void __fastcall WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Msg);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmSyntaxDefEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmSyntaxDefEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmSyntaxDefEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmSyntaxDefEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdrtfsyntaxdefeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDRTFSYNTAXDEFEDITOR)
using namespace Plmdrtfsyntaxdefeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdrtfsyntaxdefeditorHPP
