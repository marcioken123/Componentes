// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePyramidEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepyramideditHPP
#define Vcltee_TeepyramideditHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeePyramid.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepyramidedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPyramidSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPyramidSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcltee::Tecanvas::TButtonColor* BColor;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDSize;
	Vcl::Stdctrls::TCheckBox* CBDefColor;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Comctrls::TTrackBar* TBTransp;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBDefColorClick(System::TObject* Sender);
	void __fastcall BColorClick(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	
private:
	Vcltee::Teepyramid::TPyramidSeries* Pyramid;
	void __fastcall CheckDefColor();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPyramidSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPyramidSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPyramidSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPyramidSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepyramidedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPYRAMIDEDIT)
using namespace Vcltee::Teepyramidedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepyramideditHPP
