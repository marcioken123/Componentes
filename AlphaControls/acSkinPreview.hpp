// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acSkinPreview.pas' rev: 27.00 (Windows)

#ifndef AcskinpreviewHPP
#define AcskinpreviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Dialogs.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sStatusBar.hpp>	// Pascal unit
#include <sEdit.hpp>	// Pascal unit
#include <sBitBtn.hpp>	// Pascal unit
#include <sPanel.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <sCheckBox.hpp>	// Pascal unit
#include <sGroupBox.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acskinpreview
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TFormSkinPreview;
class PASCALIMPLEMENTATION TFormSkinPreview : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Sedit::TsEdit* sEdit1;
	Sstatusbar::TsStatusBar* sStatusBar1;
	Spanel::TsPanel* sPanel1;
	Sskinprovider::TsSkinProvider* sSkinProvider1;
	Sgroupbox::TsGroupBox* sGroupBox1;
	Scheckbox::TsCheckBox* sCheckBox1;
	Scheckbox::TsCheckBox* sCheckBox2;
	Spanel::TsPanel* sPanel2;
	Sbitbtn::TsBitBtn* sBitBtn1;
	Sbitbtn::TsBitBtn* sBitBtn2;
	Sskinmanager::TsSkinManager* PreviewManager;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFormSkinPreview(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFormSkinPreview(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFormSkinPreview(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFormSkinPreview(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TFormSkinPreview* FormSkinPreview;
}	/* namespace Acskinpreview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACSKINPREVIEW)
using namespace Acskinpreview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcskinpreviewHPP
