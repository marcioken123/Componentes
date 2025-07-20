// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeRenkoSeriesEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeerenkoserieseditorHPP
#define Vcltee_TeerenkoserieseditorHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeRenkoSeries.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teerenkoserieseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRenkoSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRenkoSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TCheckBox* CBDraw3D;
	Vcltee::Tecanvas::TButtonColor* BUp;
	Vcltee::Tecanvas::TButtonColor* BDown;
	Vcl::Stdctrls::TEdit* EBoxSize;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	void __fastcall CBDraw3DClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall EBoxSizeChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	
private:
	Vcltee::Teerenkoseries::TRenkoSeries* Renko;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRenkoSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRenkoSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRenkoSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRenkoSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerenkoserieseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEERENKOSERIESEDITOR)
using namespace Vcltee::Teerenkoserieseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeerenkoserieseditorHPP
