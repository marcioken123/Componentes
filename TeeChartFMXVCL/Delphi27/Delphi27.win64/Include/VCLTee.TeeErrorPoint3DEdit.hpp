// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeErrorPoint3DEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_Teeerrorpoint3deditHPP
#define Vcltee_Teeerrorpoint3deditHPP

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
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeErrorPoint.hpp>
#include <VCLTee.ErrorBar.hpp>
#include <VCLTee.TeePoEdi.hpp>
#include <VCLTee.TeeConst.hpp>
#include <VCLTee.TeeProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeerrorpoint3dedit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TErrorPoint3DSeriesEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TErrorPoint3DSeriesEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Comctrls::TTabSheet* TabBorders;
	Vcl::Stdctrls::TListBox* LBBorders;
	Vcl::Stdctrls::TLabel* Label1;
	Vcl::Stdctrls::TEdit* SEBarwidth;
	Vcl::Extctrls::TRadioGroup* RGWidthUnit;
	Vcl::Comctrls::TUpDown* UDBarWidth;
	Vcl::Stdctrls::TCheckBox* CBColorEach;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall SEBarwidthChange(System::TObject* Sender);
	void __fastcall RGWidthUnitClick(System::TObject* Sender);
	void __fastcall CBColorEachClick(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall FormDestroy(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall LBBordersClick(System::TObject* Sender);
	
private:
	Vcltee::Teeerrorpoint::TCustomErrorPoint3DSeries* ErrorPoint3DSeries;
	Vcl::Forms::TCustomForm* FPointForm;
	Vcltee::Teependlg::TPenDialog* IPenEditor;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TErrorPoint3DSeriesEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TErrorPoint3DSeriesEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TErrorPoint3DSeriesEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TErrorPoint3DSeriesEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teeerrorpoint3dedit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEERRORPOINT3DEDIT)
using namespace Vcltee::Teeerrorpoint3dedit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_Teeerrorpoint3deditHPP
