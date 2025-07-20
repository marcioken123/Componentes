// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeRoseEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeroseeditorHPP
#define Vcltee_TeeroseeditorHPP

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
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeePolar.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdiFont.hpp>
#include <VCLTee.TeePolarEditor.hpp>
#include <VCLTee.TeeRose.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeroseeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRoseSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRoseSeriesEditor : public Vcltee::Teepolareditor::TPolarSeriesEditor
{
	typedef Vcltee::Teepolareditor::TPolarSeriesEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label4;
	Vcltee::Tecanvas::TComboFlat* CBStack;
	void __fastcall CBStackChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	
protected:
	virtual Vcltee::Teepolar::TCustomPolarSeries* __fastcall CreatePolar();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRoseSeriesEditor(System::Classes::TComponent* AOwner) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRoseSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRoseSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRoseSeriesEditor(HWND ParentWindow) : Vcltee::Teepolareditor::TPolarSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeroseeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEROSEEDITOR)
using namespace Vcltee::Teeroseeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeroseeditorHPP
