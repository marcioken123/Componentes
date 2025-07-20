// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeBannerToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeebannertooleditorHPP
#define Vcltee_TeebannertooleditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeAnnToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeBannerTool.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teebannertooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBannerEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBannerEditor : public Vcltee::Teeanntooledit::TAnnotationToolEdit
{
	typedef Vcltee::Teeanntooledit::TAnnotationToolEdit inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabBanner;
	Vcl::Stdctrls::TCheckBox* CBScroll;
	Vcl::Stdctrls::TLabel* Label21;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDDelay;
	Vcl::Stdctrls::TCheckBox* CBBlink;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Comctrls::TUpDown* UDBlinkOn;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Comctrls::TUpDown* UDBlinkOff;
	Vcl::Stdctrls::TLabel* Label19;
	Vcltee::Tecanvas::TComboFlat* CBDirection;
	Vcl::Stdctrls::TLabel* Label20;
	Vcl::Stdctrls::TEdit* EStep;
	Vcl::Comctrls::TUpDown* UDStep;
	void __fastcall CBScrollClick(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBBlinkClick(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall CBDirectionChange(System::TObject* Sender);
	void __fastcall EStepChange(System::TObject* Sender);
	
private:
	Vcltee::Teebannertool::TBannerTool* Banner;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TBannerEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TBannerEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TBannerEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TBannerEditor(HWND ParentWindow) : Vcltee::Teeanntooledit::TAnnotationToolEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teebannertooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEBANNERTOOLEDITOR)
using namespace Vcltee::Teebannertooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeebannertooleditorHPP
