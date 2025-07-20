// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeImaEd.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeimaedHPP
#define Vcltee_TeeimaedHPP

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
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.ImageBar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeimaed
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TImageBarSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TImageBarSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Extctrls::TImage* Image1;
	Vcl::Stdctrls::TButton* BBrowse;
	Vcl::Stdctrls::TCheckBox* CBTiled;
	Vcl::Extctrls::TBevel* Bevel1;
	Vcl::Stdctrls::TButton* Button1;
	Vcl::Stdctrls::TCheckBox* CBTransp;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Extctrls::TTimer* Timer1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall BBrowseClick(System::TObject* Sender);
	void __fastcall CBTiledClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall CBTranspClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall Timer1Timer(System::TObject* Sender);
	
private:
	Vcltee::Imagebar::TImageBarSeries* ImageBarSeries;
	Vcl::Forms::TCustomForm* FBarForm;
	void __fastcall EnableImageControls();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TImageBarSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TImageBarSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TImageBarSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TImageBarSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeimaed */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEIMAED)
using namespace Vcltee::Teeimaed;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeimaedHPP
