// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCircularGaugeEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecirculargaugeeditorHPP
#define Vcltee_TeecirculargaugeeditorHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeLinearGauge.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeEdiGrad.hpp>
#include <VCLTee.TeeNumericGauge.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeLinearGaugeEditor.hpp>
#include <VCLTee.TeeCircularGauge.hpp>
#include <VCLTee.TeePoEdi.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecirculargaugeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCircularGaugeEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCircularGaugeEditor : public Vcltee::Teelineargaugeeditor::TLinearGaugeEditor
{
	typedef Vcltee::Teelineargaugeeditor::TLinearGaugeEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label15;
	Vcl::Stdctrls::TLabel* Label16;
	Vcl::Stdctrls::TEdit* EDisplayRotationAngle;
	Vcl::Stdctrls::TEdit* EDisplayTotalAngle;
	Vcl::Comctrls::TUpDown* UDDisplayRotationAngle;
	Vcl::Comctrls::TUpDown* UDDisplayTotalAngle;
	Vcl::Comctrls::TTabSheet* TabCircularFrame;
	Vcl::Comctrls::TTabSheet* TabCenter;
	Vcl::Comctrls::TTabSheet* TabFace2;
	Vcl::Comctrls::TTabSheet* TabEndPoint;
	Vcl::Stdctrls::TCheckBox* CBCircled;
	Vcl::Stdctrls::TCheckBox* CBRotateLabels;
	Vcl::Stdctrls::TCheckBox* CBLabelsInside;
	Vcl::Stdctrls::TListBox* LBHands;
	Vcl::Extctrls::TPanel* PanelLeftHands;
	Vcl::Extctrls::TPanel* PanelTopHands;
	Vcl::Buttons::TSpeedButton* BAddHand;
	Vcl::Buttons::TSpeedButton* BDeleteHand;
	Vcl::Extctrls::TPanel* PanelHands;
	Vcl::Extctrls::TPanel* PanelHand;
	Vcl::Stdctrls::TLabel* LabelHand;
	Vcl::Stdctrls::TEdit* EHandValue;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TEdit* EHandDistance;
	Vcl::Comctrls::TUpDown* UDHandDistance;
	Vcl::Stdctrls::TLabel* Label21;
	Vcl::Stdctrls::TEdit* EHandOffset;
	Vcl::Comctrls::TUpDown* UDHandOffset;
	Vcltee::Tecanvas::TComboFlat* CBHandStyle;
	Vcl::Stdctrls::TLabel* LRotationAngle;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Comctrls::TUpDown* UDRotAngle;
	Vcl::Stdctrls::TEdit* ETotalAngle;
	Vcl::Comctrls::TUpDown* UDTotalAngle;
	Vcl::Stdctrls::TLabel* LTotalAngle;
	Vcl::Extctrls::TPanel* PanelClock;
	Vcl::Stdctrls::TLabel* Label11;
	Vcltee::Tecanvas::TComboFlat* ComboClock;
	Vcl::Stdctrls::TCheckBox* CBSnap;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBLabelsInsideClick(System::TObject* Sender);
	void __fastcall CBRotateLabelsClick(System::TObject* Sender);
	void __fastcall ETotalAngleChange(System::TObject* Sender);
	void __fastcall CBCircledClick(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall EDisplayRotationAngleChange(System::TObject* Sender);
	void __fastcall EDisplayTotalAngleChange(System::TObject* Sender);
	HIDESBASE void __fastcall SetColor(const System::Uitypes::TColor aColor);
	HIDESBASE void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall LBHandsClick(System::TObject* Sender);
	void __fastcall EHandValueChange(System::TObject* Sender);
	void __fastcall BAddHandClick(System::TObject* Sender);
	HIDESBASE void __fastcall BDeleteRangeClick(System::TObject* Sender);
	void __fastcall EHandDistanceChange(System::TObject* Sender);
	void __fastcall EHandOffsetChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBHandStyleChange(System::TObject* Sender);
	void __fastcall ComboClockChange(System::TObject* Sender);
	void __fastcall CBSnapClick(System::TObject* Sender);
	
private:
	Vcltee::Teepoedi::TSeriesPointerEditor* IHandEditor;
	Vcltee::Teecirculargauge::TCircularGauge* __fastcall CircularGauge();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCircularGaugeEditor(System::Classes::TComponent* AOwner) : Vcltee::Teelineargaugeeditor::TLinearGaugeEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCircularGaugeEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teelineargaugeeditor::TLinearGaugeEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCircularGaugeEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCircularGaugeEditor(HWND ParentWindow) : Vcltee::Teelineargaugeeditor::TLinearGaugeEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecirculargaugeeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECIRCULARGAUGEEDITOR)
using namespace Vcltee::Teecirculargaugeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecirculargaugeeditorHPP
