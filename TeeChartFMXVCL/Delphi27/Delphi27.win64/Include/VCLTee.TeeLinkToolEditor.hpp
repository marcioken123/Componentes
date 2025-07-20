// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLinkToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelinktooleditorHPP
#define Vcltee_TeelinktooleditorHPP

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
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeAnnToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeLinkTool.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelinktooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLinkToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLinkToolEditor : public Vcltee::Teeanntooledit::TAnnotationToolEdit
{
	typedef Vcltee::Teeanntooledit::TAnnotationToolEdit inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabLink;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Stdctrls::TEdit* EURL;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TEdit* EHint;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Stdctrls::TEdit* EText;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall EURLChange(System::TObject* Sender);
	void __fastcall EHintChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	HIDESBASE void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall ETextChange(System::TObject* Sender);
	
private:
	Vcltee::Teelinktool::TLinkTool* Link;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLinkToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLinkToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLinkToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLinkToolEditor(HWND ParentWindow) : Vcltee::Teeanntooledit::TAnnotationToolEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelinktooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELINKTOOLEDITOR)
using namespace Vcltee::Teelinktooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelinktooleditorHPP
