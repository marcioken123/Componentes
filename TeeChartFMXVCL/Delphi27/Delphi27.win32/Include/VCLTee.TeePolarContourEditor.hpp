// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePolarContourEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepolarcontoureditorHPP
#define Vcltee_TeepolarcontoureditorHPP

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
#include <VCLTee.TeePolarEditor.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeContourEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepolarcontoureditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarContourSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolarContourSeriesEditor : public Vcltee::Teepolareditor::TPolarSeriesEditor
{
	typedef Vcltee::Teepolareditor::TPolarSeriesEditor inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabLevels;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcl::Forms::TCustomForm* Grid3DForm;
	Vcltee::Teecontouredit::TContourSeriesEditor* ContourForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPolarContourSeriesEditor(System::Classes::TComponent* AOwner) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPolarContourSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teepolareditor::TPolarSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPolarContourSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPolarContourSeriesEditor(HWND ParentWindow) : Vcltee::Teepolareditor::TPolarSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepolarcontoureditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOLARCONTOUREDITOR)
using namespace Vcltee::Teepolarcontoureditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepolarcontoureditorHPP
