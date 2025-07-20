// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePo3DEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_Teepo3deditHPP
#define Vcltee_Teepo3deditHPP

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
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeePoin3.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepo3dedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPoint3DSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPoint3DSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabLine;
	Vcl::Comctrls::TTabSheet* TabBaseLine;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* LTransp;
	Vcl::Stdctrls::TGroupBox* GPLine;
	Vcltee::Tecanvas::TButtonColor* BColor;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TEdit* SEPointDepth;
	Vcl::Comctrls::TUpDown* UDPointDepth;
	Vcl::Comctrls::TTrackBar* TBTransp;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall SEPointDepthChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcl::Forms::TCustomForm* Grid3DForm;
	Vcl::Forms::TCustomForm* PointerForm;
	Vcltee::Teepoin3::TPoint3DSeries* TheSeries;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPoint3DSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPoint3DSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPoint3DSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPoint3DSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepo3dedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPO3DEDIT)
using namespace Vcltee::Teepo3dedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_Teepo3deditHPP
