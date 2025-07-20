// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeRepaintMonitorEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeerepaintmonitoreditorHPP
#define Vcltee_TeerepaintmonitoreditorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeAnnToolEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeTools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teerepaintmonitoreditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRepaintMonitorEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRepaintMonitorEditor : public Vcltee::Teeanntooledit::TAnnotationToolEdit
{
	typedef Vcltee::Teeanntooledit::TAnnotationToolEdit inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabMonitor;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Comctrls::TTrackBar* TBInterval;
	Vcl::Stdctrls::TLabel* LInterval;
	Vcl::Extctrls::TRadioGroup* RGMode;
	Vcl::Stdctrls::TCheckBox* CBShowChart;
	void __fastcall CBShowChartClick(System::TObject* Sender);
	void __fastcall RGModeClick(System::TObject* Sender);
	void __fastcall TBIntervalChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
private:
	void __fastcall SetLabelInterval();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRepaintMonitorEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRepaintMonitorEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeanntooledit::TAnnotationToolEdit(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRepaintMonitorEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRepaintMonitorEditor(HWND ParentWindow) : Vcltee::Teeanntooledit::TAnnotationToolEdit(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerepaintmonitoreditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEREPAINTMONITOREDITOR)
using namespace Vcltee::Teerepaintmonitoreditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeerepaintmonitoreditorHPP
