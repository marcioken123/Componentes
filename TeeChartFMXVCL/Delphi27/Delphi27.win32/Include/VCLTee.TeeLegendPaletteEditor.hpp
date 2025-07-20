// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLegendPaletteEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelegendpaletteeditorHPP
#define Vcltee_TeelegendpaletteeditorHPP

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
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeEdiPane.hpp>
#include <VCLTee.TeeEdiAxis.hpp>
#include <VCLTee.TeeLegendPalette.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelegendpaletteeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLegendPaletteEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLegendPaletteEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabPanel;
	Vcl::Extctrls::TRadioGroup* RGAxis;
	Vcl::Stdctrls::TCheckBox* CBTransp;
	Vcl::Stdctrls::TCheckBox* CBSmooth;
	Vcl::Stdctrls::TCheckBox* CBVertical;
	Vcl::Comctrls::TTabSheet* TabAxes;
	Vcl::Stdctrls::TCheckBox* CBInverted;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label13;
	Vcl::Stdctrls::TEdit* ECustLeft;
	Vcl::Comctrls::TUpDown* UDLeft;
	Vcl::Stdctrls::TEdit* ECustTop;
	Vcl::Comctrls::TUpDown* UDTop;
	Vcltee::Tecanvas::TComboFlat* CBUnits;
	Vcl::Comctrls::TTabSheet* TabSheet5;
	Vcl::Stdctrls::TLabel* Label14;
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TEdit* ECustWidth;
	Vcl::Stdctrls::TEdit* ECustHeight;
	Vcl::Comctrls::TUpDown* UDWidth;
	Vcl::Comctrls::TUpDown* UDHeight;
	Vcl::Comctrls::TTabSheet* TabLines;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPointer;
	Vcl::Comctrls::TTabSheet* TabTitles;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall RGAxisClick(System::TObject* Sender);
	void __fastcall CBTranspClick(System::TObject* Sender);
	void __fastcall CBSmoothClick(System::TObject* Sender);
	void __fastcall CBVerticalClick(System::TObject* Sender);
	void __fastcall CBInvertedClick(System::TObject* Sender);
	void __fastcall ECustLeftChange(System::TObject* Sender);
	void __fastcall ECustTopChange(System::TObject* Sender);
	void __fastcall CBUnitsChange(System::TObject* Sender);
	void __fastcall ECustWidthChange(System::TObject* Sender);
	void __fastcall ECustHeightChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Vcltee::Teeediaxis::TFormTeeAxis* IAxes;
	Vcltee::Teeedipane::TFormTeePanel* IPanel;
	bool CreatingForm;
	Vcltee::Teelegendpalette::TLegendPaletteTool* __fastcall LegendTool();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLegendPaletteEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLegendPaletteEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLegendPaletteEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLegendPaletteEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelegendpaletteeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELEGENDPALETTEEDITOR)
using namespace Vcltee::Teelegendpaletteeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelegendpaletteeditorHPP
