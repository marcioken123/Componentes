// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFInsertDateTimeDlg.pas' rev: 31.00 (Windows)

#ifndef LmdrtfinsertdatetimedlgHPP
#define LmdrtfinsertdatetimedlgHPP

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
#include <LMDRTFBase.hpp>
#include <LMDRTFRichEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfinsertdatetimedlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TfrmLMDRichInsertDateTimeDlg;
class DELPHICLASS TLMDRichInsertDateTimeDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TfrmLMDRichInsertDateTimeDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* AvailableFormatsLabel;
	Vcl::Stdctrls::TListBox* ListBox;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TButton* btnHelp;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ListBoxDblClick(System::TObject* Sender);
	void __fastcall ListBoxClick(System::TObject* Sender);
	
public:
	void __fastcall AddItems(System::Classes::TStrings* aList);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TfrmLMDRichInsertDateTimeDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TfrmLMDRichInsertDateTimeDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TfrmLMDRichInsertDateTimeDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TfrmLMDRichInsertDateTimeDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TLMDRichInsertDateTimeDialog : public Lmdrtfbase::TLMDRichBaseDialog
{
	typedef Lmdrtfbase::TLMDRichBaseDialog inherited;
	
private:
	Lmdrtfrichedit::TLMDCustomRichEdit* FControl;
	System::UnicodeString FSelectedValue;
	int FLast;
	System::Classes::TStrings* FFormats;
	void __fastcall SetControl(Lmdrtfrichedit::TLMDCustomRichEdit* const Value);
	void __fastcall SetFormats(System::Classes::TStrings* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDRichInsertDateTimeDialog(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDRichInsertDateTimeDialog(void);
	virtual bool __fastcall Execute(Vcl::Forms::TCustomForm* AOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	__property System::UnicodeString SelectedValue = {read=FSelectedValue};
	
__published:
	__property Lmdrtfrichedit::TLMDCustomRichEdit* RichEditControl = {read=FControl, write=SetControl};
	__property System::Classes::TStrings* DateTimeFormats = {read=FFormats, write=SetFormats};
	__property OnHelpClick;
	__property OnCustomize;
	__property Options = {default=6};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TfrmLMDRichInsertDateTimeDlg* frmLMDRichInsertDateTimeDlg;
}	/* namespace Lmdrtfinsertdatetimedlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFINSERTDATETIMEDLG)
using namespace Lmdrtfinsertdatetimedlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfinsertdatetimedlgHPP
