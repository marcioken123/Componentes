// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeKnobGaugeEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeknobgaugeeditorHPP
#define Vcltee_TeeknobgaugeeditorHPP

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
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeCircularGauge.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeCircularGaugeEditor.hpp>
#include <VCLTee.TeeKnobGauge.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeknobgaugeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKnobGaugeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKnobGaugeEditor : public Vcltee::Teecirculargaugeeditor::TCircularGaugeEditor
{
	typedef Vcltee::Teecirculargaugeeditor::TCircularGaugeEditor inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabKnob;
	Vcl::Comctrls::TPageControl* PageControl4;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* TabHighlight;
	Vcl::Stdctrls::TCheckBox* CBAxisInside;
	Vcl::Stdctrls::TCheckBox* CBActiveCenter;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBAxisInsideClick(System::TObject* Sender);
	void __fastcall CBActiveCenterClick(System::TObject* Sender);
	void __fastcall PageControl4Change(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKnobGaugeEditor(System::Classes::TComponent* AOwner) : Vcltee::Teecirculargaugeeditor::TCircularGaugeEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKnobGaugeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teecirculargaugeeditor::TCircularGaugeEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKnobGaugeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TKnobGaugeEditor(HWND ParentWindow) : Vcltee::Teecirculargaugeeditor::TCircularGaugeEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeknobgaugeeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEKNOBGAUGEEDITOR)
using namespace Vcltee::Teeknobgaugeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeknobgaugeeditorHPP
