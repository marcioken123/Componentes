// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCurveFittingEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecurvefittingeditorHPP
#define Vcltee_TeecurvefittingeditorHPP

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
#include <Vcl.ExtCtrls.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.CurvFitt.hpp>
#include <VCLTee.TeeBaseFuncEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecurvefittingeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCurveFittingEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCurveFittingEditor : public Vcltee::Teebasefuncedit::TBaseFunctionEditor
{
	typedef Vcltee::Teebasefuncedit::TBaseFunctionEditor inherited;
	
__published:
	Vcl::Stdctrls::TGroupBox* GroupBox1;
	Vcl::Stdctrls::TGroupBox* GroupBox2;
	Vcl::Stdctrls::TGroupBox* GroupBox3;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDDegree;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDFactor;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TEdit* Edit3;
	Vcl::Comctrls::TUpDown* UDFirstCalc;
	Vcl::Stdctrls::TEdit* Edit4;
	Vcl::Comctrls::TUpDown* UDLastCalc;
	Vcl::Stdctrls::TLabel* Label5;
	Vcl::Stdctrls::TLabel* Label6;
	Vcl::Stdctrls::TEdit* Edit5;
	Vcl::Comctrls::TUpDown* UDFirst;
	Vcl::Stdctrls::TEdit* Edit6;
	Vcl::Comctrls::TUpDown* UDLast;
	Vcl::Stdctrls::TCheckBox* CBAllCalc;
	Vcl::Stdctrls::TCheckBox* CBAllDisp;
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall Edit3Change(System::TObject* Sender);
	void __fastcall Edit4Change(System::TObject* Sender);
	void __fastcall Edit5Change(System::TObject* Sender);
	void __fastcall Edit6Change(System::TObject* Sender);
	void __fastcall CBAllCalcClick(System::TObject* Sender);
	void __fastcall CBAllDispClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCurveFittingEditor(System::Classes::TComponent* AOwner) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCurveFittingEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCurveFittingEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCurveFittingEditor(HWND ParentWindow) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecurvefittingeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECURVEFITTINGEDITOR)
using namespace Vcltee::Teecurvefittingeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecurvefittingeditorHPP
