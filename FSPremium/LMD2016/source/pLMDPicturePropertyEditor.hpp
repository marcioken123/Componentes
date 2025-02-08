// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDPicturePropertyEditor.pas' rev: 31.00 (Windows)

#ifndef PlmdpicturepropertyeditorHPP
#define PlmdpicturepropertyeditorHPP

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
#include <Vcl.ExtDlgs.hpp>
#include <LMDPNGImage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdpicturepropertyeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPicturePropertyEditorDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPicturePropertyEditorDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TImage* Image;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TButton* Button3;
	Vcl::Stdctrls::TButton* Button4;
	Vcl::Stdctrls::TButton* Button5;
	Vcl::Extdlgs::TOpenPictureDialog* OpenPictureDialog;
	Vcl::Extdlgs::TSavePictureDialog* SavePictureDialog;
	void __fastcall Button5Click(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall Button4Click(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	void __fastcall SetPicture(Vcl::Graphics::TPicture* const Value);
	Vcl::Graphics::TPicture* __fastcall GetPicture(void);
	
public:
	Lmdpngimage::TLMDPNGObject* PNGImage;
	__property Vcl::Graphics::TPicture* Picture = {read=GetPicture, write=SetPicture};
	bool __fastcall Execute(void);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDPicturePropertyEditorDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDPicturePropertyEditorDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDPicturePropertyEditorDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPicturePropertyEditorDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDPicturePropertyEditorDlg* LMDPicturePropertyEditorDlg;
}	/* namespace Plmdpicturepropertyeditor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDPICTUREPROPERTYEDITOR)
using namespace Plmdpicturepropertyeditor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdpicturepropertyeditorHPP
