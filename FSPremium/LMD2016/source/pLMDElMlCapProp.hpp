// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDElMlCapProp.pas' rev: 31.00 (Windows)

#ifndef PlmdelmlcappropHPP
#define PlmdelmlcappropHPP

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
#include <DesignEditors.hpp>
#include <DesignWindows.hpp>
#include <DsnConst.hpp>
#include <DesignIntf.hpp>
#include <System.TypInfo.hpp>
#include <LMDUnicodeStrings.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <ElIni.hpp>
#include <ElFrmPers.hpp>
#include <ElXPThemedControl.hpp>
#include <ElEdits.hpp>
#include <Vcl.Buttons.hpp>
#include <ElBtnCtl.hpp>
#include <ElPopBtn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdelmlcapprop
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMlCapEditDialog;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMlCapEditDialog : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* LineCounter;
	Eledits::TElEdit* Memo;
	Vcl::Buttons::TSpeedButton* Load;
	Vcl::Buttons::TSpeedButton* Save;
	Vcl::Dialogs::TOpenDialog* OpenDialog;
	Vcl::Dialogs::TSaveDialog* SaveDialog;
	Elpopbtn::TElPopupButton* OkButton;
	Elpopbtn::TElPopupButton* CancelButton;
	void __fastcall MemoChange(System::TObject* Sender);
	void __fastcall LoadClick(System::TObject* Sender);
	void __fastcall SaveClick(System::TObject* Sender);
	void __fastcall FormKeyPress(System::TObject* Sender, System::WideChar &Key);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMlCapEditDialog(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMlCapEditDialog(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMlCapEditDialog(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMlCapEditDialog(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdelmlcapprop */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDELMLCAPPROP)
using namespace Plmdelmlcapprop;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdelmlcappropHPP
