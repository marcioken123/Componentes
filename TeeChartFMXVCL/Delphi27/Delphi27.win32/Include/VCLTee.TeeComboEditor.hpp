// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeComboEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecomboeditorHPP
#define Vcltee_TeecomboeditorHPP

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
#include <VCLTee.TeeTools.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <VCLTee.TeeCustomShapeEditor.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <Vcl.ExtCtrls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecomboeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TComboToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TComboToolEditor : public Vcl::Forms::TForm
{
	typedef Vcl::Forms::TForm inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabItems;
	Vcl::Comctrls::TTabSheet* TabFormat;
	Vcl::Stdctrls::TMemo* Items;
	Vcl::Extctrls::TPanel* Panel1;
	Vcl::Stdctrls::TLabel* Label1;
	Vcltee::Tecanvas::TComboFlat* ComboSelected;
	Vcl::Stdctrls::TCheckBox* CBAutoHide;
	void __fastcall FormShow(System::TObject* Sender);
	void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall ItemsChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall ComboSelectedChange(System::TObject* Sender);
	void __fastcall PageControl1GetImageIndex(System::TObject* Sender, int TabIndex, int &ImageIndex);
	void __fastcall CBAutoHideClick(System::TObject* Sender);
	
private:
	bool ICreating;
	Vcltee::Teetools::TTeeCombo* Combo;
	Vcltee::Teecustomshapeeditor::TFormTeeShape* ShapeForm;
public:
	/* TCustomForm.Create */ inline __fastcall virtual TComboToolEditor(System::Classes::TComponent* AOwner) : Vcl::Forms::TForm(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TComboToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcl::Forms::TForm(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TComboToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TComboToolEditor(HWND ParentWindow) : Vcl::Forms::TForm(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecomboeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECOMBOEDITOR)
using namespace Vcltee::Teecomboeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecomboeditorHPP
