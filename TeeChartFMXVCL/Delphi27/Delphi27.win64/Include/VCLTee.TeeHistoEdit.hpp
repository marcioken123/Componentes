// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeHistoEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeehistoeditHPP
#define Vcltee_TeehistoeditHPP

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
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.StatChar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teehistoedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THistogramSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THistogramSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabLines;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcltee::Tecanvas::TButtonColor* BAreaColor;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDTransp;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TCheckBox* CBUseOrigin;
	Vcl::Stdctrls::TEdit* EOrigin;
	Vcl::Comctrls::TUpDown* UDOrigin;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBUseOriginClick(System::TObject* Sender);
	void __fastcall EOriginChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Vcltee::Statchar::THistogramSeries* TheSeries;
	void __fastcall EnableOrigin();
public:
	/* TCustomForm.Create */ inline __fastcall virtual THistogramSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual THistogramSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~THistogramSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THistogramSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teehistoedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEHISTOEDIT)
using namespace Vcltee::Teehistoedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeehistoeditHPP
