// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDPluginWizardInfo.pas' rev: 31.00 (Windows)

#ifndef PlmdpluginwizardinfoHPP
#define PlmdpluginwizardinfoHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdpluginwizardinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPluginWizardInfo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDPluginWizardInfo : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* pnlMain;
	Vcl::Stdctrls::TGroupBox* grpPluginInfo;
	Vcl::Stdctrls::TLabel* lblAuthor;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* edAuthor;
	Vcl::Stdctrls::TEdit* edMajor;
	Vcl::Comctrls::TUpDown* udMajor;
	Vcl::Stdctrls::TEdit* edMinor;
	Vcl::Comctrls::TUpDown* udMinor;
	Vcl::Stdctrls::TGroupBox* grpProjectFolder;
	Vcl::Stdctrls::TEdit* edProjectFolder;
	Vcl::Stdctrls::TButton* btnChooseFolder;
	Vcl::Stdctrls::TButton* btnOK;
	Vcl::Stdctrls::TButton* btnCancel;
	void __fastcall udMajorClick(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall udMinorClick(System::TObject* Sender, Vcl::Comctrls::TUDBtnType Button);
	void __fastcall btnChooseFolderClick(System::TObject* Sender);
	void __fastcall edMajorKeyPress(System::TObject* Sender, System::WideChar &Key);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLMDPluginWizardInfo(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLMDPluginWizardInfo(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLMDPluginWizardInfo(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPluginWizardInfo(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDPluginWizardInfo* LMDPluginWizardInfo;
}	/* namespace Plmdpluginwizardinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDPLUGINWIZARDINFO)
using namespace Plmdpluginwizardinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdpluginwizardinfoHPP
