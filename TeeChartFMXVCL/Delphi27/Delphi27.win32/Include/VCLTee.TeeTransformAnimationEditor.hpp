// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTransformAnimationEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetransformanimationeditorHPP
#define Vcltee_TeetransformanimationeditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeAnimations.hpp>
#include <VCLTee.TeeAnimate.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetransformanimationeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTransformEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTransformEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBTranslate;
	Vcl::Stdctrls::TScrollBar* SBMaxZoom;
	Vcl::Stdctrls::TCheckBox* CBRotate;
	Vcltee::Tecanvas::TComboFlat* CBZoom;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBScale;
	Vcl::Comctrls::TTabSheet* TabGallery;
	Vcltee::Teegallerypanel::TChartGalleryPanel* Gallery;
	Vcl::Stdctrls::TCheckBox* CBUseBounds;
	Vcl::Stdctrls::TCheckBox* CBClip;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBTarget;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBSeries;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBAxes;
	Vcltee::Tecanvas::TComboFlat* CBFade;
	Vcl::Stdctrls::TLabel* Label7;
	void __fastcall CBTranslateChange(System::TObject* Sender);
	void __fastcall SBMaxZoomChange(System::TObject* Sender);
	void __fastcall CBRotateClick(System::TObject* Sender);
	void __fastcall CBZoomChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBScaleChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall GalleryChangeChart(System::TObject* Sender);
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall CBTargetChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBUseBoundsClick(System::TObject* Sender);
	void __fastcall CBClipClick(System::TObject* Sender);
	void __fastcall CBAxesChange(System::TObject* Sender);
	void __fastcall CBFadeChange(System::TObject* Sender);
	
private:
	Vcltee::Teeanimate::TTeeAnimate* IAnimate;
	void __fastcall CreateGallery();
	void __fastcall EnableCombos();
	void __fastcall PrepareControls();
	
protected:
	Vcltee::Teeanimations::TTransformAnimation* Animation;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTransformEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTransformEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTransformEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTransformEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetransformanimationeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETRANSFORMANIMATIONEDITOR)
using namespace Vcltee::Teetransformanimationeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetransformanimationeditorHPP
