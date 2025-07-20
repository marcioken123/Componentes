// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTransposeToolEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetransposetooleditorHPP
#define Vcltee_TeetransposetooleditorHPP

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
#include <Vcl.Buttons.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeTransposeTool.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetransposetooleditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGridTransposeToolEdit;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGridTransposeToolEdit : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* CBSeries;
	Vcl::Stdctrls::TButton* BTranspose;
	void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall BTransposeClick(System::TObject* Sender);
	void __fastcall FormShow(System::TObject* Sender);
	
private:
	Vcltee::Teetransposetool::TGridTransposeTool* Tool;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TGridTransposeToolEdit(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TGridTransposeToolEdit(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TGridTransposeToolEdit() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TGridTransposeToolEdit(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetransposetooleditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETRANSPOSETOOLEDITOR)
using namespace Vcltee::Teetransposetooleditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetransposetooleditorHPP
