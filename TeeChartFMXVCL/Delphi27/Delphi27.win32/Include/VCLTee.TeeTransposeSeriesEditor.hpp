// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTransposeSeriesEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetransposeserieseditorHPP
#define Vcltee_TeetransposeserieseditorHPP

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
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeTransposeSeries.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetransposeserieseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTransposeSeriesToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTransposeSeriesToolEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TButton* BTranspose;
	void __fastcall BTransposeClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	Vcltee::Teetransposeseries::TTransposeSeriesTool* Tool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TTransposeSeriesToolEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TTransposeSeriesToolEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TTransposeSeriesToolEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TTransposeSeriesToolEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetransposeserieseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETRANSPOSESERIESEDITOR)
using namespace Vcltee::Teetransposeserieseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetransposeserieseditorHPP
