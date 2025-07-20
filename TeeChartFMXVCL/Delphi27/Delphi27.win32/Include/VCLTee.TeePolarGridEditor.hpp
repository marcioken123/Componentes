// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePolarGridEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepolargrideditorHPP
#define Vcltee_TeepolargrideditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeePolar.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeePolarEditor.hpp>
#include <VCLTee.TeeGriEd.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeePolarGrid.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepolargrideditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarGridEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolarGridEditor : public Vcltee::Teepolareditor::TPolarSeriesEditor
{
	typedef Vcltee::Teepolareditor::TPolarSeriesEditor inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabPalette;
	Vcl::Stdctrls::TCheckBox* CBCentered;
	Vcl::Stdctrls::TLabel* LGridStyle;
	Vcltee::Tecanvas::TComboFlat* CBGridStyle;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBCenteredClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBGridStyleChange(System::TObject* Sender);
	
private:
	Vcltee::Teegried::TGrid3DSeriesEditor* I3DEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPolarGridEditor(System::Classes::TComponent* AOwner) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPolarGridEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPolarGridEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPolarGridEditor(HWND ParentWindow) : Vcltee::Teepolareditor::TPolarSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepolargrideditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOLARGRIDEDITOR)
using namespace Vcltee::Teepolargrideditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepolargrideditorHPP
