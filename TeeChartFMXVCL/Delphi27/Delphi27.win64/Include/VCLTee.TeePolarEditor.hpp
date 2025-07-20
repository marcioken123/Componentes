// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePolarEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepolareditorHPP
#define Vcltee_TeepolareditorHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeePolar.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdiFont.hpp>
#include <VCLTee.TeeBrushDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepolareditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolarSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* LAngleInc;
	Vcl::Stdctrls::TLabel* Label8;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TCheckBox* CBClose;
	Vcl::Stdctrls::TEdit* SEAngleInc;
	Vcl::Stdctrls::TEdit* SERadiusInc;
	Vcltee::Tecanvas::TButtonColor* BColor;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBNulls;
	Vcl::Comctrls::TTabSheet* TabBack;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	Vcl::Comctrls::TTabSheet* TabPen;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Stdctrls::TCheckBox* CBDefColor;
	Vcl::Comctrls::TPageControl* PageControl3;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TTabSheet* TabLabelsFormat;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TCheckBox* CBAngleLabels;
	Vcl::Stdctrls::TCheckBox* CBLabelsRot;
	Vcl::Stdctrls::TCheckBox* CBClockWise;
	Vcl::Stdctrls::TCheckBox* CBInside;
	Vcl::Stdctrls::TEdit* EMargin;
	Vcl::Comctrls::TUpDown* UDMargin;
	Vcl::Stdctrls::TCheckBox* CBAntiOverlap;
	Vcl::Stdctrls::TCheckBox* CBEachLine;
	Vcl::Stdctrls::TCheckBox* CBPointerBehind;
	Vcl::Stdctrls::TLabel* LDrawStyle;
	Vcltee::Tecanvas::TComboFlat* CBDrawStyle;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBCloseClick(System::TObject* Sender);
	void __fastcall SEAngleIncChange(System::TObject* Sender);
	void __fastcall SERadiusIncChange(System::TObject* Sender);
	void __fastcall CBAngleLabelsClick(System::TObject* Sender);
	void __fastcall CBLabelsRotClick(System::TObject* Sender);
	void __fastcall CBClockWiseClick(System::TObject* Sender);
	void __fastcall CBInsideClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall EMarginChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall CBNullsChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBAntiOverlapClick(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall CBDefColorClick(System::TObject* Sender);
	void __fastcall BColorClick(System::TObject* Sender);
	void __fastcall PageControl3Change(System::TObject* Sender);
	void __fastcall CBEachLineClick(System::TObject* Sender);
	void __fastcall CBPointerBehindClick(System::TObject* Sender);
	void __fastcall CBDrawStyleChange(System::TObject* Sender);
	
private:
	Vcl::Forms::TCustomForm* PointerForm;
	Vcl::Forms::TCustomForm* FCircledForm;
	void __fastcall EnableLabels();
	
protected:
	Vcltee::Teepolar::TCustomPolarSeries* Polar;
	virtual Vcltee::Teepolar::TCustomPolarSeries* __fastcall CreatePolar();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPolarSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPolarSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPolarSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPolarSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepolareditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOLAREDITOR)
using namespace Vcltee::Teepolareditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepolareditorHPP
