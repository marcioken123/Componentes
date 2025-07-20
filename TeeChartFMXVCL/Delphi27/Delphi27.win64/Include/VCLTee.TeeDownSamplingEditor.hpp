// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeDownSamplingEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeedownsamplingeditorHPP
#define Vcltee_TeedownsamplingeditorHPP

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
#include <VCLTee.TeeBaseFuncEdit.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <VCLTee.TeeDownSampling.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teedownsamplingeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TDownSamplingEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TDownSamplingEditor : public Vcltee::Teebasefuncedit::TBaseFunctionEditor
{
	typedef Vcltee::Teebasefuncedit::TBaseFunctionEditor inherited;
	
__published:
	Vcl::Extctrls::TRadioGroup* RGMethod;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* ETolerance;
	Vcl::Comctrls::TUpDown* UDTolerance;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TLabel* LReduced;
	void __fastcall RGMethodClick(System::TObject* Sender);
	void __fastcall EToleranceChange(System::TObject* Sender);
	
private:
	Vcltee::Teedownsampling::TDownSamplingFunction* __fastcall DownSampling();
	void __fastcall SetLabelReduced();
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TDownSamplingEditor(System::Classes::TComponent* AOwner) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TDownSamplingEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TDownSamplingEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TDownSamplingEditor(HWND ParentWindow) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teedownsamplingeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEDOWNSAMPLINGEDITOR)
using namespace Vcltee::Teedownsamplingeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeedownsamplingeditorHPP
