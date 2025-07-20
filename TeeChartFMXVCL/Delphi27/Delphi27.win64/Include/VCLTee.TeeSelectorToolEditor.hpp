// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSelectorToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeselectortooleditorHPP
#define Vcltee_TeeselectortooleditorHPP

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
#include <Vcl.Buttons.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeSelectorTool.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeselectortooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSelectorToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSelectorToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcltee::Teependlg::TButtonPen* ButtonPen1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDSize;
	Vcltee::Tecanvas::TButtonColor* ButtonColor1;
	Vcl::Stdctrls::TCheckBox* CBAllowDrag;
	Vcl::Stdctrls::TCheckBox* CBResizeChart;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBCursor;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall CBAllowDragClick(System::TObject* Sender);
	void __fastcall CBResizeChartClick(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	
private:
	Vcltee::Teeselectortool::TSelectorTool* Selector;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TSelectorToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TSelectorToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TSelectorToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TSelectorToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeselectortooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESELECTORTOOLEDITOR)
using namespace Vcltee::Teeselectortooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeselectortooleditorHPP
