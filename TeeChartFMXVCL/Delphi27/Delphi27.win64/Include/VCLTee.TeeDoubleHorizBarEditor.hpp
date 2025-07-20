// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDoubleHorizBarEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedoublehorizbareditorHPP
#define Vcltee_TeedoublehorizbareditorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeeDoubleHorizBar.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeEdit.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedoublehorizbareditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDoubleHorizBarEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDoubleHorizBarEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabLeft;
	Vcl::Comctrls::TTabSheet* TabRight;
	Vcl::Comctrls::TTabSheet* TabChart;
	Vcltee::Teeedit::TChartEditorPanel* ChartEditorPanel1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Comctrls::TTrackBar* TBSplit;
	Vcl::Stdctrls::TLabel* LSplit;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TCheckBox* CBHoriz;
	Vcl::Stdctrls::TCheckBox* CBVert;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* ELeft;
	Vcl::Stdctrls::TEdit* ERight;
	Vcltee::Tecanvas::TComboFlat* CBHorizAxis;
	Vcl::Stdctrls::TLabel* Label4;
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall TBSplitChange(System::TObject* Sender);
	void __fastcall CBVertClick(System::TObject* Sender);
	void __fastcall CBHorizClick(System::TObject* Sender);
	void __fastcall ERightChange(System::TObject* Sender);
	void __fastcall ELeftChange(System::TObject* Sender);
	void __fastcall CBHorizAxisChange(System::TObject* Sender);
	
private:
	Vcltee::Teedoublehorizbar::TDoubleHorizBarSeries* Bar;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDoubleHorizBarEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDoubleHorizBarEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDoubleHorizBarEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDoubleHorizBarEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedoublehorizbareditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDOUBLEHORIZBAREDITOR)
using namespace Vcltee::Teedoublehorizbareditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedoublehorizbareditorHPP
