// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeColorGridEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecolorgrideditorHPP
#define Vcltee_TeecolorgrideditorHPP

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
#include <Vcl.ExtDlgs.hpp>
#include <VCLTee.TeeGriEd.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeSurfa.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecolorgrideditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TColorGridEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TColorGridEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabGrid;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TCheckBox* CBSmooth;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Comctrls::TUpDown* UDPosition;
	Vcltee::Tecanvas::TComboFlat* CBPlane;
	Vcl::Stdctrls::TCheckBox* CBCentered;
	Vcl::Stdctrls::TButton* Button2;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Comctrls::TUpDown* UDTransp;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Comctrls::TTabSheet* TabFrame;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDX;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDZ;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBCenteredClick(System::TObject* Sender);
	void __fastcall Button2Click(System::TObject* Sender);
	void __fastcall CBSmoothClick(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall CBPlaneChange(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	
private:
	bool Creating;
	Vcltee::Teesurfa::TColorGridSeries* ColorGrid;
	Vcltee::Teegried::TGrid3DSeriesEditor* Grid3DForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TColorGridEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColorGridEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColorGridEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TColorGridEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecolorgrideditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECOLORGRIDEDITOR)
using namespace Vcltee::Teecolorgrideditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecolorgrideditorHPP
