// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeViolinEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeviolineditHPP
#define Vcltee_TeeviolineditHPP

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
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeBoxPlot.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeCustEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeviolinedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TViolinSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TViolinSeriesEditor : public Vcltee::Teecustedit::TCustomSeriesEditor
{
	typedef Vcltee::Teecustedit::TCustomSeriesEditor inherited;
	
__published:
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall FormDestroy(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Vcltee::Teeboxplot::TViolinSeries* Violin;
	Vcl::Forms::TCustomForm* KDEForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TViolinSeriesEditor(System::Classes::TComponent* AOwner) : Vcltee::Teecustedit::TCustomSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TViolinSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teecustedit::TCustomSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TViolinSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TViolinSeriesEditor(HWND ParentWindow) : Vcltee::Teecustedit::TCustomSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TViolinSeriesEditor* ViolinSeriesEditor;
extern DELPHI_PACKAGE Vcl::Comctrls::TTabSheet* tabViolin;
}	/* namespace Teeviolinedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEVIOLINEDIT)
using namespace Vcltee::Teeviolinedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeviolineditHPP
