// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBRefineDialog.pas' rev: 31.00 (Windows)

#ifndef LmddbrefinedialogHPP
#define LmddbrefinedialogHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDSearchConsts.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbrefinedialog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBSearchFindForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBSearchFindForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* FindWhatLabel;
	Vcl::Stdctrls::TEdit* FindEdit;
	Vcl::Stdctrls::TButton* FindNextButton;
	Vcl::Stdctrls::TButton* CloseButton;
	Vcl::Stdctrls::TButton* BuildButton;
	Vcl::Stdctrls::TGroupBox* DirectionGroupBox;
	Vcl::Stdctrls::TRadioButton* UpRadioButton;
	Vcl::Stdctrls::TRadioButton* DownRadioButton;
	Vcl::Stdctrls::TGroupBox* CriteriaGroupBox;
	Vcl::Stdctrls::TCheckBox* MathWholeCheckBox;
	Vcl::Stdctrls::TCheckBox* MathCaseCheckBox;
	void __fastcall FormCreate(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDDBSearchFindForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDDBSearchFindForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDDBSearchFindForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDDBSearchFindForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbrefinedialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBREFINEDIALOG)
using namespace Lmddbrefinedialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbrefinedialogHPP
