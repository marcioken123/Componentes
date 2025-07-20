// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePVOFunction.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepvofunctionHPP
#define Vcltee_TeepvofunctionHPP

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
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeBaseFuncEdit.hpp>
#include <VCLTee.StatChar.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepvofunction
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPVOFuncEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPVOFuncEditor : public Vcltee::Teebasefuncedit::TBaseFunctionEditor
{
	typedef Vcltee::Teebasefuncedit::TBaseFunctionEditor inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EPeriod;
	Vcl::Comctrls::TUpDown* UDPeriod;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDPeriod2;
	Vcl::Stdctrls::TCheckBox* CBPercent;
	void __fastcall EPeriodChange(System::TObject* Sender);
	void __fastcall CBPercentClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TPVOFuncEditor(System::Classes::TComponent* AOwner) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TPVOFuncEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TPVOFuncEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TPVOFuncEditor(HWND ParentWindow) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepvofunction */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPVOFUNCTION)
using namespace Vcltee::Teepvofunction;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepvofunctionHPP
