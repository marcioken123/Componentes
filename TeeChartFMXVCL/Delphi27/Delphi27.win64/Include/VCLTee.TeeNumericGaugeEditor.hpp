// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeNumericGaugeEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeenumericgaugeeditorHPP
#define Vcltee_TeenumericgaugeeditorHPP

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
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.StrUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeEditTools.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeNumericGauge.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teenumericgaugeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TMarkersEditor;
class DELPHICLASS TNumericGaugeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TMarkersEditor : public Vcltee::Teeedittools::TFormTeeTools
{
	typedef Vcltee::Teeedittools::TFormTeeTools inherited;
	
protected:
	virtual Vcltee::Teengine::TTeeCustomTool* __fastcall CloneTool(Vcltee::Teengine::TTeeCustomTool* const Tool);
	virtual Vcltee::Teengine::TTeeCustomTool* __fastcall GetNewTool();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TMarkersEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeedittools::TFormTeeTools(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TMarkersEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeedittools::TFormTeeTools(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TMarkersEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TMarkersEditor(HWND ParentWindow) : Vcltee::Teeedittools::TFormTeeTools(ParentWindow) { }
	
};


class PASCALIMPLEMENTATION TNumericGaugeEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabMarkers;
	Vcl::Comctrls::TTabSheet* TabFrame;
	Vcl::Comctrls::TTabSheet* TabFace;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Buttons::TSpeedButton* SpeedButton2;
	Vcl::Stdctrls::TEdit* EValue;
	Vcltee::Tecanvas::TComboFlat* CBPalette;
	Vcl::Extctrls::TPanel* PanelDigitalFont;
	Vcl::Extctrls::TRadioGroup* RGFont;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall RGFontClick(System::TObject* Sender);
	void __fastcall CBPaletteChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall SpeedButton2Click(System::TObject* Sender);
	void __fastcall EValueChange(System::TObject* Sender);
	void __fastcall BBrushClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	TMarkersEditor* Tools;
	void __fastcall IncValue(int Delta);
	
protected:
	Vcltee::Teenumericgauge::TCustomGauge* Gauge;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TNumericGaugeEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TNumericGaugeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TNumericGaugeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TNumericGaugeEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teenumericgaugeeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEENUMERICGAUGEEDITOR)
using namespace Vcltee::Teenumericgaugeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeenumericgaugeeditorHPP
