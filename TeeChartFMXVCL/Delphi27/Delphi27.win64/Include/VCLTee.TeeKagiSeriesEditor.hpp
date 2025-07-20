// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeKagiSeriesEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeekagiserieseditorHPP
#define Vcltee_TeekagiserieseditorHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeKagiSeries.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teekagiserieseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TKagiSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TKagiSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabUp;
	Vcl::Comctrls::TTabSheet* TabBuy;
	Vcl::Comctrls::TTabSheet* TabSell;
	Vcl::Comctrls::TTabSheet* TabDown;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Teekagiseries::TKagiSeries* Kagi;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TKagiSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TKagiSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TKagiSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TKagiSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teekagiserieseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEKAGISERIESEDITOR)
using namespace Vcltee::Teekagiserieseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeekagiserieseditorHPP
