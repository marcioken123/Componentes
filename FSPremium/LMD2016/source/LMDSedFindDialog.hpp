// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSedFindDialog.pas' rev: 31.00 (Windows)

#ifndef LmdsedfinddialogHPP
#define LmdsedfinddialogHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <LMDSedDocument.hpp>
#include <LMDSedView.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsedfinddialog
{
//-- forward type declarations -----------------------------------------------
struct TLMDEditSearchDlgOptions;
class DELPHICLASS TLMDSedFindDlg;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDEditSearchDlgOptions
{
	
private:
	typedef System::DynamicArray<Lmdtypes::TLMDString> _TLMDEditSearchDlgOptions__1;
	
	typedef System::DynamicArray<Lmdtypes::TLMDString> _TLMDEditSearchDlgOptions__2;
	
	
public:
	_TLMDEditSearchDlgOptions__1 Searches;
	_TLMDEditSearchDlgOptions__2 Replaces;
	Lmdsedview::TLMDEditViewReplaceAllBounds ReplaceAllBounds;
	Lmdseddocument::TLMDEditSearchOptions Options;
	Lmdseddocument::TLMDEditSearchDirection Direction;
	Lmdsedview::TLMDEditViewSearchStart Start;
	int LastNumberOfReplacements;
	bool WasReplaceAllChosen;
};


class PASCALIMPLEMENTATION TLMDSedFindDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Extctrls::TPanel* pnOpts1;
	Vcl::Stdctrls::TGroupBox* grOptions;
	Vcl::Stdctrls::TCheckBox* cbCaseSensitive;
	Vcl::Stdctrls::TCheckBox* cbWholeWords;
	Vcl::Stdctrls::TCheckBox* cbRegexps;
	Vcl::Stdctrls::TCheckBox* cbConfirmReplace;
	Vcl::Stdctrls::TGroupBox* grDirection;
	Vcl::Stdctrls::TRadioButton* cbBackward;
	Vcl::Stdctrls::TRadioButton* cbForward;
	Vcl::Extctrls::TPanel* pnOpts2;
	Vcl::Stdctrls::TGroupBox* grStartFrom;
	Vcl::Stdctrls::TRadioButton* cbFromCursor;
	Vcl::Stdctrls::TRadioButton* cbFromTextStart;
	Vcl::Stdctrls::TGroupBox* grBounds;
	Vcl::Stdctrls::TRadioButton* cbAllText;
	Vcl::Stdctrls::TRadioButton* cbSelection;
	Vcl::Extctrls::TPanel* pnReplaceBtns;
	Vcl::Stdctrls::TButton* btnReplace;
	Vcl::Stdctrls::TButton* btnReplaceCancel;
	Vcl::Stdctrls::TButton* btnReplaceAll;
	Vcl::Extctrls::TPanel* pnReplaceText;
	Vcl::Stdctrls::TLabel* lblTextToReplace;
	Vcl::Stdctrls::TComboBox* edReplaceText;
	Vcl::Extctrls::TPanel* pnSearch;
	Vcl::Stdctrls::TLabel* lblTextToSearch;
	Vcl::Stdctrls::TComboBox* edTextToSearch;
	Vcl::Extctrls::TPanel* pnSearchBtns;
	Vcl::Stdctrls::TButton* btnFind;
	Vcl::Stdctrls::TButton* btnFindCancel;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Extctrls::TPanel* pnReplacePadding;
	Vcl::Extctrls::TPanel* Panel6;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall btnFindClick(System::TObject* Sender);
	void __fastcall edTextToSearchCloseUp(System::TObject* Sender);
	void __fastcall btnReplaceAllClick(System::TObject* Sender);
	
private:
	bool IsReplace;
	Lmdsedview::TLMDCustomEditView* View;
	int NumOfReplacements;
	bool WasReplaceAllChosen;
	void __fastcall RememberSearch(void);
	void __fastcall SetReplace(bool AIsReplace);
	
public:
	TLMDEditSearchDlgOptions __fastcall GetSearchOptions(bool AForSave);
	void __fastcall SetSearchOptions(const TLMDEditSearchDlgOptions &AOps);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDSedFindDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDSedFindDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDSedFindDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDSedFindDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TLMDEditSearchResult : unsigned char { srFound, srNotFound, srCancel };

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDEditSearchResult __fastcall LMDEditExecReplaceDialog(const Lmdtypes::TLMDString ACaption, Lmdsedview::TLMDCustomEditView* AView, TLMDEditSearchDlgOptions &Options);
extern DELPHI_PACKAGE TLMDEditSearchResult __fastcall LMDEditExecFindDialog(const Lmdtypes::TLMDString ACaption, Lmdsedview::TLMDCustomEditView* AView, TLMDEditSearchDlgOptions &Options);
}	/* namespace Lmdsedfinddialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSEDFINDDIALOG)
using namespace Lmdsedfinddialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsedfinddialogHPP
