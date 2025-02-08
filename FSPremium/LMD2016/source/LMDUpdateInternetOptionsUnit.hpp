// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUpdateInternetOptionsUnit.pas' rev: 31.00 (Windows)

#ifndef LmdupdateinternetoptionsunitHPP
#define LmdupdateinternetoptionsunitHPP

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
#include <LMDCustomComponent.hpp>
#include <LMDWebBase.hpp>
#include <LMDRAS.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDWebConfig.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdupdateinternetoptionsunit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUpdateInternetOptions;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDUpdateInternetOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Lmdras::TLMDRAS* LMDRAS1;
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TGroupBox* gbEnableDUN;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TCheckBox* cbUseModem;
	Vcl::Stdctrls::TComboBox* cbDUN;
	Vcl::Stdctrls::TEdit* edRetries;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TCheckBox* cbAutoDial;
	Vcl::Stdctrls::TCheckBox* cbAutoClose;
	Vcl::Stdctrls::TEdit* edURL;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* cbUseProxy;
	Vcl::Stdctrls::TEdit* edHost;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TEdit* edPort;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TCheckBox* cbProxyAuth;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* edUser;
	Vcl::Stdctrls::TLabel* lbPWD;
	Vcl::Stdctrls::TEdit* edPWD;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TComboBox* cmbProxyType;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TButton* Button2;
	void __fastcall UpDown1Click(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall edRetriesKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall edPortKeyPress(System::TObject* Sender, System::WideChar &Key);
	void __fastcall cbUseModemClick(System::TObject* Sender);
	void __fastcall cbUseProxyClick(System::TObject* Sender);
	void __fastcall cbProxyAuthClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDUpdateInternetOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDUpdateInternetOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDUpdateInternetOptions(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDUpdateInternetOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDUpdateInternetOptions* LMDUpdateInternetOptions;
}	/* namespace Lmdupdateinternetoptionsunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUPDATEINTERNETOPTIONSUNIT)
using namespace Lmdupdateinternetoptionsunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdupdateinternetoptionsunitHPP
