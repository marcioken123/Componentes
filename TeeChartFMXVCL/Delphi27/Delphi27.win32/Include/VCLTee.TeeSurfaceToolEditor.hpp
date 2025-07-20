// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSurfaceToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesurfacetooleditorHPP
#define Vcltee_TeesurfacetooleditorHPP

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
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeSurfaceTool.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesurfacetooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSurfaceNearest;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSurfaceNearest : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcltee::Tecanvas::TButtonColor* ButtonColor2;
	Vcltee::Tecanvas::TButtonColor* ButtonColor3;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TCheckBox* CheckBox2;
	Vcl::Stdctrls::TCheckBox* CheckBox3;
	Vcl::Stdctrls::TCheckBox* CheckBox4;
	Vcl::Stdctrls::TCheckBox* CheckBox5;
	Vcl::Stdctrls::TCheckBox* CheckBox6;
	void __fastcall CheckBox1Click(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CheckBox2Click(System::TObject* Sender);
	void __fastcall CheckBox3Click(System::TObject* Sender);
	void __fastcall ButtonColor1Click(System::TObject* Sender);
	void __fastcall ButtonColor2Click(System::TObject* Sender);
	void __fastcall ButtonColor3Click(System::TObject* Sender);
	HIDESBASE void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall CheckBox4Click(System::TObject* Sender);
	void __fastcall CheckBox5Click(System::TObject* Sender);
	void __fastcall CheckBox6Click(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSurfaceNearest(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSurfaceNearest(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSurfaceNearest() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSurfaceNearest(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesurfacetooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESURFACETOOLEDITOR)
using namespace Vcltee::Teesurfacetooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesurfacetooleditorHPP
