// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDrawLineEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedrawlineeditorHPP
#define Vcltee_TeedrawlineeditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedrawlineeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDrawLineEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDrawLineEdit : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label11;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBButton;
	Vcl::Stdctrls::TCheckBox* CBEnable;
	Vcl::Stdctrls::TCheckBox* CBSelect;
	Vcl::Stdctrls::TEdit* EPixels;
	Vcl::Comctrls::TUpDown* UDClick;
	Vcl::Stdctrls::TCheckBox* CBSelectNew;
	Vcl::Stdctrls::TLabel* Label4;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Stdctrls::TCheckBox* CBFullRepaint;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBButtonChange(System::TObject* Sender);
	void __fastcall CBEnableClick(System::TObject* Sender);
	void __fastcall CBSelectClick(System::TObject* Sender);
	void __fastcall EPixelsChange(System::TObject* Sender);
	void __fastcall CBSelectNewClick(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBFullRepaintClick(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TDrawLineTool* Draw;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDrawLineEdit(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDrawLineEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDrawLineEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDrawLineEdit(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedrawlineeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDRAWLINEEDITOR)
using namespace Vcltee::Teedrawlineeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedrawlineeditorHPP
