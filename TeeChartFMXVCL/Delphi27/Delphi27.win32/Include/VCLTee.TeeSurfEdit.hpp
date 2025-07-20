// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSurfEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesurfeditHPP
#define Vcltee_TeesurfeditHPP

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
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesurfedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSurfaceSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSurfaceSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabBrush;
	Vcl::Comctrls::TTabSheet* TabSides;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Extctrls::TRadioGroup* RadioGroup1;
	Vcl::Stdctrls::TCheckBox* CBSmooth;
	Vcl::Stdctrls::TCheckBox* CBFastBrush;
	Vcl::Stdctrls::TCheckBox* CBHideCells;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSideBorder;
	Vcl::Comctrls::TTabSheet* TabSidePattern;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall RadioGroup1Click(System::TObject* Sender);
	void __fastcall CBSmoothClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBFastBrushClick(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBHideCellsClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	
protected:
	Vcl::Forms::TCustomForm* Grid3DForm;
	Vcltee::Teesurfa::TSurfaceSeries* Surface;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSurfaceSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSurfaceSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSurfaceSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSurfaceSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesurfedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESURFEDIT)
using namespace Vcltee::Teesurfedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesurfeditHPP
