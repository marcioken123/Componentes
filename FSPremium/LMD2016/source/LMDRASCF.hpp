// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRASCF.pas' rev: 31.00 (Windows)

#ifndef LmdrascfHPP
#define LmdrascfHPP

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
#include <LMDRAS.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <LMDWebConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrascf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRASConnectionForm;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRASConnectionForm : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* StatusLabel;
	Vcl::Extctrls::TImage* RASImage;
	Vcl::Stdctrls::TButton* CancelBtn;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CancelBtnClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CDialUpAsyncEvent(System::TObject* Sender, int State, int Error, System::UnicodeString MessageText);
	
public:
	Lmdras::TLMDRAS* DU;
	System::UnicodeString szConnection;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDRASConnectionForm(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDRASConnectionForm(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDRASConnectionForm(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDRASConnectionForm(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDRASConnectionForm* LMDRASConnectionForm;
}	/* namespace Lmdrascf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRASCF)
using namespace Lmdrascf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrascfHPP
