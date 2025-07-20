// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCursorEdit.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecursoreditHPP
#define Vcltee_TeecursoreditHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
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
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePenDlg.hpp>
#include <VCLTee.TeeToolSeriesEdit.hpp>
#include <VCLTee.TeeAnnToolEdit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecursoredit
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCursorToolEditor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCursorToolEditor : public Vcltee::Teetoolseriesedit::TSeriesToolEditor
{
	typedef Vcltee::Teetoolseriesedit::TSeriesToolEditor inherited;
	
__published:
	Vcl::Comctrls::TPageControl* PageControl1;
	Vcl::Comctrls::TTabSheet* TabSheet1;
	Vcl::Comctrls::TTabSheet* TabSheet2;
	Vcl::Stdctrls::TCheckBox* CBZ;
	Vcl::Stdctrls::TCheckBox* CBSnap;
	Vcltee::Tecanvas::TComboFlat* CBSnapStyle;
	Vcl::Stdctrls::TLabel* Label5;
	Vcltee::Tecanvas::TComboFlat* CBStyle;
	Vcl::Comctrls::TTabSheet* TabSheet3;
	Vcl::Stdctrls::TCheckBox* CBFollow;
	Vcl::Stdctrls::TLabel* Label3;
	Vcl::Stdctrls::TEdit* EPixels;
	Vcl::Comctrls::TUpDown* UDClick;
	Vcl::Stdctrls::TLabel* Label4;
	Vcl::Stdctrls::TLabel* Label2;
	Vcl::Stdctrls::TEdit* Edit1;
	Vcl::Comctrls::TUpDown* UDHorizSize;
	Vcl::Stdctrls::TLabel* Label7;
	Vcl::Stdctrls::TEdit* Edit2;
	Vcl::Comctrls::TUpDown* UDVertSize;
	Vcl::Stdctrls::TLabel* Label9;
	Vcl::Stdctrls::TLabel* Label10;
	Vcl::Stdctrls::TEdit* EScope;
	Vcl::Comctrls::TUpDown* UDScope;
	Vcl::Stdctrls::TLabel* Label6;
	Vcltee::Tecanvas::TComboFlat* CBScopeStyle;
	Vcl::Comctrls::TTabSheet* TabBorder;
	Vcl::Comctrls::TTabSheet* TabAnnotation;
	Vcl::Stdctrls::TCheckBox* CBFullRepaint;
	HIDESBASE void __fastcall FormShow(System::TObject* Sender);
	HIDESBASE void __fastcall CBSeriesChange(System::TObject* Sender);
	void __fastcall CBStyleChange(System::TObject* Sender);
	void __fastcall CBSnapClick(System::TObject* Sender);
	void __fastcall CBFollowClick(System::TObject* Sender);
	HIDESBASE void __fastcall FormCreate(System::TObject* Sender);
	void __fastcall CBZClick(System::TObject* Sender);
	void __fastcall EPixelsChange(System::TObject* Sender);
	void __fastcall CBSnapStyleChange(System::TObject* Sender);
	void __fastcall Edit1Change(System::TObject* Sender);
	void __fastcall Edit2Change(System::TObject* Sender);
	void __fastcall EScopeChange(System::TObject* Sender);
	void __fastcall CBScopeStyleChange(System::TObject* Sender);
	void __fastcall PageControl1Change(System::TObject* Sender);
	void __fastcall CBFullRepaintClick(System::TObject* Sender);
	
private:
	Vcltee::Teetools::TCursorTool* CursorTool;
	Vcltee::Teependlg::TPenDialog* IBorderEditor;
	Vcltee::Teeanntooledit::TAnnotationToolEdit* IAnnEditor;
	void __fastcall EnableSnap();
	void __fastcall EnableScope();
public:
	/* TCustomForm.Create */ inline __fastcall virtual TCursorToolEditor(System::Classes::TComponent* AOwner) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner) { }
	/* TCustomForm.CreateNew */ inline __fastcall virtual TCursorToolEditor(System::Classes::TComponent* AOwner, int Dummy) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(AOwner, Dummy) { }
	/* TCustomForm.Destroy */ inline __fastcall virtual ~TCursorToolEditor() { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TCursorToolEditor(HWND ParentWindow) : Vcltee::Teetoolseriesedit::TSeriesToolEditor(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecursoredit */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECURSOREDIT)
using namespace Vcltee::Teecursoredit;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecursoreditHPP
