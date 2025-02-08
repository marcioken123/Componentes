// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintPreviewDlg.pas' rev: 31.00 (Windows)

#ifndef LmdprintpreviewdlgHPP
#define LmdprintpreviewdlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDPrintToolBar.hpp>
#include <LMDControl.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomStatusBar.hpp>
#include <LMDPrintStatusBar.hpp>
#include <LMDPrintPreviewPanel.hpp>
#include <LMDPrinter.hpp>
#include <LMDCustomPrintTask.hpp>
#include <LMDPrintConst.hpp>
#include <LMDPrintPageDialog.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprintpreviewdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrintPreviewForm;
class DELPHICLASS TLMDPrintPreviewDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPrintPreviewForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdprintstatusbar::TLMDPrintStatusBar* LMDPrintStatusBar1;
	Lmdprintpreviewpanel::TLMDPrintPreviewPanel* pp;
	Lmdprinttoolbar::TLMDPrintToolBar* LMDPrintToolBar1;
	void __fastcall FormKeyDown(System::TObject* Sender, System::Word &Key, System::Classes::TShiftState Shift);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDPrintPreviewForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDPrintPreviewForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDPrintPreviewForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPrintPreviewForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDPrintPreviewDialog : public Lmdprintpagedialog::TLMDPrintBaseDialog
{
	typedef Lmdprintpagedialog::TLMDPrintBaseDialog inherited;
	
private:
	Vcl::Forms::TForm* FPreviewDlg;
	Lmdprinter::TLMDPrinter* __fastcall GetLMDPrinter(void);
	void __fastcall SetLMDPrinter(Lmdprinter::TLMDPrinter* APrinter);
	
protected:
	virtual bool __fastcall DoExecute(HWND ParentWnd);
	DYNAMIC void __fastcall DoClose(void);
	DYNAMIC void __fastcall DoShow(void);
	
public:
	__fastcall virtual TLMDPrintPreviewDialog(System::Classes::TComponent* AOwner);
	void __fastcall ShowModal(void);
	Vcl::Forms::TForm* __fastcall GetDialogForm(void);
	
__published:
	__property Lmdprinter::TLMDPrinter* Printer = {read=GetLMDPrinter, write=SetLMDPrinter};
public:
	/* TLMDPrintBaseDialog.Destroy */ inline __fastcall virtual ~TLMDPrintPreviewDialog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDPrintExecPreviewDlg(Lmdprinter::TLMDPrinterHelper* APrintHelper);
}	/* namespace Lmdprintpreviewdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTPREVIEWDLG)
using namespace Lmdprintpreviewdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprintpreviewdlgHPP
