// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDRTFToolbarOptions.pas' rev: 31.00 (Windows)

#ifndef PlmdrtftoolbaroptionsHPP
#define PlmdrtftoolbaroptionsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.CheckLst.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdrtftoolbaroptions
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TToolbarOptionsForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TToolbarOptionsForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TButton* CancelButton;
	Vcl::Stdctrls::TRadioButton* ToolBarRadioButton;
	Vcl::Stdctrls::TRadioButton* ActionBarRadioButton;
	Vcl::Stdctrls::TCheckBox* MenuBarCheckBox;
	Vcl::Stdctrls::TButton* OKButton;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Comctrls::TListView* CheckListBox;
	Vcl::Stdctrls::TLabel* Label1;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ToolBarRadioButtonClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TToolbarOptionsForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TToolbarOptionsForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TToolbarOptionsForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TToolbarOptionsForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdrtftoolbaroptions */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDRTFTOOLBAROPTIONS)
using namespace Plmdrtftoolbaroptions;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdrtftoolbaroptionsHPP
