// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTreeMapSeriesEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetreemapserieseditorHPP
#define Vcltee_TeetreemapserieseditorHPP

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
#include <System.Math.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeComma.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeCustomShapeEditor.hpp>
#include <VCLTee.TeeStringsEditor.hpp>
#include <VCLTee.TeeMargins.hpp>
#include <VCLTee.TeeOrgSeries.hpp>
#include <VCLTee.TeeOrgSeriesEditor.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeeGriEd.hpp>
#include <VCLTee.TeeTreeMapSeries.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetreemapserieseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTreeMapSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTreeMapSeriesEditor : public Vcltee::Teeorgserieseditor::TOrgSeriesEditor
{
	typedef Vcltee::Teeorgserieseditor::TOrgSeriesEditor inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* Options;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* LTiling;
	Vcl::Stdctrls::TLabel* LTextAlign;
	Vcltee::Tecanvas::TComboFlat* CBTilingStyle;
	Vcltee::Tecanvas::TComboFlat* ComboFlat2;
	Vcl::Stdctrls::TCheckBox* CBoxColorEach;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBColorStyle;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* EValue;
	Vcl::Comctrls::TTabSheet* TabPalette;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBTilingStyleChange(System::TObject* Sender);
	void __fastcall CBoxColorEachClick(System::TObject* Sender);
	void __fastcall ComboFlat2Change(System::TObject* Sender);
	HIDESBASE void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBColorStyleChange(System::TObject* Sender);
	void __fastcall EValueChange(System::TObject* Sender);
	
private:
	Vcltee::Teegried::TGrid3DSeriesEditor* I3DEditor;
	
protected:
	virtual void __fastcall SetItemProperties(int Index);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTreeMapSeriesEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeorgserieseditor::TOrgSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTreeMapSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeorgserieseditor::TOrgSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTreeMapSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTreeMapSeriesEditor(HWND ParentWindow) : Vcltee::Teeorgserieseditor::TOrgSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetreemapserieseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETREEMAPSERIESEDITOR)
using namespace Vcltee::Teetreemapserieseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetreemapserieseditorHPP
