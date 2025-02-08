// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDBarSelectIMLDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdbarselectimldlgHPP
#define PlmdbarselectimldlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <DesignIntf.hpp>
#include <DesignEditors.hpp>
#include <VCLEditors.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <pLMDImageBox.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdbarselectimldlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDfrmBarSelectIMLDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDfrmBarSelectIMLDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	Vcl::Stdctrls::TComboBox* ln;
	Vcl::Stdctrls::TButton* btnClear;
	Plmdimagebox::TLMDImageLBox* lb;
	void __fastcall lnChange(System::TObject* Sender);
	void __fastcall btnClearClick(System::TObject* Sender);
	
private:
	Designintf::_di_IDesigner FDesigner;
	Vcl::Imglist::TCustomImageList* __fastcall GetImageList(void);
	void __fastcall GetLists(const System::UnicodeString S);
	void __fastcall SetImageList(Vcl::Imglist::TCustomImageList* aValue);
	
public:
	void __fastcall AddImageLists(void);
	__property Designintf::_di_IDesigner Design = {read=FDesigner, write=FDesigner};
	__property Vcl::Imglist::TCustomImageList* ImageList = {read=GetImageList, write=SetImageList};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDfrmBarSelectIMLDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDfrmBarSelectIMLDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDfrmBarSelectIMLDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDfrmBarSelectIMLDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDfrmBarSelectIMLDlg* LMDfrmBarSelectIMLDlg;
}	/* namespace Plmdbarselectimldlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDBARSELECTIMLDLG)
using namespace Plmdbarselectimldlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdbarselectimldlgHPP
