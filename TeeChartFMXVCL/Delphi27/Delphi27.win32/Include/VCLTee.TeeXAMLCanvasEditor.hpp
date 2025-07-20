// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeXAMLCanvasEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeexamlcanvaseditorHPP
#define Vcltee_TeexamlcanvaseditorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeeXAMLCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teexamlcanvaseditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TXAMLOptions;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TXAMLOptions : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TCheckBox* CB3D;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCloseQuery(System::TObject* Sender, bool &CanClose);
	
private:
	Vcltee::Teexamlcanvas::TXAMLExportFormat* XAML;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TXAMLOptions(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TXAMLOptions(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TXAMLOptions() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TXAMLOptions(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teexamlcanvaseditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEXAMLCANVASEDITOR)
using namespace Vcltee::Teexamlcanvaseditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeexamlcanvaseditorHPP
