// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeToolSeriesEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetoolserieseditHPP
#define Vcltee_TeetoolserieseditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
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
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetoolseriesedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSeriesToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBSeries;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
protected:
	Vcltee::Teengine::TTeeCustomToolSeries* Tool;
	void __fastcall FillSeries(Vcl::Stdctrls::TComboBox* const ACombo, Vcltee::Teengine::TChartSeriesClass AClass, Vcltee::Teengine::TChartSeries* ASeries, bool ClearCombo = true);
	void __fastcall FillSeriesCombo(Vcl::Stdctrls::TComboBox* ACombo, Vcltee::Teengine::TChartSeries* ASeries, Vcltee::Teengine::TCustomAxisPanel* AChart);
	Vcltee::Teengine::TChartSeries* __fastcall TheSeries();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSeriesToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSeriesToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSeriesToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSeriesToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetoolseriesedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETOOLSERIESEDIT)
using namespace Vcltee::Teetoolseriesedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetoolserieseditHPP
