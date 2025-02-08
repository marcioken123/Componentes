// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElPictPropDlg.pas' rev: 31.00 (Windows)

#ifndef ElpictpropdlgHPP
#define ElpictpropdlgHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Clipbrd.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <ElCheckCtl.hpp>
#include <ElXPThemedControl.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>
#include <Vcl.ExtDlgs.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <ElPanel.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elpictpropdlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElPicturePropDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElPicturePropDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Elpanel::TElPanel* pnlBottom;
	Elpanel::TElPanel* pnlImage;
	Elpanel::TElPanel* pnlControl;
	Vcl::Extctrls::TImage* Image;
	Elpopbtn::TElPopupButton* btnLoad;
	Elpopbtn::TElPopupButton* btnSave;
	Elpopbtn::TElPopupButton* btnCopy;
	Elpopbtn::TElPopupButton* btnPaste;
	Elpopbtn::TElPopupButton* btnClear;
	Elcheckctl::TElCheckBox* chbUsePreview;
	Elpopbtn::TElPopupButton* btnOK;
	Elpopbtn::TElPopupButton* btnCancel;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog;
	void __fastcall btnLoadClick(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	void __fastcall btnSaveClick(System::TObject* Sender);
	void __fastcall btnCopyClick(System::TObject* Sender);
	void __fastcall btnPasteClick(System::TObject* Sender);
	void __fastcall DoPictureChange(System::TObject* Sender);
	
private:
	bool FIsIcon;
	bool __fastcall HasImage(void);
	void __fastcall SetCaption(void);
	Vcl::Graphics::TPicture* __fastcall GetPicture(void);
	void __fastcall SetPicture(Vcl::Graphics::TPicture* const Value);
	void __fastcall SetIsIcon(const bool Value);
	
public:
	__fastcall virtual TElPicturePropDialog(System::Classes::TComponent* AOwner);
	__property bool IsIcon = {read=FIsIcon, write=SetIsIcon, nodefault};
	__property Vcl::Graphics::TPicture* Value = {read=GetPicture, write=SetPicture};
public:
	/* TCustomForm.CreateNew */ inline __fastcall virtual TElPicturePropDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TElPicturePropDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TElPicturePropDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TElPicturePropDialog* ElPicturePropDialog;
}	/* namespace Elpictpropdlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPICTPROPDLG)
using namespace Elpictpropdlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElpictpropdlgHPP
