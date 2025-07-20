// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeErrBarEd.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeerrbaredHPP
#define Vcltee_TeeerrbaredHPP

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
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.ErrorBar.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeerrbared
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TErrorSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TErrorSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* SEBarwidth;
	Vcl::Extctrls::TRadioGroup* RGWidthUnit;
	Vcl::Comctrls::TUpDown* UDBarWidth;
	Vcl::Extctrls::TRadioGroup* RGStyle;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcltee::Tecanvas::TButtonColor* BColor;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SEBarwidthChange(System::TObject* Sender);
	void __fastcall RGWidthUnitClick(System::TObject* Sender);
	void __fastcall RGStyleClick(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall BColorClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Errorbar::TCustomErrorSeries* ErrorSeries;
	Vcl::Forms::TCustomForm* FBarForm;
	Vcltee::Teependlg::TPenDialog* IPenEditor;
	void __fastcall ChangedPen(System::TObject* Sender);
public:
	/* TCustomForm.Create */ inline __fastcall virtual TErrorSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TErrorSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TErrorSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TErrorSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeerrbared */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEERRBARED)
using namespace Vcltee::Teeerrbared;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeerrbaredHPP
