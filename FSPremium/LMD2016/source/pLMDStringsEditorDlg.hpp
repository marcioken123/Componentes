// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDStringsEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdstringseditordlgHPP
#define PlmdstringseditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.RTLConsts.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Printers.hpp>
#include <LMDClass.hpp>
#include <LMDCont.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseLabel.hpp>
#include <LMDCustomGlyphLabel.hpp>
#include <LMDCustomStatusBar.hpp>
#include <LMDCustomButton.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDCustomSpeedButton.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDInformationLabel.hpp>
#include <LMDStatusBar.hpp>
#include <pLMDCPGetCore.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDSimplePanel.hpp>
#include <LMDSpeedButton.hpp>
#include <LMDGlyphLabel.hpp>
#include <LMDButton.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomControl.hpp>
#include <LMDImageList.hpp>
#include <LMDBaseController.hpp>
#include <LMDCustomContainer.hpp>
#include <LMDCustomImageList.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDBaseControl.hpp>
#include <LMDControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdstringseditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFrmStringEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFrmStringEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdstatusbar::TLMDStatusBar* StatusBar;
	Lmdglyphlabel::TLMDGlyphLabel* PosInfo;
	Lmdinformationlabel::TLMDInformationLabel* LMDInformationLabel1;
	Lmdinformationlabel::TLMDInformationLabel* LMDInformationLabel2;
	Vcl::Stdctrls::TMemo* StrList;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Dialogs::TFindDialog* FindDialog;
	Vcl::Dialogs::TReplaceDialog* ReplaceDialog;
	Vcl::Dialogs::TPrintDialog* PrintDialog;
	Lmdimagelist::TLMDImageList* LMDImageList2;
	Lmdsimplepanel::TLMDSimplePanel* main;
	Vcl::Stdctrls::TButton* LMDButton1;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* LMDButton2;
	Lmdsimplepanel::TLMDSimplePanel* tools;
	Lmdspeedbutton::TLMDSpeedButton* OpenBtn;
	Lmdspeedbutton::TLMDSpeedButton* SaveBtn;
	Lmdspeedbutton::TLMDSpeedButton* CopyBtn;
	Lmdspeedbutton::TLMDSpeedButton* PasteBtn;
	Lmdspeedbutton::TLMDSpeedButton* CutBtn;
	Lmdspeedbutton::TLMDSpeedButton* SelectBtn;
	Lmdspeedbutton::TLMDSpeedButton* PrintBtn;
	Lmdspeedbutton::TLMDSpeedButton* SearchBtn;
	Lmdspeedbutton::TLMDSpeedButton* ReplaceBtn;
	void __fastcall SelectBtnClick(System::TObject* Sender);
	void __fastcall CutBtnClick(System::TObject* Sender);
	void __fastcall PasteBtnClick(System::TObject* Sender);
	void __fastcall CopyBtnClick(System::TObject* Sender);
	void __fastcall SaveBtnClick(System::TObject* Sender);
	void __fastcall OpenBtnClick(System::TObject* Sender);
	void __fastcall StrListChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall StrListClick(System::TObject* Sender);
	void __fastcall StrListKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall StrListKeyUp(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall StrListKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall SearchBtnClick(System::TObject* Sender);
	void __fastcall Find(System::TObject* Sender);
	void __fastcall PrintBtnClick(System::TObject* Sender);
	void __fastcall ReplaceBtnClick(System::TObject* Sender);
	void __fastcall ReplaceDialogReplace(System::TObject* Sender);
	void __fastcall FindDialogFind(System::TObject* Sender);
	void __fastcall ReplaceDialogFind(System::TObject* Sender);
	void __fastcall ReplaceDialogClose(System::TObject* Sender);
	void __fastcall LMDButton1Click(System::TObject* Sender);
	void __fastcall btnCancelClick(System::TObject* Sender);
	
private:
	int LastPos;
	int LastLine;
	void __fastcall UpDateCursorPos(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFrmStringEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFrmStringEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFrmStringEditor(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFrmStringEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdstringseditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDSTRINGSEDITORDLG)
using namespace Plmdstringseditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdstringseditordlgHPP
