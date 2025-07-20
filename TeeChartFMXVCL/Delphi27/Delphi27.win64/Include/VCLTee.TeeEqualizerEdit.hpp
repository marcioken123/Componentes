// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeEqualizerEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeequalizereditHPP
#define Vcltee_TeeequalizereditHPP

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
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeEqualizerSeries.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePoEdi.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeequalizeredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TEqualizerSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TEqualizerSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* lblDegradeInterval;
	Vcl::Comctrls::TUpDown* UDDegradeInt;
	Vcl::Stdctrls::TEdit* edDegradeInt;
	Vcl::Stdctrls::TLabel* LblDownStep;
	Vcl::Stdctrls::TEdit* EdDownStep;
	Vcl::Stdctrls::TCheckBox* cbxDegradeHigh;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall edDegradeIntChange(System::TObject* Sender);
	void __fastcall EdDownStepChange(System::TObject* Sender);
	void __fastcall cbxDegradeHighClick(System::TObject* Sender);
	
private:
	Vcltee::Teeequalizerseries::TEqualizerSeries* EqualizerSeries;
	Vcl::Forms::TCustomForm* FBarForm;
	Vcl::Forms::TCustomForm* FPointerForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TEqualizerSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TEqualizerSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TEqualizerSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TEqualizerSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TEqualizerSeriesEditor* EqualizerSeriesEditor;
}	/* namespace Teeequalizeredit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEEQUALIZEREDIT)
using namespace Vcltee::Teeequalizeredit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeequalizereditHPP
