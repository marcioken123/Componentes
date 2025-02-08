// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFLinkDialog.pas' rev: 31.00 (Windows)

#ifndef LmdrtflinkdialogHPP
#define LmdrtflinkdialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDRTFHyperText.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtflinkdialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRichfrmLinkDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRichfrmLinkDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* pcLinkType;
	Vcl::Comctrls::TTabSheet* tabURL;
	Vcl::Comctrls::TTabSheet* tabLink;
	Vcl::Stdctrls::TEdit* URLAddress;
	Vcl::Stdctrls::TComboBox* LINKAddress;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnDelete;
	Vcl::Stdctrls::TButton* btnCancel;
	void __fastcall btnDeleteClick(System::TObject* Sender);
	void __fastcall btnCancelClick(System::TObject* Sender);
	void __fastcall btnOKClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall LINKAddressChange(System::TObject* Sender);
	
private:
	Lmdrtfhypertext::TLMDRichHyperText* FHyperText;
	System::UnicodeString FOldLink;
	void __fastcall CheckButtons(void);
	
public:
	__fastcall TLMDRichfrmLinkDialog(Lmdrtfhypertext::TLMDRichHyperText* aHyperText);
	__classmethod bool __fastcall Execute(Lmdrtfhypertext::TLMDRichHyperText* aHyperText);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRichfrmLinkDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRichfrmLinkDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRichfrmLinkDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRichfrmLinkDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtflinkdialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFLINKDIALOG)
using namespace Lmdrtflinkdialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtflinkdialogHPP
