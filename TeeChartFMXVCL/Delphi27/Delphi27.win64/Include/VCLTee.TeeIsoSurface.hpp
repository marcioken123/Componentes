// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeIsoSurface.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeisosurfaceHPP
#define Vcltee_TeeisosurfaceHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeeSurfEdit.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeisosurface
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TIsoSurfaceEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TIsoSurfaceEditor : public Vcltee::Teesurfedit::TSurfaceSeriesEditor
{
	typedef Vcltee::Teesurfedit::TSurfaceSeriesEditor inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* CBUseY;
	Vcl::Stdctrls::TEdit* EYPosition;
	Vcl::Comctrls::TTabSheet* TabBands;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBUseYClick(System::TObject* Sender);
	void __fastcall EYPositionChange(System::TObject* Sender);
	HIDESBASE void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	bool IModifying;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TIsoSurfaceEditor(System::Classes::TComponent* AOwner) : Vcltee::Teesurfedit::TSurfaceSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TIsoSurfaceEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teesurfedit::TSurfaceSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TIsoSurfaceEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TIsoSurfaceEditor(HWND ParentWindow) : Vcltee::Teesurfedit::TSurfaceSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeisosurface */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEISOSURFACE)
using namespace Vcltee::Teeisosurface;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeisosurfaceHPP
