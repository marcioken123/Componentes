// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeHighLowEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeehighloweditHPP
#define Vcltee_TeehighloweditHPP

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
#include <VCLTee.ErrorBar.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teehighlowedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THighLowEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THighLowEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabHigh;
	Vcl::Comctrls::TTabSheet* TabLow;
	Vcl::Comctrls::TPageControl* PageHigh;
	Vcl::Comctrls::TTabSheet* TabHighBorder;
	Vcl::Comctrls::TTabSheet* TabHighPattern;
	Vcl::Comctrls::TPageControl* PageLow;
	Vcl::Comctrls::TTabSheet* TabLowBorder;
	Vcl::Comctrls::TTabSheet* TabLowPattern;
	Vcl::Comctrls::TTabSheet* TabLines;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcltee::Tecanvas::TButtonColor* BColor;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall PageHighChange(System::TObject* Sender);
	void __fastcall PageLowChange(System::TObject* Sender);
	
private:
	Vcltee::Errorbar::THighLowSeries* HighLow;
public:
	/* TCustomForm.Create */ inline __fastcall virtual THighLowEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual THighLowEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~THighLowEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall THighLowEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teehighlowedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEHIGHLOWEDIT)
using namespace Vcltee::Teehighlowedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeehighloweditHPP
