// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeRotateToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeerotatetooleditorHPP
#define Vcltee_TeerotatetooleditorHPP

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
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teerotatetooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRotateToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRotateToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* LabelInertia;
	Vcl::Stdctrls::TCheckBox* CBInverted;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcltee::Tecanvas::TComboFlat* CBButton;
	Vcl::Stdctrls::TEdit* ESpeed;
	Vcl::Comctrls::TUpDown* UDSpeed;
	Vcl::Stdctrls::TScrollBar* SBInertia;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBCursor;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Extctrls::TImage* ImageCursor;
	Vcl::Buttons::TSpeedButton* SpeedButton1;
	Vcl::Comctrls::TTabSheet* TabOutline;
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBInvertedClick(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall CBButtonChange(System::TObject* Sender);
	void __fastcall ESpeedChange(System::TObject* Sender);
	void __fastcall SBInertiaChange(System::TObject* Sender);
	void __fastcall CBCursorChange(System::TObject* Sender);
	void __fastcall SpeedButton1Click(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TRotateTool* Tool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRotateToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRotateToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRotateToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRotateToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teerotatetooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEROTATETOOLEDITOR)
using namespace Vcltee::Teerotatetooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeerotatetooleditorHPP
