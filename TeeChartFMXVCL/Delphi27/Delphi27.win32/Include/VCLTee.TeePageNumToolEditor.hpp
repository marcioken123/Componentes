// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePageNumToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepagenumtooleditorHPP
#define Vcltee_TeepagenumtooleditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeAnnToolEdit.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepagenumtooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPageNumToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPageNumToolEdit : public Vcltee::Teeanntooledit::TAnnotationToolEdit
{
	typedef Vcltee::Teeanntooledit::TAnnotationToolEdit inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TagPaging;
	Vcl::Comctrls::TPageControl* PageControl4;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TCheckBox* CBButtons;
	Vcl::Stdctrls::TLabel* Label20;
	Vcl::Stdctrls::TEdit* EWidth;
	Vcl::Comctrls::TUpDown* UDButtonWidth;
	Vcl::Comctrls::TTabSheet* TabEnabled;
	Vcl::Comctrls::TTabSheet* TabDisabled;
	Vcl::Comctrls::TTabSheet* TabButtonPen;
	void __fastcall EWidthChange(System::TObject* Sender);
	void __fastcall CBButtonsClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall PageControl4Change(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPageNumToolEdit(System::Classes::TComponent* AOwner) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPageNumToolEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPageNumToolEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPageNumToolEdit(HWND ParentWindow) : Vcltee::Teeanntooledit::TAnnotationToolEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepagenumtooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPAGENUMTOOLEDITOR)
using namespace Vcltee::Teepagenumtooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepagenumtooleditorHPP
