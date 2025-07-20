// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSVGCanvasEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesvgcanvaseditorHPP
#define Vcltee_TeesvgcanvaseditorHPP

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
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.TeeSVGCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesvgcanvaseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSVGOptions;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSVGOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBAntiAlias;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EDesc;
	Vcl::Stdctrls::TCheckBox* CBGroup;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
private:
	Vcltee::Teesvgcanvas::TSVGExportFormat* SVG;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSVGOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSVGOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSVGOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSVGOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesvgcanvaseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESVGCANVASEDITOR)
using namespace Vcltee::Teesvgcanvaseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesvgcanvaseditorHPP
