// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeExtraLegendToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeextralegendtooleditorHPP
#define Vcltee_TeeextralegendtooleditorHPP

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
#include <Vcl.Buttons.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeEdiLege.hpp>
#include <VCLTee.TeeExtraLegendTool.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeextralegendtooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TExtraLegendEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TExtraLegendEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	
private:
	Vcltee::Teeedilege::TFormTeeLegend* LegendEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TExtraLegendEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TExtraLegendEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TExtraLegendEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TExtraLegendEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeextralegendtooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEXTRALEGENDTOOLEDITOR)
using namespace Vcltee::Teeextralegendtooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeextralegendtooleditorHPP
