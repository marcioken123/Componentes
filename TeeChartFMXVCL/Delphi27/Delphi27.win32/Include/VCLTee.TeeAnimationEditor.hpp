// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAnimationEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeanimationeditorHPP
#define Vcltee_TeeanimationeditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Types.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Controls.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeGalleryPanel.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeAnimate.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeanimationeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAnimationEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAnimationEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabTiming;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label7;
	Vcltee::Tecanvas::TComboFlat* CBTiming;
	Vcltee::Teegallerypanel::TChartGalleryPanel* Gallery;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* LabelTitle;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EDuration;
	Vcl::Stdctrls::TEdit* EStartTime;
	Vcl::Stdctrls::TCheckBox* CBEnabled;
	Vcl::Stdctrls::TCheckBox* CBLoop;
	Vcl::Stdctrls::TEdit* ETitle;
	Vcl::Stdctrls::TCheckBox* CBTwoWay;
	Vcl::Stdctrls::TCheckBox* CBInverted;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBEasing;
	void __fastcall CBEnabledClick(System::TObject* Sender);
	void __fastcall CBLoopClick(System::TObject* Sender);
	void __fastcall EDurationChange(System::TObject* Sender);
	void __fastcall EStartTimeChange(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall ETitleChange(System::TObject* Sender);
	void __fastcall CBTimingChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall GalleryChangeChart(System::TObject* Sender);
	void __fastcall CBTwoWayClick(System::TObject* Sender);
	void __fastcall CBInvertedClick(System::TObject* Sender);
	void __fastcall CBEasingChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcltee::Teeanimate::TTeeAnimation* Animation;
	System::Classes::TNotifyEvent FOnChanged;
	Vcltee::Teeanimate::TTeeAnimation* IPointerAnim;
	void __fastcall CreateTimingGallery();
	void __fastcall DoChanged();
	void __fastcall PointerAnimFrame(Vcltee::Teeanimate::TTeeAnimation* Sender, const float Fraction);
	
public:
	void __fastcall RefreshAnimation(Vcltee::Teeanimate::TTeeAnimation* const AAnimation);
	__property System::Classes::TNotifyEvent OnChanged = {read=FOnChanged, write=FOnChanged};
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAnimationEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAnimationEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAnimationEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAnimationEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeanimationeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEANIMATIONEDITOR)
using namespace Vcltee::Teeanimationeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeanimationeditorHPP
