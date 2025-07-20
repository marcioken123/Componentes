// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSeriesRegionEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeseriesregioneditorHPP
#define Vcltee_TeeseriesregioneditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeSeriesRegion.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeseriesregioneditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesRegionEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesRegionEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* ELower;
	Vcl::Stdctrls::TEdit* EUpper;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TCheckBox* CBUseOrigin;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EOrigin;
	Vcl::Stdctrls::TCheckBox* CBAutoBounds;
	Vcl::Stdctrls::TCheckBox* CBBehind;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	Vcl::Comctrls::TTabSheet* TabOrigin;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBBehindClick(System::TObject* Sender);
	void __fastcall CBUseOriginClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ELowerChange(System::TObject* Sender);
	void __fastcall EUpperChange(System::TObject* Sender);
	void __fastcall EOriginChange(System::TObject* Sender);
	void __fastcall CBAutoBoundsClick(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
public:
	bool CreatingForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesRegionEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesRegionEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesRegionEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSeriesRegionEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeseriesregioneditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESERIESREGIONEDITOR)
using namespace Vcltee::Teeseriesregioneditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeseriesregioneditorHPP
