// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLinearGaugeEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelineargaugeeditorHPP
#define Vcltee_TeelineargaugeeditorHPP

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
#include <VCLTee.TeeNumericGauge.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeCustomShapeEditor.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeProCo.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeNumericGaugeEditor.hpp>
#include <VCLTee.TeeLinearGauge.hpp>
#include <VCLTee.TeePoEdi.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelineargaugeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLinearGaugeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLinearGaugeEditor : public Vcltee::Teenumericgaugeeditor::TNumericGaugeEditor
{
	typedef Vcltee::Teenumericgaugeeditor::TNumericGaugeEditor inherited;
	
__published:
	Vcl::Comctrls::TTabSheet* TabAxis;
	Vcl::Comctrls::TTabSheet* TabRanges;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabTicks;
	Vcl::Comctrls::TTabSheet* TabLabels;
	Vcl::Comctrls::TTabSheet* TabTitle;
	Vcl::Extctrls::TPanel* PanelRanges;
	Vcl::Extctrls::TPanel* Panel3;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* EFormat;
	Vcl::Stdctrls::TCheckBox* CBLabels;
	Vcl::Comctrls::TTabSheet* TabArea;
	Vcl::Comctrls::TTabSheet* TabMax;
	Vcl::Comctrls::TTabSheet* TabHand;
	Vcl::Comctrls::TTabSheet* TabAxisPen;
	Vcl::Comctrls::TTabSheet* TabMinor;
	Vcl::Extctrls::TPanel* Panel4;
	Vcl::Stdctrls::TEdit* EMinor;
	Vcl::Comctrls::TUpDown* UDMinorCount;
	Vcl::Stdctrls::TEdit* EMinLength;
	Vcl::Comctrls::TUpDown* UDMinorSize;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label18;
	Vcl::Comctrls::TTabSheet* TabMinMax;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label17;
	Vcl::Stdctrls::TEdit* EMax;
	Vcl::Stdctrls::TEdit* EMin;
	Vcl::Stdctrls::TEdit* EIncr;
	Vcl::Extctrls::TPanel* Panel5;
	Vcl::Stdctrls::TEdit* ETicks;
	Vcl::Comctrls::TUpDown* UDTicks;
	Vcl::Stdctrls::TEdit* ETicksDist;
	Vcl::Comctrls::TUpDown* UDTicksDist;
	Vcl::Stdctrls::TLabel* Label19;
	Vcl::Stdctrls::TLabel* Label20;
	Vcl::Extctrls::TPanel* PanelRange;
	Vcl::Stdctrls::TListBox* LBRanges;
	Vcl::Extctrls::TPanel* Panel6;
	Vcl::Extctrls::TPanel* PanelRangeValues;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TEdit* EStartRange;
	Vcl::Stdctrls::TEdit* EEndRange;
	Vcl::Comctrls::TUpDown* UDStartRange;
	Vcl::Comctrls::TUpDown* UDEndRange;
	Vcl::Buttons::TSpeedButton* SBAddRange;
	Vcl::Buttons::TSpeedButton* BDeleteRange;
	Vcl::Stdctrls::TCheckBox* CBSpiralled;
	Vcl::Stdctrls::TLabel* Label12;
	Vcl::Stdctrls::TEdit* ERangePos;
	Vcl::Comctrls::TUpDown* UDRangePos;
	Vcl::Extctrls::TPanel* Panel2;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* EAxisTitle;
	Vcl::Stdctrls::TCheckBox* CBUseColorPalette;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBLabelsClick(System::TObject* Sender);
	void __fastcall Button3Click(System::TObject* Sender);
	void __fastcall EFormatChange(System::TObject* Sender);
	void __fastcall EStartRangeChange(System::TObject* Sender);
	void __fastcall EEndRangeChange(System::TObject* Sender);
	void __fastcall EMinChange(System::TObject* Sender);
	void __fastcall EMaxChange(System::TObject* Sender);
	void __fastcall EMinLengthChange(System::TObject* Sender);
	void __fastcall EMinorChange(System::TObject* Sender);
	void __fastcall ETicksChange(System::TObject* Sender);
	void __fastcall ETicksDistChange(System::TObject* Sender);
	void __fastcall EIncrChange(System::TObject* Sender);
	void __fastcall PageControl3Change(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall LBRangesClick(System::TObject* Sender);
	void __fastcall SBAddRangeClick(System::TObject* Sender);
	void __fastcall BDeleteRangeClick(System::TObject* Sender);
	void __fastcall CBSpiralledClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ERangePosChange(System::TObject* Sender);
	void __fastcall EAxisTitleChange(System::TObject* Sender);
	void __fastcall CBUseColorPaletteClick(System::TObject* Sender);
	
private:
	Vcltee::Teepoedi::TSeriesPointerEditor* IRangeEditor;
	Vcltee::Teelineargauge::TCustomGaugeMinMax* __fastcall CustomGauge();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TLinearGaugeEditor(System::Classes::TComponent* AOwner) : Vcltee::Teenumericgaugeeditor::TNumericGaugeEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TLinearGaugeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teenumericgaugeeditor::TNumericGaugeEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TLinearGaugeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLinearGaugeEditor(HWND ParentWindow) : Vcltee::Teenumericgaugeeditor::TNumericGaugeEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelineargaugeeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELINEARGAUGEEDITOR)
using namespace Vcltee::Teelineargaugeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelineargaugeeditorHPP
