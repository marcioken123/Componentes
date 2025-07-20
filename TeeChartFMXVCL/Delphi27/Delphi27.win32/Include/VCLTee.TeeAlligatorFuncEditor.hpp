// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeAlligatorFuncEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeealligatorfunceditorHPP
#define Vcltee_TeealligatorfunceditorHPP

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
#include <VCLTee.StatChar.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeBaseFuncEdit.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teealligatorfunceditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TAlligatorFuncEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TAlligatorFuncEditor : public Vcltee::Teebasefuncedit::TBaseFunctionEditor
{
	typedef Vcltee::Teebasefuncedit::TBaseFunctionEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	void __fastcall PageControl1Change(System::TObject* Sender);
	
protected:
	virtual void __fastcall ApplyFormChanges();
	virtual void __fastcall SetFunction();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TAlligatorFuncEditor(System::Classes::TComponent* AOwner) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TAlligatorFuncEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TAlligatorFuncEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TAlligatorFuncEditor(HWND ParentWindow) : Vcltee::Teebasefuncedit::TBaseFunctionEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teealligatorfunceditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEALLIGATORFUNCEDITOR)
using namespace Vcltee::Teealligatorfunceditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeealligatorfunceditorHPP
