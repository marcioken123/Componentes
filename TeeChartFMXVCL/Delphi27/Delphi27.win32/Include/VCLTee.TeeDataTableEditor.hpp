// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDataTableEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedatatableeditorHPP
#define Vcltee_TeedatatableeditorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeeDataTableTool.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeSymbolEditor.hpp>
#include <VCLTee.TeeEdiFont.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedatatableeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDataTableEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDataTableEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Comctrls::TPageControl* PageControl2;
	Vcl::Comctrls::TTabSheet* TabSheet4;
	Vcl::Comctrls::TTabSheet* TabSymbol;
	Vcl::Stdctrls::TCheckBox* CBLegVisible;
	Vcl::Comctrls::TTabSheet* TabText;
	Vcl::Comctrls::TTabSheet* TabLegendText;
	Vcl::Stdctrls::TCheckBox* CBInverted;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TCheckBox* CBAutoPos;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDLeft;
	Vcl::Comctrls::TUpDown* UDTop;
	Vcl::Stdctrls::TCheckBox* CBFontColor;
	Vcl::Stdctrls::TCheckBox* CBOtherSide;
	Vcl::Comctrls::TTabSheet* TabRows;
	Vcl::Comctrls::TTabSheet* TabColumns;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBAutoPosClick(System::TObject* Sender);
	void __fastcall CBLegVisibleClick(System::TObject* Sender);
	void __fastcall CBInvertedClick(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBFontColorClick(System::TObject* Sender);
	void __fastcall CBOtherSideClick(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Vcltee::Teedatatabletool::TDataTableTool* Table;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDataTableEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDataTableEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDataTableEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDataTableEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedatatableeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDATATABLEEDITOR)
using namespace Vcltee::Teedatatableeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedatatableeditorHPP
