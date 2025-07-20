// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePointFigure.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepointfigureHPP
#define Vcltee_TeepointfigureHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.OHLChart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepointfigure
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPointFigureEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPointFigureEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EBoxSize;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EReversal;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall EBoxSizeChange(System::TObject* Sender);
	void __fastcall EReversalChange(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	
private:
	Vcl::Forms::TCustomForm* UpForm;
	Vcl::Forms::TCustomForm* DownForm;
	Vcltee::Ohlchart::TPointFigureSeries* PointFigure;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPointFigureEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPointFigureEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPointFigureEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPointFigureEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepointfigure */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOINTFIGURE)
using namespace Vcltee::Teepointfigure;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepointfigureHPP
