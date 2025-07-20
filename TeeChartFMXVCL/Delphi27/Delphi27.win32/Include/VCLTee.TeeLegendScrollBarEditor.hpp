// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLegendScrollBarEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelegendscrollbareditorHPP
#define Vcltee_TeelegendscrollbareditorHPP

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
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.Buttons.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeEdiGrad.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelegendscrollbareditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TScrollbarEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TScrollbarEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TCheckBox* CBAuto;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDSize;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDDelay;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabBack;
	Vcl::Comctrls::TTabSheet* TabArrows;
	Vcl::Extctrls::TPanel* Panel1;
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcl::Comctrls::TPageControl* PageThumb;
	Vcl::Comctrls::TTabSheet* TabThumbOptions;
	Vcl::Comctrls::TTabSheet* TabThumbBorder;
	Vcl::Stdctrls::TLabel* LThumbSize;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* EThumbSize;
	Vcl::Comctrls::TUpDown* UDThumbSize;
	Vcltee::Tecanvas::TComboFlat* CBBevel;
	Vcl::Comctrls::TTabSheet* TabDisabled;
	Vcl::Stdctrls::TCheckBox* CBArrows;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Comctrls::TTabSheet* TabThumbPattern;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* ERoundSize;
	Vcl::Comctrls::TUpDown* UDRoundSize;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBBevelChange(System::TObject* Sender);
	void __fastcall CBAutoClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall EThumbSizeChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall PageControl2Change(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PageThumbChange(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBArrowsClick(System::TObject* Sender);
	void __fastcall ERoundSizeChange(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TTeeScrollBar* TeeScroll;
	
public:
	void __fastcall HideThumbSize();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TScrollbarEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TScrollbarEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TScrollbarEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TScrollbarEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelegendscrollbareditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELEGENDSCROLLBAREDITOR)
using namespace Vcltee::Teelegendscrollbareditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelegendscrollbareditorHPP
