// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeWaterFallEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeewaterfalleditHPP
#define Vcltee_TeewaterfalleditHPP

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
#include <VCLTee.TeeSurfEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teewaterfalledit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TWaterFallEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TWaterFallEditor : public Vcltee::Teesurfedit::TSurfaceSeriesEditor
{
	typedef Vcltee::Teesurfedit::TSurfaceSeriesEditor inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabLines;
	HIDESBASE void __fastcall PageControl1Change(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TWaterFallEditor(System::Classes::TComponent* AOwner) : Vcltee::Teesurfedit::TSurfaceSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TWaterFallEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teesurfedit::TSurfaceSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TWaterFallEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TWaterFallEditor(HWND ParentWindow) : Vcltee::Teesurfedit::TSurfaceSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teewaterfalledit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEWATERFALLEDIT)
using namespace Vcltee::Teewaterfalledit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeewaterfalleditHPP
