// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeColorLineEditor.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecolorlineeditorHPP
#define Vcltee_TeecolorlineeditorHPP

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
#include <VCLTee.TeeAxisToolEdit.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeePenDlg.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecolorlineeditor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TColorLineToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TColorLineToolEditor : public Vcltee::Teeaxistooledit::TAxisToolEditor
{
	typedef Vcltee::Teeaxistooledit::TAxisToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabValue;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* EValue;
	Vcl::Comctrls::TTabSheet* TabOptions;
	Vcl::Stdctrls::TCheckBox* CBAllowDrag;
	Vcl::Stdctrls::TCheckBox* CBDragRepaint;
	Vcl::Stdctrls::TCheckBox* CBNoLimitDrag;
	Vcl::Stdctrls::TCheckBox* CBDrawBehind;
	Vcl::Stdctrls::TCheckBox* CBDraw3D;
	Vcl::Stdctrls::TLabel* Label3;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabAnnotation;
	Vcl::Extctrls::TTimer* Timer1;
	Vcl::Stdctrls::TCheckBox* CBAnnValue;
	void __fastcall EValueChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	void __fastcall CBAllowDragClick(System::TObject* Sender);
	void __fastcall CBDragRepaintClick(System::TObject* Sender);
	void __fastcall CBNoLimitDragClick(System::TObject* Sender);
	void __fastcall CBDrawBehindClick(System::TObject* Sender);
	void __fastcall CBDraw3DClick(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall PageControl1GetImageIndex(System::TObject* Sender, int TabIndex, int &ImageIndex);
	void __fastcall Timer1Timer(System::TObject* Sender);
	void __fastcall CBAnnValueClick(System::TObject* Sender);
	
private:
	bool CreatingForm;
	Vcltee::Teetools::TColorLineTool* ColorLineTool;
	
public:
	void __fastcall HideTabs();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TColorLineToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TColorLineToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teeaxistooledit::TAxisToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TColorLineToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TColorLineToolEditor(HWND ParentWindow) : Vcltee::Teeaxistooledit::TAxisToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecolorlineeditor */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECOLORLINEEDITOR)
using namespace Vcltee::Teecolorlineeditor;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecolorlineeditorHPP
