// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDFilterPropertyEditorDlg.pas' rev: 31.00 (Windows)

#ifndef PlmdfilterpropertyeditordlgHPP
#define PlmdfilterpropertyeditordlgHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Grids.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdfilterpropertyeditordlg
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFilterPropsDlg;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFilterPropsDlg : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* OKBtn;
	Vcl::Stdctrls::TButton* CancelBtn;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Grids::TStringGrid* FilterGrid;
	Vcl::Dialogs::TOpenDialog* OpenDialog1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall OKBtnClick(System::TObject* Sender);
	
private:
	System::UnicodeString FFilter;
	
public:
	__property System::UnicodeString Filter = {read=FFilter, write=FFilter};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDFilterPropsDlg(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDFilterPropsDlg(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDFilterPropsDlg(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDFilterPropsDlg(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdfilterpropertyeditordlg */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDFILTERPROPERTYEDITORDLG)
using namespace Plmdfilterpropertyeditordlg;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdfilterpropertyeditordlgHPP
