// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeWorldSeriesEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeworldserieseditorHPP
#define Vcltee_TeeworldserieseditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeMapSeries.hpp>
#include <VCLTee.TeeMapSeriesEdit.hpp>
#include <VCLTee.TeeLisB.hpp>
#include <VCLTee.TeeNavigator.hpp>
#include <VCLTee.TeeChartGrid.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeWorldSeries.hpp>
#include <VCLTee.TeeGDIPlus.hpp>
#include <VCLTee.TeeDragPoint.hpp>
#include <VCLTee.TeeTools.hpp>
#include <Vcl.Forms.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeworldserieseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TWorldSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TWorldSeriesEditor : public Vcltee::Teemapseriesedit::TMapSeriesEditor
{
	typedef Vcltee::Teemapseriesedit::TMapSeriesEditor inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBKeepAspect;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TCheckBox* CBFlags;
	Vcl::Stdctrls::TCheckBox* CBStates;
	Vcl::Stdctrls::TCheckBox* CBCities;
	Vcl::Extctrls::TPanel* PanelLeftHeader;
	Vcl::Stdctrls::TLabel* LMap;
	Vcl::Stdctrls::TListBox* LWorldMap;
	Vcl::Stdctrls::TLabel* Label10;
	Vcltee::Tecanvas::TComboFlat* CBCitiesSize;
	Vcl::Stdctrls::TEdit* ECitySize;
	Vcl::Comctrls::TUpDown* UDCitySize;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBKeepAspectClick(System::TObject* Sender);
	void __fastcall CBFlagsClick(System::TObject* Sender);
	void __fastcall CBStatesClick(System::TObject* Sender);
	void __fastcall CBCitiesClick(System::TObject* Sender);
	void __fastcall LWorldMapClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBCitiesSizeChange(System::TObject* Sender);
	void __fastcall ECitySizeChange(System::TObject* Sender);
	
private:
	bool PreparedMapList;
	HIDESBASE void __fastcall Refresh(Vcltee::Teeworldseries::TWorldSeries* const AMap);
	Vcltee::Teeworldseries::TWorldSeries* __fastcall World();
	
public:
	__classmethod void __fastcall PrepareWorldMapListBox(System::Classes::TStrings* const AItems);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TWorldSeriesEditor(System::Classes::TComponent* AOwner) : Vcltee::Teemapseriesedit::TMapSeriesEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TWorldSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teemapseriesedit::TMapSeriesEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TWorldSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TWorldSeriesEditor(HWND ParentWindow) : Vcltee::Teemapseriesedit::TMapSeriesEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeworldserieseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEWORLDSERIESEDITOR)
using namespace Vcltee::Teeworldserieseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeworldserieseditorHPP
