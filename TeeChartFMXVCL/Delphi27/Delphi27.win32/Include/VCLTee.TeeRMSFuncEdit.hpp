// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeRMSFuncEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeermsfunceditHPP
#define Vcltee_TeermsfunceditHPP

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
#include <VCLTee.TeeEdiPeri.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teermsfuncedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TRMSFuncEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TRMSFuncEditor : public Vcltee::Teeediperi::TTeeFunctionEditor
{
	typedef Vcltee::Teeediperi::TTeeFunctionEditor inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CBComplete;
	void __fastcall CBCompleteClick(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TRMSFuncEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeediperi::TTeeFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TRMSFuncEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeediperi::TTeeFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TRMSFuncEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TRMSFuncEditor(HWND ParentWindow) : Vcltee::Teeediperi::TTeeFunctionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teermsfuncedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEERMSFUNCEDIT)
using namespace Vcltee::Teermsfuncedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeermsfunceditHPP
