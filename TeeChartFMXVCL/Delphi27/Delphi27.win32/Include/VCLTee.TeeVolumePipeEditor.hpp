// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeVolumePipeEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeevolumepipeeditorHPP
#define Vcltee_TeevolumepipeeditorHPP

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
#include <VCLTee.TeeVolumePipe.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teevolumepipeeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TVolumePipeSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TVolumePipeSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabLines;
	Vcl::Comctrls::TTabSheet* TabPattern;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UpDown1;
	Vcl::Stdctrls::TCheckBox* CheckGradient;
	Vcl::Stdctrls::TLabel* Label2;
	Vcltee::Tecanvas::TComboFlat* CBDirection;
	Vcl::Stdctrls::TCheckBox* CheckBox1;
	Vcl::Stdctrls::TLabel* LHeight;
	Vcl::Comctrls::TTrackBar* TBTransp;
	Vcl::Stdctrls::TLabel* LTransp;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CheckBox1Click(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall CheckGradientClick(System::TObject* Sender);
	void __fastcall CBDirectionChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall TBTranspChange(System::TObject* Sender);
	
private:
	Vcltee::Teevolumepipe::TVolumePipeSeries* VolumePipe;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TVolumePipeSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TVolumePipeSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TVolumePipeSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TVolumePipeSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teevolumepipeeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEVOLUMEPIPEEDITOR)
using namespace Vcltee::Teevolumepipeeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeevolumepipeeditorHPP
