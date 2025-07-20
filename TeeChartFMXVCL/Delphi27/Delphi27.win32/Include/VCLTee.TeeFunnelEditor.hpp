// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeFunnelEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeefunneleditorHPP
#define Vcltee_TeefunneleditorHPP

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
#include <VCLTee.TeeFunnel.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teefunneleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TFunnelSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TFunnelSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcltee::Teependlg::TButtonPen* ButtonPen1;
	Vcltee::Teependlg::TButtonPen* ButtonPen2;
	Vcl::Stdctrls::TButton* Button1;
	Vcltee::Tecanvas::TButtonColor* AboveColor;
	Vcltee::Tecanvas::TButtonColor* WithinColor;
	Vcltee::Tecanvas::TButtonColor* BelowColor;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* DifLimit;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall Button1Click(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	
private:
	Vcltee::Teefunnel::TFunnelSeries* Funnel;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TFunnelSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TFunnelSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TFunnelSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TFunnelSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teefunneleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEFUNNELEDITOR)
using namespace Vcltee::Teefunneleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeefunneleditorHPP
