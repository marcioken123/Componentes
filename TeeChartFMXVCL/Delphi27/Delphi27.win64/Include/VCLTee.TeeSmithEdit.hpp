// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSmithEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesmitheditHPP
#define Vcltee_TeesmitheditHPP

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
#include <VCLTee.TeeSmith.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeBrushDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesmithedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSmithSeriesEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSmithSeriesEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabPointer;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabBack;
	Vcl::Comctrls::TTabSheet* TabCircle;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TCheckBox* CBC;
	Vcl::Stdctrls::TCheckBox* CBR;
	Vcltee::Teependlg::TButtonPen* BCPen;
	Vcltee::Teependlg::TButtonPen* BRPen;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	Vcl::Stdctrls::TButton* BCFont;
	Vcl::Stdctrls::TButton* BRFont;
	Vcl::Stdctrls::TEdit* EImag;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* LTransp;
	Vcltee::Tecanvas::TComboFlat* CBNulls;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TCheckBox* CBPointerBehind;
	Vcl::Stdctrls::TLabel* LDrawStyle;
	Vcltee::Tecanvas::TComboFlat* CBDrawStyle;
	Vcl::Stdctrls::TCheckBox* CBEachLine;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBCClick(System::TObject* Sender);
	void __fastcall CBRClick(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall BCFontClick(System::TObject* Sender);
	void __fastcall BRFontClick(System::TObject* Sender);
	void __fastcall EImagChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	void __fastcall CBNullsChange(System::TObject* Sender);
	void __fastcall CBPointerBehindClick(System::TObject* Sender);
	void __fastcall CBDrawStyleChange(System::TObject* Sender);
	void __fastcall CBEachLineClick(System::TObject* Sender);
	
public:
	Vcl::Forms::TCustomForm* CircledForm;
	Vcltee::Teesmith::TSmithSeries* Smith;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSmithSeriesEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSmithSeriesEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSmithSeriesEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSmithSeriesEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesmithedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESMITHEDIT)
using namespace Vcltee::Teesmithedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesmitheditHPP
